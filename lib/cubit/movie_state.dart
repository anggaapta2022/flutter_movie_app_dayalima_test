part of 'movie_cubit.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieSuccess extends MovieState {
  final List dataMovie;
  final bool reachMax;
  MovieSuccess(this.dataMovie, this.reachMax);
}

class MovieFailure extends MovieState {
  final String error;
  MovieFailure(this.error);
}

class MovieInsetStatus extends MovieState {
  final String msg;
  MovieInsetStatus(this.msg);
}
