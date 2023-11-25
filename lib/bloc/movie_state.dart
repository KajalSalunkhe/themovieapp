part of 'movie_bloc.dart';

// @immutable
// sealed class MovieState {}

// final class MovieInitial extends MovieState {}

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<NewPlayingModel> movies;

  MovieLoaded(this.movies);
}

class MovieError extends MovieState {}
