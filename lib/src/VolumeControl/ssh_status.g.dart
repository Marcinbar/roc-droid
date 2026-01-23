// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ssh_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VolumeStore on _VolumeStore, Store {
  late final _$_sshStatusAtom =
      Atom(name: '_VolumeStore._sshStatus', context: context);

  @override
  SSHStatus get _sshStatus {
    _$_sshStatusAtom.reportRead();
    return super._sshStatus;
  }

  @override
  set _sshStatus(SSHStatus value) {
    _$_sshStatusAtom.reportWrite(value, super._sshStatus, () {
      super._sshStatus = value;
    });
  }

  late final _$_volumeAtom =
      Atom(name: '_VolumeStore._volume', context: context);

  @override
  double get _volume {
    _$_volumeAtom.reportRead();
    return super._volume;
  }

  @override
  set _volume(double value) {
    _$_volumeAtom.reportWrite(value, super._volume, () {
      super._volume = value;
    });
  }

  late final _$_VolumeStoreActionController =
      ActionController(name: '_VolumeStore', context: context);

  @override
  void setStatus(SSHStatus status) {
    final _$actionInfo = _$_VolumeStoreActionController.startAction(
        name: '_VolumeStore.setStatus');
    try {
      return super.setStatus(status);
    } finally {
      _$_VolumeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVolume(double newVolume) {
    final _$actionInfo = _$_VolumeStoreActionController.startAction(
        name: '_VolumeStore.setVolume');
    try {
      return super.setVolume(newVolume);
    } finally {
      _$_VolumeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
