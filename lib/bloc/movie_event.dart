part of 'movie_bloc.dart';

// @immutable
// sealed class MovieEvent {}

abstract class MovieEvent {}

class FetchMovies extends MovieEvent {}

class DeleteMovies extends MovieEvent {
  final NewPlayingModel movie; // Define movie parameter

  DeleteMovies(this.movie);
}
