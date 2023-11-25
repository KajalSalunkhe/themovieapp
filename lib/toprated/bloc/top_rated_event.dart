
import 'package:themovieapp/models/top_rated_model.dart';

abstract class TopRatedEvent {}

class TopRatedFetchMovies extends TopRatedEvent {}

class TopRatedDelete extends TopRatedEvent {
  final TopRatedModel topmovies;
  TopRatedDelete(
    this.topmovies,
  );
}
