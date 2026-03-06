// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repository_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RepositoryFailure {

 String get message;
/// Create a copy of RepositoryFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepositoryFailureCopyWith<RepositoryFailure> get copyWith => _$RepositoryFailureCopyWithImpl<RepositoryFailure>(this as RepositoryFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepositoryFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RepositoryFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $RepositoryFailureCopyWith<$Res>  {
  factory $RepositoryFailureCopyWith(RepositoryFailure value, $Res Function(RepositoryFailure) _then) = _$RepositoryFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RepositoryFailureCopyWithImpl<$Res>
    implements $RepositoryFailureCopyWith<$Res> {
  _$RepositoryFailureCopyWithImpl(this._self, this._then);

  final RepositoryFailure _self;
  final $Res Function(RepositoryFailure) _then;

/// Create a copy of RepositoryFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RepositoryFailure].
extension RepositoryFailurePatterns on RepositoryFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Database value)?  database,TResult Function( _NotFound value)?  notFound,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Database() when database != null:
return database(_that);case _NotFound() when notFound != null:
return notFound(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Database value)  database,required TResult Function( _NotFound value)  notFound,}){
final _that = this;
switch (_that) {
case _Database():
return database(_that);case _NotFound():
return notFound(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Database value)?  database,TResult? Function( _NotFound value)?  notFound,}){
final _that = this;
switch (_that) {
case _Database() when database != null:
return database(_that);case _NotFound() when notFound != null:
return notFound(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  database,TResult Function( String message)?  notFound,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Database() when database != null:
return database(_that.message);case _NotFound() when notFound != null:
return notFound(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  database,required TResult Function( String message)  notFound,}) {final _that = this;
switch (_that) {
case _Database():
return database(_that.message);case _NotFound():
return notFound(_that.message);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  database,TResult? Function( String message)?  notFound,}) {final _that = this;
switch (_that) {
case _Database() when database != null:
return database(_that.message);case _NotFound() when notFound != null:
return notFound(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Database implements RepositoryFailure {
  const _Database(this.message);
  

@override final  String message;

/// Create a copy of RepositoryFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DatabaseCopyWith<_Database> get copyWith => __$DatabaseCopyWithImpl<_Database>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Database&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RepositoryFailure.database(message: $message)';
}


}

/// @nodoc
abstract mixin class _$DatabaseCopyWith<$Res> implements $RepositoryFailureCopyWith<$Res> {
  factory _$DatabaseCopyWith(_Database value, $Res Function(_Database) _then) = __$DatabaseCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class __$DatabaseCopyWithImpl<$Res>
    implements _$DatabaseCopyWith<$Res> {
  __$DatabaseCopyWithImpl(this._self, this._then);

  final _Database _self;
  final $Res Function(_Database) _then;

/// Create a copy of RepositoryFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Database(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _NotFound implements RepositoryFailure {
  const _NotFound(this.message);
  

@override final  String message;

/// Create a copy of RepositoryFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotFoundCopyWith<_NotFound> get copyWith => __$NotFoundCopyWithImpl<_NotFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotFound&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RepositoryFailure.notFound(message: $message)';
}


}

/// @nodoc
abstract mixin class _$NotFoundCopyWith<$Res> implements $RepositoryFailureCopyWith<$Res> {
  factory _$NotFoundCopyWith(_NotFound value, $Res Function(_NotFound) _then) = __$NotFoundCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class __$NotFoundCopyWithImpl<$Res>
    implements _$NotFoundCopyWith<$Res> {
  __$NotFoundCopyWithImpl(this._self, this._then);

  final _NotFound _self;
  final $Res Function(_NotFound) _then;

/// Create a copy of RepositoryFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_NotFound(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
