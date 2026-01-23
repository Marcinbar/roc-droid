import 'package:mobx/mobx.dart';
part 'ssh_status.g.dart';

enum SSHStatus {
  disconnected,
  connecting,
  connected,
  failed,
}

class VolumeStore = _VolumeStore with _$VolumeStore;

abstract class _VolumeStore with Store {
  @observable
  SSHStatus _sshStatus = SSHStatus.disconnected;

  @observable
  double _volume = 0.5;

  SSHStatus get sshStatus => _sshStatus;
  @action
  void setStatus(SSHStatus status) => _sshStatus = status;

  double get volume => _volume;
  @action
  void setVolume(double newVolume) => _volume = newVolume;
}
