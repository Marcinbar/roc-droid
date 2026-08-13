import 'package:dartssh2/dartssh2.dart';

import './ssh_status.dart';
import 'volume_commands.dart';

class RemoteVolumeController {
  final VolumeStore store;
  final String host;
  final int port;
  final String username;
  final String password;
  VolumeCommands commands;

  SSHClient? _client;
  bool _connecting = false;
  bool _disposed = false;
  DateTime _lastReconnectAttempt = DateTime.fromMillisecondsSinceEpoch(0);

  static const Duration _reconnectCooldown = Duration(seconds: 3);
  static const int _maxRetries = 3;

  void Function()? onReconnectFailed;

  RemoteVolumeController({
    required this.store,
    required this.host,
    required this.port,
    required this.username,
    required this.password,
    required this.commands,
    this.onReconnectFailed,
  });

  void _updateStatus(SSHStatus status) {
    store.setStatus(status);
  }

  Future<void> connect() async {
    if (_connecting || _disposed) return;
    if (_client != null) {
      _updateStatus(SSHStatus.connected);
      return;
    }
    if (DateTime.now().difference(_lastReconnectAttempt) < _reconnectCooldown) {
      throw Exception("SSH reconnect cooldown");
    }
    _lastReconnectAttempt = DateTime.now();

    _connecting = true;
    _updateStatus(SSHStatus.connecting);
    try {
      final socket = await SSHSocket.connect(host, port).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception("SSH connection timeout");
        },
      );

      _client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );
      _updateStatus(SSHStatus.connected);
    } catch (e) {
      _client = null;
      _updateStatus(SSHStatus.failed);
      onReconnectFailed?.call();
      rethrow;
    } finally {
      _connecting = false;
    }
  }

  Future<void> disconnect() async {
    try {
      _disposed = true;
      _client?.close();
    } on Object catch (_) {}
    _client = null;
    _updateStatus(SSHStatus.disconnected);
  }

  Future<void> _ensureConnected() async {
    if (_client != null) return;
    _updateStatus(SSHStatus.connecting);
    await connect();
  }

  Future<T> _runWithRetry<T>(Future<T> Function() action) async {
    int attempt = 0;

    while (true) {
      try {
        await _ensureConnected();
        return await action();
      } catch (e) {
        _client = null;
        attempt++;

        if (attempt >= _maxRetries || _disposed) {
          _updateStatus(SSHStatus.failed);
          rethrow;
        }

        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  Future<void> changeVolumeBy(int delta) async {
    final current = await getVolume();
    if (current == null) throw Exception();
    await _setVolumeInternal(current + delta);
  }

  Future<void> setAbsoluteVolume(int value) async {
    await _setVolumeInternal(value);
  }

  Future<void> _setVolumeInternal(int target) async {
    final clamped = target.clamp(0, 100);
    store.setVolume(clamped / 100);
    await _execCommand(commands.setVolume(clamped));
  }

  Future<void> _execCommand(String command) async {
    await _runWithRetry(() async {
      final session = await _client!.execute(command);
      await session.stdout.drain();
    });
  }

  Future<void> increase() => changeVolumeBy(5);
  Future<void> decrease() => changeVolumeBy(-5);

  Future<int?> getVolume() async {
    return _runWithRetry<int?>(() async {
      final session = await _client!.execute(commands.getVolume());

      final raw = await session.stdout.fold<List<int>>(
        [],
        (p, e) => p..addAll(e),
      );

      final output = String.fromCharCodes(raw);
      return commands.parseVolume(output);
    });
  }

  Future<void> setMute(bool isMuted) async {
    await _execCommand(commands.setMute(isMuted));
  }

  /// Toggle mute
  Future<void> toggleMute() async {
    await _execCommand(commands.toggleMute());
  }
}
