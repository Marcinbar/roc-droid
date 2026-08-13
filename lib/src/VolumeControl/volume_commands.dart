enum VolumeBackend {
  pactl,
  wpctl,
}

abstract class VolumeCommands {
  String getVolume();
  int? parseVolume(String output);

  String setVolume(int volume);
  String setMute(bool mute);
  String toggleMute();
}

class PactlVolumeCommands implements VolumeCommands {
  @override
  int? parseVolume(String output) {
    final match = RegExp(r'(\d+)%').firstMatch(output);
    return match == null ? null : int.parse(match.group(1)!);
  }
  @override
  String getVolume() =>
      'pactl get-sink-volume @DEFAULT_SINK@';

  @override
  String setVolume(int volume) =>
      'pactl set-sink-volume @DEFAULT_SINK@ ${volume.clamp(0, 100)}%';

  @override
  String setMute(bool mute) =>
      'pactl set-sink-mute @DEFAULT_SINK@ ${mute ? "true" : "false"}';

  @override
  String toggleMute() =>
      'pactl set-sink-mute @DEFAULT_SINK@ toggle';
}

class WpctlVolumeCommands implements VolumeCommands {
  @override
  int? parseVolume(String output) {
    final match = RegExp(r'([\d.]+)').firstMatch(output);

    if (match == null) return null;

    final value = double.tryParse(match.group(1)!);
    if (value == null) return null;

    return (value * 100).round();
  }
  @override
  String getVolume() =>
      'wpctl get-volume @DEFAULT_SINK@';

  @override
  String setVolume(int volume) =>
      'wpctl set-volume @DEFAULT_SINK@ ${(volume.clamp(0,100) / 100).toStringAsFixed(2)}';

  @override
  String setMute(bool mute) =>
      'wpctl set-mute @DEFAULT_SINK@ ${mute ? "1" : "0"}';

  @override
  String toggleMute() =>
      'wpctl set-mute @DEFAULT_SINK@ toggle';
}