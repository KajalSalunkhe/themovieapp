import 'package:bloc/bloc.dart';
import 'package:themovieapp/models/new_playing_model.dart';
import 'package:themovieapp/repo/playing_repo.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      // TODO: implement event handler
      try {
        final List<NewPlayingModel> movies = await PlayingRepo().fetchData();

        emit(MovieLoaded(movies));
      } catch (err) {
        emit(MovieError());
      }
    });

     on<DeleteMovies>((event, emit) async {
      final currentState = state;
      if (currentState is MovieLoaded) {
        final updatedMovies =
            currentState.movies.where((movie) => movie != event.movie).toList();
        emit(MovieLoaded(updatedMovies));
      }
    });
  }
}
