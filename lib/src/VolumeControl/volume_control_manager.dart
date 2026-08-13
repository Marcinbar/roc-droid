import 'dart:async';

import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './remote_volume_controller.dart';
import './ssh_status.dart';
import 'volume_commands.dart';

part 'volume_control_manager.g.dart';

class VolumeControlManager = _VolumeControlManager with _$VolumeControlManager;

abstract class _VolumeControlManager with Store {
  final VolumeStore store;
  static const _keyUseRemoteVolume = 'enable_ssh_volume';
  static const Duration _initialDelay = Duration(milliseconds: 300);
  static const Duration _repeatInterval = Duration(milliseconds: 120);

  final RemoteVolumeController remoteVolume;

  _VolumeControlManager({
    required this.remoteVolume,
    required this.store,
  });

  SharedPreferences? _prefs;

  // =========================
  // OBSERVABLE STATE
  // =========================

  @observable
  bool useRemoteVolume = false;

  @observable
  bool isMuted = false;
  // =========================
  // INIT / SETTINGS
  // =========================

  @action
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await reloadSettings();

    reaction<SSHStatus>(
      (_) => store.sshStatus,
      (status) {
        if (status == SSHStatus.connected) {
          refreshVolume();
        }
      },
    );
  }

  @action
  Future<void> reloadSettings() async {
    useRemoteVolume = _prefs!.getBool(_keyUseRemoteVolume) ?? false;

    final backend =
        _prefs!.getString('volume_backend') ?? VolumeBackend.pactl.name;

    remoteVolume.commands =
    backend == VolumeBackend.wpctl.name
        ? WpctlVolumeCommands()
        : PactlVolumeCommands();

    if (useRemoteVolume) {
      unawaited(remoteVolume.connect());
    } else {
      await remoteVolume.disconnect();
      store.setStatus(SSHStatus.disconnected);
    }
  }

  // =========================
  // HARDWARE BUTTONS
  // =========================

  bool _isBusy = false;

  Future<void> onVolumeUp() async {
    if (_isBusy) return;
    _isBusy = true;
    try {
      if (useRemoteVolume) {
        await remoteVolume.increase();
        await refreshVolume();
      } else {
        await FlutterVolumeController.raiseVolume(null);
        await _refreshSystemVolume();
      }
    } finally {
      _isBusy = false;
    }
  }

  @action
  Future<void> onVolumeDown() async {
    if (_isBusy) return;
    _isBusy = true;
    try {
      if (useRemoteVolume) {
        await remoteVolume.decrease();
        await refreshVolume();
      } else {
        await FlutterVolumeController.lowerVolume(null);
        await _refreshSystemVolume();
      }
    } finally {
      _isBusy = false;
    }
  }

  // =========================
  // SLIDER
  // =========================
  Timer? _volumeDebounce;

  @action
  Future<void> setVolume(double value) async {
    store.setVolume(value);
    _volumeDebounce?.cancel();
    _volumeDebounce = Timer(const Duration(milliseconds: 200), () async {
      if (useRemoteVolume) {
        await remoteVolume.setAbsoluteVolume((value * 100).round());
      } else {
        await FlutterVolumeController.setVolume(value);
      }
    });
  }

  // =========================
  // REFRESH
  // =========================

  @action
  Future<void> refreshVolume() async {
    if (!useRemoteVolume) {
      await _refreshSystemVolume();
      return;
    }

    try {
      final v = await remoteVolume.getVolume();
      if (v != null) {
        store.setVolume(v / 100.0);
      }
    } catch (_) {}
  }

  Future<void> _refreshSystemVolume() async {
    final v = await FlutterVolumeController.getVolume();
    if (v != null) {
      store.setVolume(v);
    }
  }
  // =========================
  // HOLD HANDLING
  // =========================

  Timer? _repeatTimerUp;
  Timer? _initialTimerUp;

  Timer? _repeatTimerDown;
  Timer? _initialTimerDown;

  @action
  void onVolumeUpPressed() {
    _initialTimerUp?.cancel();
    _repeatTimerUp?.cancel();

    _performVolumeUp();

    _initialTimerUp = Timer(_initialDelay, () {
      _repeatTimerUp = Timer.periodic(_repeatInterval, (_) {
        _performVolumeUp();
      });
    });
  }

  @action
  void onVolumeUpReleased() {
    _initialTimerUp?.cancel();
    _repeatTimerUp?.cancel();
  }

  @action
  void onVolumeDownPressed() {
    _initialTimerDown?.cancel();
    _repeatTimerDown?.cancel();

    _performVolumeDown();

    _initialTimerDown = Timer(_initialDelay, () {
      _repeatTimerDown = Timer.periodic(_repeatInterval, (_) {
        _performVolumeDown();
      });
    });
  }

  @action
  void onVolumeDownReleased() {
    _initialTimerDown?.cancel();
    _repeatTimerDown?.cancel();
  }

  Future<void> _performVolumeUp() async {
    if (_isBusy) return;
    _isBusy = true;
    try {
      if (useRemoteVolume) {
        await remoteVolume.increase();
        await refreshVolume();
      } else {
        await FlutterVolumeController.raiseVolume(null);
        await _refreshSystemVolume();
      }
    } finally {
      _isBusy = false;
    }
  }

  Future<void> _performVolumeDown() async {
    if (_isBusy) return;
    _isBusy = true;
    try {
      if (useRemoteVolume) {
        await remoteVolume.decrease();
        await refreshVolume();
      } else {
        await FlutterVolumeController.lowerVolume(null);
        await _refreshSystemVolume();
      }
    } finally {
      _isBusy = false;
    }
  }

  @action
  Future<void> toggleMute() async {
    if (useRemoteVolume) {
      await remoteVolume.setMute(!isMuted);
      isMuted = !isMuted;
    } else {}
  }

  @computed
  bool get canUseRemoteVolume =>
      useRemoteVolume && store.sshStatus == SSHStatus.connected;
}
