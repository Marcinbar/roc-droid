// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sender_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SenderConfig {

 CaptureSource get captureSource; String get receiverIP; int get receiverSourcePort; int get receiverRepairPort;
/// Create a copy of SenderConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SenderConfigCopyWith<SenderConfig> get copyWith => _$SenderConfigCopyWithImpl<SenderConfig>(this as SenderConfig, _$identity);

  /// Serializes this SenderConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SenderConfig&&(identical(other.captureSource, captureSource) || other.captureSource == captureSource)&&(identical(other.receiverIP, receiverIP) || other.receiverIP == receiverIP)&&(identical(other.receiverSourcePort, receiverSourcePort) || other.receiverSourcePort == receiverSourcePort)&&(identical(other.receiverRepairPort, receiverRepairPort) || other.receiverRepairPort == receiverRepairPort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,captureSource,receiverIP,receiverSourcePort,receiverRepairPort);

@override
String toString() {
  return 'SenderConfig(captureSource: $captureSource, receiverIP: $receiverIP, receiverSourcePort: $receiverSourcePort, receiverRepairPort: $receiverRepairPort)';
}


}

/// @nodoc
abstract mixin class $SenderConfigCopyWith<$Res>  {
  factory $SenderConfigCopyWith(SenderConfig value, $Res Function(SenderConfig) _then) = _$SenderConfigCopyWithImpl;
@useResult
$Res call({
 CaptureSource captureSource, String receiverIP, int receiverSourcePort, int receiverRepairPort
});




}
/// @nodoc
class _$SenderConfigCopyWithImpl<$Res>
    implements $SenderConfigCopyWith<$Res> {
  _$SenderConfigCopyWithImpl(this._self, this._then);

  final SenderConfig _self;
  final $Res Function(SenderConfig) _then;

/// Create a copy of SenderConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? captureSource = null,Object? receiverIP = null,Object? receiverSourcePort = null,Object? receiverRepairPort = null,}) {
  return _then(_self.copyWith(
captureSource: null == captureSource ? _self.captureSource : captureSource // ignore: cast_nullable_to_non_nullable
as CaptureSource,receiverIP: null == receiverIP ? _self.receiverIP : receiverIP // ignore: cast_nullable_to_non_nullable
as String,receiverSourcePort: null == receiverSourcePort ? _self.receiverSourcePort : receiverSourcePort // ignore: cast_nullable_to_non_nullable
as int,receiverRepairPort: null == receiverRepairPort ? _self.receiverRepairPort : receiverRepairPort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SenderConfig].
extension SenderConfigPatterns on SenderConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SenderConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SenderConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SenderConfig value)  $default,){
final _that = this;
switch (_that) {
case _SenderConfig():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SenderConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SenderConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CaptureSource captureSource,  String receiverIP,  int receiverSourcePort,  int receiverRepairPort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SenderConfig() when $default != null:
return $default(_that.captureSource,_that.receiverIP,_that.receiverSourcePort,_that.receiverRepairPort);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CaptureSource captureSource,  String receiverIP,  int receiverSourcePort,  int receiverRepairPort)  $default,) {final _that = this;
switch (_that) {
case _SenderConfig():
return $default(_that.captureSource,_that.receiverIP,_that.receiverSourcePort,_that.receiverRepairPort);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CaptureSource captureSource,  String receiverIP,  int receiverSourcePort,  int receiverRepairPort)?  $default,) {final _that = this;
switch (_that) {
case _SenderConfig() when $default != null:
return $default(_that.captureSource,_that.receiverIP,_that.receiverSourcePort,_that.receiverRepairPort);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SenderConfig implements SenderConfig {
  const _SenderConfig({required this.captureSource, required this.receiverIP, required this.receiverSourcePort, required this.receiverRepairPort});
  factory _SenderConfig.fromJson(Map<String, dynamic> json) => _$SenderConfigFromJson(json);

@override final  CaptureSource captureSource;
@override final  String receiverIP;
@override final  int receiverSourcePort;
@override final  int receiverRepairPort;

/// Create a copy of SenderConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SenderConfigCopyWith<_SenderConfig> get copyWith => __$SenderConfigCopyWithImpl<_SenderConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SenderConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SenderConfig&&(identical(other.captureSource, captureSource) || other.captureSource == captureSource)&&(identical(other.receiverIP, receiverIP) || other.receiverIP == receiverIP)&&(identical(other.receiverSourcePort, receiverSourcePort) || other.receiverSourcePort == receiverSourcePort)&&(identical(other.receiverRepairPort, receiverRepairPort) || other.receiverRepairPort == receiverRepairPort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,captureSource,receiverIP,receiverSourcePort,receiverRepairPort);

@override
String toString() {
  return 'SenderConfig(captureSource: $captureSource, receiverIP: $receiverIP, receiverSourcePort: $receiverSourcePort, receiverRepairPort: $receiverRepairPort)';
}


}

/// @nodoc
abstract mixin class _$SenderConfigCopyWith<$Res> implements $SenderConfigCopyWith<$Res> {
  factory _$SenderConfigCopyWith(_SenderConfig value, $Res Function(_SenderConfig) _then) = __$SenderConfigCopyWithImpl;
@override @useResult
$Res call({
 CaptureSource captureSource, String receiverIP, int receiverSourcePort, int receiverRepairPort
});




}
/// @nodoc
class __$SenderConfigCopyWithImpl<$Res>
    implements _$SenderConfigCopyWith<$Res> {
  __$SenderConfigCopyWithImpl(this._self, this._then);

  final _SenderConfig _self;
  final $Res Function(_SenderConfig) _then;

/// Create a copy of SenderConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? captureSource = null,Object? receiverIP = null,Object? receiverSourcePort = null,Object? receiverRepairPort = null,}) {
  return _then(_SenderConfig(
captureSource: null == captureSource ? _self.captureSource : captureSource // ignore: cast_nullable_to_non_nullable
as CaptureSource,receiverIP: null == receiverIP ? _self.receiverIP : receiverIP // ignore: cast_nullable_to_non_nullable
as String,receiverSourcePort: null == receiverSourcePort ? _self.receiverSourcePort : receiverSourcePort // ignore: cast_nullable_to_non_nullable
as int,receiverRepairPort: null == receiverRepairPort ? _self.receiverRepairPort : receiverRepairPort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
