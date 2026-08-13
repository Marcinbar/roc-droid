// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_control_manager.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VolumeControlManager on _VolumeControlManager, Store {
  Computed<bool>? _$canUseRemoteVolumeComputed;

  @override
  bool get canUseRemoteVolume =>
      (_$canUseRemoteVolumeComputed ??= Computed<bool>(
        () => super.canUseRemoteVolume,
        name: '_VolumeControlManager.canUseRemoteVolume',
      )).value;

  late final _$useRemoteVolumeAtom = Atom(
    name: '_VolumeControlManager.useRemoteVolume',
    context: context,
  );

  @override
  bool get useRemoteVolume {
    _$useRemoteVolumeAtom.reportRead();
    return super.useRemoteVolume;
  }

  @override
  set useRemoteVolume(bool value) {
    _$useRemoteVolumeAtom.reportWrite(value, super.useRemoteVolume, () {
      super.useRemoteVolume = value;
    });
  }

  late final _$isMutedAtom = Atom(
    name: '_VolumeControlManager.isMuted',
    context: context,
  );

  @override
  bool get isMuted {
    _$isMutedAtom.reportRead();
    return super.isMuted;
  }

  @override
  set isMuted(bool value) {
    _$isMutedAtom.reportWrite(value, super.isMuted, () {
      super.isMuted = value;
    });
  }

  late final _$initAsyncAction = AsyncAction(
    '_VolumeControlManager.init',
    context: context,
  );

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$reloadSettingsAsyncAction = AsyncAction(
    '_VolumeControlManager.reloadSettings',
    context: context,
  );

  @override
  Future<void> reloadSettings() {
    return _$reloadSettingsAsyncAction.run(() => super.reloadSettings());
  }

  late final _$onVolumeDownAsyncAction = AsyncAction(
    '_VolumeControlManager.onVolumeDown',
    context: context,
  );

  @override
  Future<void> onVolumeDown() {
    return _$onVolumeDownAsyncAction.run(() => super.onVolumeDown());
  }

  late final _$setVolumeAsyncAction = AsyncAction(
    '_VolumeControlManager.setVolume',
    context: context,
  );

  @override
  Future<void> setVolume(double value) {
    return _$setVolumeAsyncAction.run(() => super.setVolume(value));
  }

  late final _$refreshVolumeAsyncAction = AsyncAction(
    '_VolumeControlManager.refreshVolume',
    context: context,
  );

  @override
  Future<void> refreshVolume() {
    return _$refreshVolumeAsyncAction.run(() => super.refreshVolume());
  }

  late final _$toggleMuteAsyncAction = AsyncAction(
    '_VolumeControlManager.toggleMute',
    context: context,
  );

  @override
  Future<void> toggleMute() {
    return _$toggleMuteAsyncAction.run(() => super.toggleMute());
  }

  late final _$_VolumeControlManagerActionController = ActionController(
    name: '_VolumeControlManager',
    context: context,
  );

  @override
  void onVolumeUpPressed() {
    final _$actionInfo = _$_VolumeControlManagerActionController.startAction(
      name: '_VolumeControlManager.onVolumeUpPressed',
    );
    try {
      return super.onVolumeUpPressed();
    } finally {
      _$_VolumeControlManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onVolumeUpReleased() {
    final _$actionInfo = _$_VolumeControlManagerActionController.startAction(
      name: '_VolumeControlManager.onVolumeUpReleased',
    );
    try {
      return super.onVolumeUpReleased();
    } finally {
      _$_VolumeControlManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onVolumeDownPressed() {
    final _$actionInfo = _$_VolumeControlManagerActionController.startAction(
      name: '_VolumeControlManager.onVolumeDownPressed',
    );
    try {
      return super.onVolumeDownPressed();
    } finally {
      _$_VolumeControlManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onVolumeDownReleased() {
    final _$actionInfo = _$_VolumeControlManagerActionController.startAction(
      name: '_VolumeControlManager.onVolumeDownReleased',
    );
    try {
      return super.onVolumeDownReleased();
    } finally {
      _$_VolumeControlManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
useRemoteVolume: ${useRemoteVolume},
isMuted: ${isMuted},
canUseRemoteVolume: ${canUseRemoteVolume}
    ''';
  }
}
