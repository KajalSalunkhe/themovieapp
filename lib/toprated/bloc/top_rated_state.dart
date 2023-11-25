part of 'top_rated_bloc.dart';

// @immutable
// sealed class TopRatedState {}

abstract class TopRatedState {}

final class TopRatedInitial extends TopRatedState {}

final class TopRatedLoading extends TopRatedState {}

class TopRatedLoaded extends TopRatedState {
  final List<TopRatedModel> topmovies;

  TopRatedLoaded(this.topmovies);
}

final class TopRatedError extends TopRatedState {}
