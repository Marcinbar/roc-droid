// lib/src/ui/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _hostController = TextEditingController(text: '192.168.0.1');
  final _portController = TextEditingController(text: '22');
  final _usernameController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController();

  final _sourcePortController = TextEditingController();
  final _repairPortController = TextEditingController();

  final _sourcePortFocus = FocusNode();
  final _repairPortFocus = FocusNode();

  late SharedPreferences _prefs;
  bool _loading = true;
  bool _saving = false;

  // SSH volume control options
  bool _enableSSHVolume = false;

  // Keys
  static const _keyHost = 'conn_host';
  static const _keyPort = 'conn_port';
  static const _keyUser = 'conn_user';
  static const _keyPassword = 'conn_password';
  static const _keySourcePort = 'stream_source_port';
  static const _keyRepairPort = 'stream_repair_port';

  static const _keyEnableSSHVolume = 'enable_ssh_volume';

  @override
  void initState() {
    super.initState();
    _loadSettings();

    _sourcePortFocus.addListener(() {
      if (!_sourcePortFocus.hasFocus) _validatePort(_sourcePortController, 10001);
    });
    _repairPortFocus.addListener(() {
      if (!_repairPortFocus.hasFocus) _validatePort(_repairPortController, 10002);
    });
  }

  void _validatePort(TextEditingController controller, int defaultPort) {
    int port = int.tryParse(controller.text.trim()) ?? defaultPort;
    if (port < 1) port = 1;
    if (port > 65535) port = 65535;
    controller.text = port.toString();
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();

    // SSH
    final host = _prefs.getString(_keyHost) ?? '192.168.0.1';
    final port = _prefs.getInt(_keyPort) ?? 22;
    final user = _prefs.getString(_keyUser) ?? 'admin';
    final pass = _prefs.getString(_keyPassword) ?? '';

    // Streams
    final sourcePort = _prefs.getInt(_keySourcePort) ?? 10001;
    final repairPort = _prefs.getInt(_keyRepairPort) ?? 10002;

    // Volume control
    _enableSSHVolume = _prefs.getBool(_keyEnableSSHVolume) ?? false;

    _hostController.text = host;
    _portController.text = port.toString();
    _usernameController.text = user;
    _passwordController.text = pass;

    _sourcePortController.text = sourcePort.toString();
    _repairPortController.text = repairPort.toString();

    setState(() {
      _loading = false;
    });
  }

  String? _validate() {
    final host = _hostController.text.trim();
    final port = int.tryParse(_portController.text.trim());
    final user = _usernameController.text.trim();

    if (host.isEmpty) return 'Host is required';
    if (user.isEmpty) return 'Username is required';
    if (port == null || port < 1 || port > 65535) return 'Invalid SSH port';

    final srcPort = int.tryParse(_sourcePortController.text.trim());
    if (srcPort == null || srcPort < 1 || srcPort > 65535) return 'Invalid source stream port';

    final repPort = int.tryParse(_repairPortController.text.trim());
    if (repPort == null || repPort < 1 || repPort > 65535) return 'Invalid repair stream port';

    return null;
  }

  Future<void> _saveSettings() async {
    final err = _validate();
    if (err != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }

    setState(() => _saving = true);

    final host = _hostController.text.trim();
    final port = int.parse(_portController.text.trim());
    final user = _usernameController.text.trim();
    final pass = _passwordController.text;

    final srcPort = int.parse(_sourcePortController.text.trim());
    final repPort = int.parse(_repairPortController.text.trim());

    // save SSH
    await _prefs.setString(_keyHost, host);
    await _prefs.setInt(_keyPort, port);
    await _prefs.setString(_keyUser, user);
    await _prefs.setString(_keyPassword, pass);

    // save stream ports
    await _prefs.setInt(_keySourcePort, srcPort);
    await _prefs.setInt(_keyRepairPort, repPort);

    // save volume control options
    await _prefs.setBool(_keyEnableSSHVolume, _enableSSHVolume);

    setState(() => _saving = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved')),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _sourcePortController.dispose();
    _repairPortController.dispose();
    _sourcePortFocus.dispose();
    _repairPortFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'SSH Connection (Volume Control)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Enable SSH volume control'),
              value: _enableSSHVolume,
              onChanged: (v) => setState(() => _enableSSHVolume = v),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _hostController,
              decoration: const InputDecoration(
                labelText: 'Host',
                hintText: '192.168.0.1',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _portController,
              decoration: const InputDecoration(labelText: 'SSH Port'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 32),

            const Text(
              'Stream Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sourcePortController,
              focusNode: _sourcePortFocus,
              decoration: const InputDecoration(labelText: 'Source stream port'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: _repairPortController,
              focusNode: _repairPortFocus,
              decoration: const InputDecoration(labelText: 'Repair stream port'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saving ? null : _saveSettings,
              child: _saving
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
