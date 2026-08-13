import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../VolumeControl/hardware_buttons.dart';
import '../VolumeControl/remote_volume_controller.dart';
import '../VolumeControl/ssh_status.dart';
import '../VolumeControl/volume_commands.dart';
import '../VolumeControl/volume_control_manager.dart';
import '../dto.dart';
import '../model.dart';
import 'components/roc_snackbar.dart';
import 'components/roc_ssh_status_icon.dart';
import 'components/roc_volume_bar.dart';
import 'fragments/roc_bottom_navigation_bar.dart';
import 'localization/app_localizations.g.dart';
import 'pages/about_page.dart';
import 'pages/receiver_page.dart';
import 'pages/sender_page.dart';
import 'pages/settings_page.dart';
import 'styles/roc_colors.dart';
import 'utils/roc_keys.dart';

class MainScreen extends StatefulWidget {
  // Controls the appearance of the floating test button
  final bool _addTestButton = false;
  final ModelRoot _modelRoot;
  const MainScreen({required ModelRoot modelRoot}) : _modelRoot = modelRoot;
  @override
  State<MainScreen> createState() => _MainScreenState(
        addTestButton: _addTestButton,
        modelRoot: _modelRoot,
      );
}

class _MainScreenState extends State<MainScreen> {
  static const _keyVolumeBackend = 'volume_backend';
  final bool _addTestButton;
  final ModelRoot _modelRoot;
  final List<Widget> _pages;
  int _selectedPage = 0;
  late VolumeControlManager _volumeManager;
  _MainScreenState({
    required bool addTestButton,
    required ModelRoot modelRoot,
  })  : _addTestButton = addTestButton,
        _modelRoot = modelRoot,
        _pages = [
          ReceiverPage(modelRoot),
          SenderPage(modelRoot),
        ] {
    // Subscribe to model failure event (coming from backend failure event).
    _modelRoot.failureEvent.subscribe((args) {
      var message = switch (args.code) {
        ErrorCode.permissionError =>
          AppLocalizations.of(context)!.permissionError,
        ErrorCode.deviceError => AppLocalizations.of(context)!.deviceError,
        ErrorCode.networkError => AppLocalizations.of(context)!.networkError,
        ErrorCode.dbError => AppLocalizations.of(context)!.dbError,
        ErrorCode.notFoundError => AppLocalizations.of(context)!.notFoundError,
        ErrorCode.internalError => AppLocalizations.of(context)!.internalError,
      };
      RocSnackbar.showMessage(context: context, message: message);
    });
  }
  void _onTabTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  Future<void> _onSettingsClosed() async {
    await _volumeManager.reloadSettings();
    _initHardwareButtons();
  }

  RemoteVolumeController? remoteVolume;
  @override
  void initState() {
    super.initState();
    unawaited(_init());
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final store = VolumeStore();
    final backend =
        prefs.getString(_keyVolumeBackend) ?? VolumeBackend.pactl.name;

    final commands = backend == VolumeBackend.wpctl.name
        ? WpctlVolumeCommands()
        : PactlVolumeCommands();

    remoteVolume = RemoteVolumeController(
      store: store,
      host: prefs.getString('conn_host') ?? '192.168.0.1',
      port: prefs.getInt('conn_port') ?? 22,
      username: prefs.getString('conn_user') ?? 'admin',
      password: prefs.getString('conn_password') ?? '',
      commands: commands,
      onReconnectFailed: () {
        RocSnackbar.showMessage(
          context: context,
          message: 'SSH reconnect failed!',
        );
      },
    );

    _volumeManager = VolumeControlManager(
      remoteVolume: remoteVolume!,
      store: store,
    );
    await _volumeManager.init();
    _initHardwareButtons();
    if (mounted) setState(() {});
  }

  void _initHardwareButtons() {
    HardwareButtons.init(
      onVolUpDown: () {
        _volumeManager.onVolumeUpPressed();
      },
      onVolUpUp: () {
        _volumeManager.onVolumeUpReleased();
      },
      onVolDownDown: () {
        _volumeManager.onVolumeDownPressed();
      },
      onVolDownUp: () {
        _volumeManager.onVolumeDownReleased();
      },
    );
  }

  @override
  void dispose() {
    remoteVolume?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (remoteVolume == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBarWithSSH(
          modelRoot: _modelRoot,
          onSettingsClosed: _onSettingsClosed,
          volumeManager: _volumeManager,
        ),
        body: Center(
          child: _pages.elementAt(_selectedPage),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Observer(
              builder: (_) {
                if (!_volumeManager.canUseRemoteVolume) {
                  return const SizedBox.shrink();
                }
                return VolumeBar(
                  volume: _volumeManager.store.volume,
                  isMuted: _volumeManager.isMuted,
                  onChanged: (v) => _volumeManager.setVolume(v),
                  onMuteToggle: () async => await _volumeManager.toggleMute(),
                );
              },
            ),
            Observer(
              builder: (_) => RocBottomNavigationBar(
                context: context,
                selectedPage: _selectedPage,
                onTabTapped: _onTabTapped,
                receiverIsStarted: _modelRoot.receiver.isStarted,
                senderIsStarted: _modelRoot.sender.isStarted,
              ),
            ),
          ],
        ),
        floatingActionButton:
            _addTestButton ? _TestFloatingButton(_modelRoot) : null,
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class AppBarWithSSH extends StatelessWidget implements PreferredSizeWidget {
  final ModelRoot modelRoot;
  final VoidCallback onSettingsClosed;
  final VolumeControlManager volumeManager;

  const AppBarWithSSH({
    super.key,
    required this.modelRoot,
    required this.onSettingsClosed,
    required this.volumeManager,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => AppBar(
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          SshStatusText(status: volumeManager.store.sshStatus),
          PopupMenuButton<String>(
            key: RocKeys.sidePaneKey,
            icon: Icon(Icons.more_vert, color: RocColors.white),
            onSelected: (value) async {
              switch (value) {
                case 'settings':
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                  onSettingsClosed();
                  break;
                case 'about':
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutPage(modelRoot),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              PopupMenuItem(
                value: 'about',
                child: Text('About'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Roc's custom test floating button widget.
class _TestFloatingButton extends StatelessWidget {
  final ModelRoot _modelRoot;
  _TestFloatingButton(ModelRoot modelRoot) : _modelRoot = modelRoot;
  String formRandomIP() {
    return '${Random().nextInt(99)}.${Random().nextInt(99)}.'
        '${Random().nextInt(99)}.${Random().nextInt(99)}';
  }

  List<String> formRandomIPs() {
    return List<String>.generate(
        Random().nextInt(4), (index) => formRandomIP());
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async => {
        await _modelRoot.receiver.setSourcePort(Random().nextInt(99999)),
        await _modelRoot.receiver.setRepairPort(Random().nextInt(99999)),
        await _modelRoot.sender.setSourcePort(Random().nextInt(99999)),
        await _modelRoot.sender.setRepairPort(Random().nextInt(99999)),
      },
      icon: Icon(Icons.settings),
      iconSize: 30.0,
    );
  }
}
