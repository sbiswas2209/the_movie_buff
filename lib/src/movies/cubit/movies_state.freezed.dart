// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movies_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoviesState {

 List<Movie>? get popularMovies; List<Movie>? get nowPlayingMovies; int get popularMoviesPage; int get nowPlayingMoviesPage; bool get hasReachedPopularMoviesMax; bool get hasReachedNowPlayingMoviesMax; bool get isFetchingPopular; bool get isFetchingNowPlaying; String get errorMessage;
/// Create a copy of MoviesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoviesStateCopyWith<MoviesState> get copyWith => _$MoviesStateCopyWithImpl<MoviesState>(this as MoviesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoviesState&&const DeepCollectionEquality().equals(other.popularMovies, popularMovies)&&const DeepCollectionEquality().equals(other.nowPlayingMovies, nowPlayingMovies)&&(identical(other.popularMoviesPage, popularMoviesPage) || other.popularMoviesPage == popularMoviesPage)&&(identical(other.nowPlayingMoviesPage, nowPlayingMoviesPage) || other.nowPlayingMoviesPage == nowPlayingMoviesPage)&&(identical(other.hasReachedPopularMoviesMax, hasReachedPopularMoviesMax) || other.hasReachedPopularMoviesMax == hasReachedPopularMoviesMax)&&(identical(other.hasReachedNowPlayingMoviesMax, hasReachedNowPlayingMoviesMax) || other.hasReachedNowPlayingMoviesMax == hasReachedNowPlayingMoviesMax)&&(identical(other.isFetchingPopular, isFetchingPopular) || other.isFetchingPopular == isFetchingPopular)&&(identical(other.isFetchingNowPlaying, isFetchingNowPlaying) || other.isFetchingNowPlaying == isFetchingNowPlaying)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(popularMovies),const DeepCollectionEquality().hash(nowPlayingMovies),popularMoviesPage,nowPlayingMoviesPage,hasReachedPopularMoviesMax,hasReachedNowPlayingMoviesMax,isFetchingPopular,isFetchingNowPlaying,errorMessage);

@override
String toString() {
  return 'MoviesState(popularMovies: $popularMovies, nowPlayingMovies: $nowPlayingMovies, popularMoviesPage: $popularMoviesPage, nowPlayingMoviesPage: $nowPlayingMoviesPage, hasReachedPopularMoviesMax: $hasReachedPopularMoviesMax, hasReachedNowPlayingMoviesMax: $hasReachedNowPlayingMoviesMax, isFetchingPopular: $isFetchingPopular, isFetchingNowPlaying: $isFetchingNowPlaying, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $MoviesStateCopyWith<$Res>  {
  factory $MoviesStateCopyWith(MoviesState value, $Res Function(MoviesState) _then) = _$MoviesStateCopyWithImpl;
@useResult
$Res call({
 List<Movie>? popularMovies, List<Movie>? nowPlayingMovies, int popularMoviesPage, int nowPlayingMoviesPage, bool hasReachedPopularMoviesMax, bool hasReachedNowPlayingMoviesMax, bool isFetchingPopular, bool isFetchingNowPlaying, String errorMessage
});




}
/// @nodoc
class _$MoviesStateCopyWithImpl<$Res>
    implements $MoviesStateCopyWith<$Res> {
  _$MoviesStateCopyWithImpl(this._self, this._then);

  final MoviesState _self;
  final $Res Function(MoviesState) _then;

/// Create a copy of MoviesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? popularMovies = freezed,Object? nowPlayingMovies = freezed,Object? popularMoviesPage = null,Object? nowPlayingMoviesPage = null,Object? hasReachedPopularMoviesMax = null,Object? hasReachedNowPlayingMoviesMax = null,Object? isFetchingPopular = null,Object? isFetchingNowPlaying = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
popularMovies: freezed == popularMovies ? _self.popularMovies : popularMovies // ignore: cast_nullable_to_non_nullable
as List<Movie>?,nowPlayingMovies: freezed == nowPlayingMovies ? _self.nowPlayingMovies : nowPlayingMovies // ignore: cast_nullable_to_non_nullable
as List<Movie>?,popularMoviesPage: null == popularMoviesPage ? _self.popularMoviesPage : popularMoviesPage // ignore: cast_nullable_to_non_nullable
as int,nowPlayingMoviesPage: null == nowPlayingMoviesPage ? _self.nowPlayingMoviesPage : nowPlayingMoviesPage // ignore: cast_nullable_to_non_nullable
as int,hasReachedPopularMoviesMax: null == hasReachedPopularMoviesMax ? _self.hasReachedPopularMoviesMax : hasReachedPopularMoviesMax // ignore: cast_nullable_to_non_nullable
as bool,hasReachedNowPlayingMoviesMax: null == hasReachedNowPlayingMoviesMax ? _self.hasReachedNowPlayingMoviesMax : hasReachedNowPlayingMoviesMax // ignore: cast_nullable_to_non_nullable
as bool,isFetchingPopular: null == isFetchingPopular ? _self.isFetchingPopular : isFetchingPopular // ignore: cast_nullable_to_non_nullable
as bool,isFetchingNowPlaying: null == isFetchingNowPlaying ? _self.isFetchingNowPlaying : isFetchingNowPlaying // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MoviesState].
extension MoviesStatePatterns on MoviesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoviesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoviesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoviesState value)  $default,){
final _that = this;
switch (_that) {
case _MoviesState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoviesState value)?  $default,){
final _that = this;
switch (_that) {
case _MoviesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Movie>? popularMovies,  List<Movie>? nowPlayingMovies,  int popularMoviesPage,  int nowPlayingMoviesPage,  bool hasReachedPopularMoviesMax,  bool hasReachedNowPlayingMoviesMax,  bool isFetchingPopular,  bool isFetchingNowPlaying,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoviesState() when $default != null:
return $default(_that.popularMovies,_that.nowPlayingMovies,_that.popularMoviesPage,_that.nowPlayingMoviesPage,_that.hasReachedPopularMoviesMax,_that.hasReachedNowPlayingMoviesMax,_that.isFetchingPopular,_that.isFetchingNowPlaying,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Movie>? popularMovies,  List<Movie>? nowPlayingMovies,  int popularMoviesPage,  int nowPlayingMoviesPage,  bool hasReachedPopularMoviesMax,  bool hasReachedNowPlayingMoviesMax,  bool isFetchingPopular,  bool isFetchingNowPlaying,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _MoviesState():
return $default(_that.popularMovies,_that.nowPlayingMovies,_that.popularMoviesPage,_that.nowPlayingMoviesPage,_that.hasReachedPopularMoviesMax,_that.hasReachedNowPlayingMoviesMax,_that.isFetchingPopular,_that.isFetchingNowPlaying,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Movie>? popularMovies,  List<Movie>? nowPlayingMovies,  int popularMoviesPage,  int nowPlayingMoviesPage,  bool hasReachedPopularMoviesMax,  bool hasReachedNowPlayingMoviesMax,  bool isFetchingPopular,  bool isFetchingNowPlaying,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _MoviesState() when $default != null:
return $default(_that.popularMovies,_that.nowPlayingMovies,_that.popularMoviesPage,_that.nowPlayingMoviesPage,_that.hasReachedPopularMoviesMax,_that.hasReachedNowPlayingMoviesMax,_that.isFetchingPopular,_that.isFetchingNowPlaying,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _MoviesState implements MoviesState {
  const _MoviesState({final  List<Movie>? popularMovies, final  List<Movie>? nowPlayingMovies, this.popularMoviesPage = 1, this.nowPlayingMoviesPage = 1, this.hasReachedPopularMoviesMax = false, this.hasReachedNowPlayingMoviesMax = false, this.isFetchingPopular = false, this.isFetchingNowPlaying = false, this.errorMessage = ''}): _popularMovies = popularMovies,_nowPlayingMovies = nowPlayingMovies;
  

 final  List<Movie>? _popularMovies;
@override List<Movie>? get popularMovies {
  final value = _popularMovies;
  if (value == null) return null;
  if (_popularMovies is EqualUnmodifiableListView) return _popularMovies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Movie>? _nowPlayingMovies;
@override List<Movie>? get nowPlayingMovies {
  final value = _nowPlayingMovies;
  if (value == null) return null;
  if (_nowPlayingMovies is EqualUnmodifiableListView) return _nowPlayingMovies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  int popularMoviesPage;
@override@JsonKey() final  int nowPlayingMoviesPage;
@override@JsonKey() final  bool hasReachedPopularMoviesMax;
@override@JsonKey() final  bool hasReachedNowPlayingMoviesMax;
@override@JsonKey() final  bool isFetchingPopular;
@override@JsonKey() final  bool isFetchingNowPlaying;
@override@JsonKey() final  String errorMessage;

/// Create a copy of MoviesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoviesStateCopyWith<_MoviesState> get copyWith => __$MoviesStateCopyWithImpl<_MoviesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoviesState&&const DeepCollectionEquality().equals(other._popularMovies, _popularMovies)&&const DeepCollectionEquality().equals(other._nowPlayingMovies, _nowPlayingMovies)&&(identical(other.popularMoviesPage, popularMoviesPage) || other.popularMoviesPage == popularMoviesPage)&&(identical(other.nowPlayingMoviesPage, nowPlayingMoviesPage) || other.nowPlayingMoviesPage == nowPlayingMoviesPage)&&(identical(other.hasReachedPopularMoviesMax, hasReachedPopularMoviesMax) || other.hasReachedPopularMoviesMax == hasReachedPopularMoviesMax)&&(identical(other.hasReachedNowPlayingMoviesMax, hasReachedNowPlayingMoviesMax) || other.hasReachedNowPlayingMoviesMax == hasReachedNowPlayingMoviesMax)&&(identical(other.isFetchingPopular, isFetchingPopular) || other.isFetchingPopular == isFetchingPopular)&&(identical(other.isFetchingNowPlaying, isFetchingNowPlaying) || other.isFetchingNowPlaying == isFetchingNowPlaying)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_popularMovies),const DeepCollectionEquality().hash(_nowPlayingMovies),popularMoviesPage,nowPlayingMoviesPage,hasReachedPopularMoviesMax,hasReachedNowPlayingMoviesMax,isFetchingPopular,isFetchingNowPlaying,errorMessage);

@override
String toString() {
  return 'MoviesState(popularMovies: $popularMovies, nowPlayingMovies: $nowPlayingMovies, popularMoviesPage: $popularMoviesPage, nowPlayingMoviesPage: $nowPlayingMoviesPage, hasReachedPopularMoviesMax: $hasReachedPopularMoviesMax, hasReachedNowPlayingMoviesMax: $hasReachedNowPlayingMoviesMax, isFetchingPopular: $isFetchingPopular, isFetchingNowPlaying: $isFetchingNowPlaying, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$MoviesStateCopyWith<$Res> implements $MoviesStateCopyWith<$Res> {
  factory _$MoviesStateCopyWith(_MoviesState value, $Res Function(_MoviesState) _then) = __$MoviesStateCopyWithImpl;
@override @useResult
$Res call({
 List<Movie>? popularMovies, List<Movie>? nowPlayingMovies, int popularMoviesPage, int nowPlayingMoviesPage, bool hasReachedPopularMoviesMax, bool hasReachedNowPlayingMoviesMax, bool isFetchingPopular, bool isFetchingNowPlaying, String errorMessage
});




}
/// @nodoc
class __$MoviesStateCopyWithImpl<$Res>
    implements _$MoviesStateCopyWith<$Res> {
  __$MoviesStateCopyWithImpl(this._self, this._then);

  final _MoviesState _self;
  final $Res Function(_MoviesState) _then;

/// Create a copy of MoviesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? popularMovies = freezed,Object? nowPlayingMovies = freezed,Object? popularMoviesPage = null,Object? nowPlayingMoviesPage = null,Object? hasReachedPopularMoviesMax = null,Object? hasReachedNowPlayingMoviesMax = null,Object? isFetchingPopular = null,Object? isFetchingNowPlaying = null,Object? errorMessage = null,}) {
  return _then(_MoviesState(
popularMovies: freezed == popularMovies ? _self._popularMovies : popularMovies // ignore: cast_nullable_to_non_nullable
as List<Movie>?,nowPlayingMovies: freezed == nowPlayingMovies ? _self._nowPlayingMovies : nowPlayingMovies // ignore: cast_nullable_to_non_nullable
as List<Movie>?,popularMoviesPage: null == popularMoviesPage ? _self.popularMoviesPage : popularMoviesPage // ignore: cast_nullable_to_non_nullable
as int,nowPlayingMoviesPage: null == nowPlayingMoviesPage ? _self.nowPlayingMoviesPage : nowPlayingMoviesPage // ignore: cast_nullable_to_non_nullable
as int,hasReachedPopularMoviesMax: null == hasReachedPopularMoviesMax ? _self.hasReachedPopularMoviesMax : hasReachedPopularMoviesMax // ignore: cast_nullable_to_non_nullable
as bool,hasReachedNowPlayingMoviesMax: null == hasReachedNowPlayingMoviesMax ? _self.hasReachedNowPlayingMoviesMax : hasReachedNowPlayingMoviesMax // ignore: cast_nullable_to_non_nullable
as bool,isFetchingPopular: null == isFetchingPopular ? _self.isFetchingPopular : isFetchingPopular // ignore: cast_nullable_to_non_nullable
as bool,isFetchingNowPlaying: null == isFetchingNowPlaying ? _self.isFetchingNowPlaying : isFetchingNowPlaying // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
