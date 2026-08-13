// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receiver_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceiverConfig {

 int get sourcePort; int get repairPort;
/// Create a copy of ReceiverConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiverConfigCopyWith<ReceiverConfig> get copyWith => _$ReceiverConfigCopyWithImpl<ReceiverConfig>(this as ReceiverConfig, _$identity);

  /// Serializes this ReceiverConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiverConfig&&(identical(other.sourcePort, sourcePort) || other.sourcePort == sourcePort)&&(identical(other.repairPort, repairPort) || other.repairPort == repairPort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourcePort,repairPort);

@override
String toString() {
  return 'ReceiverConfig(sourcePort: $sourcePort, repairPort: $repairPort)';
}


}

/// @nodoc
abstract mixin class $ReceiverConfigCopyWith<$Res>  {
  factory $ReceiverConfigCopyWith(ReceiverConfig value, $Res Function(ReceiverConfig) _then) = _$ReceiverConfigCopyWithImpl;
@useResult
$Res call({
 int sourcePort, int repairPort
});




}
/// @nodoc
class _$ReceiverConfigCopyWithImpl<$Res>
    implements $ReceiverConfigCopyWith<$Res> {
  _$ReceiverConfigCopyWithImpl(this._self, this._then);

  final ReceiverConfig _self;
  final $Res Function(ReceiverConfig) _then;

/// Create a copy of ReceiverConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourcePort = null,Object? repairPort = null,}) {
  return _then(_self.copyWith(
sourcePort: null == sourcePort ? _self.sourcePort : sourcePort // ignore: cast_nullable_to_non_nullable
as int,repairPort: null == repairPort ? _self.repairPort : repairPort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceiverConfig].
extension ReceiverConfigPatterns on ReceiverConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceiverConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceiverConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceiverConfig value)  $default,){
final _that = this;
switch (_that) {
case _ReceiverConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceiverConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ReceiverConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sourcePort,  int repairPort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceiverConfig() when $default != null:
return $default(_that.sourcePort,_that.repairPort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sourcePort,  int repairPort)  $default,) {final _that = this;
switch (_that) {
case _ReceiverConfig():
return $default(_that.sourcePort,_that.repairPort);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sourcePort,  int repairPort)?  $default,) {final _that = this;
switch (_that) {
case _ReceiverConfig() when $default != null:
return $default(_that.sourcePort,_that.repairPort);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReceiverConfig implements ReceiverConfig {
  const _ReceiverConfig({required this.sourcePort, required this.repairPort});
  factory _ReceiverConfig.fromJson(Map<String, dynamic> json) => _$ReceiverConfigFromJson(json);

@override final  int sourcePort;
@override final  int repairPort;

/// Create a copy of ReceiverConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiverConfigCopyWith<_ReceiverConfig> get copyWith => __$ReceiverConfigCopyWithImpl<_ReceiverConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiverConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiverConfig&&(identical(other.sourcePort, sourcePort) || other.sourcePort == sourcePort)&&(identical(other.repairPort, repairPort) || other.repairPort == repairPort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourcePort,repairPort);

@override
String toString() {
  return 'ReceiverConfig(sourcePort: $sourcePort, repairPort: $repairPort)';
}


}

/// @nodoc
abstract mixin class _$ReceiverConfigCopyWith<$Res> implements $ReceiverConfigCopyWith<$Res> {
  factory _$ReceiverConfigCopyWith(_ReceiverConfig value, $Res Function(_ReceiverConfig) _then) = __$ReceiverConfigCopyWithImpl;
@override @useResult
$Res call({
 int sourcePort, int repairPort
});




}
/// @nodoc
class __$ReceiverConfigCopyWithImpl<$Res>
    implements _$ReceiverConfigCopyWith<$Res> {
  __$ReceiverConfigCopyWithImpl(this._self, this._then);

  final _ReceiverConfig _self;
  final $Res Function(_ReceiverConfig) _then;

/// Create a copy of ReceiverConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourcePort = null,Object? repairPort = null,}) {
  return _then(_ReceiverConfig(
sourcePort: null == sourcePort ? _self.sourcePort : sourcePort // ignore: cast_nullable_to_non_nullable
as int,repairPort: null == repairPort ? _self.repairPort : repairPort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
