import 'package:bloc/bloc.dart';
import 'package:themovieapp/models/top_rated_model.dart';
import 'package:themovieapp/repo/top_rated_repo.dart';
import 'package:themovieapp/toprated/bloc/top_rated_event.dart';

part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  TopRatedBloc() : super(TopRatedInitial()) {
    on<TopRatedFetchMovies>((event, emit) async {
      // TODO: implement event handler
      try {
        final List<TopRatedModel> movies =
            await TopRatedRepo().fetchTopRatedMovies();

        emit(TopRatedLoaded(movies));
      } catch (err) {
        emit(TopRatedError());
      }
    });

    on<TopRatedDelete>((event, emit) async {
      final currentState = state;
      if (currentState is TopRatedLoaded) {
        final updatedMovies = currentState.topmovies
            .where((movie) => movie != event.topmovies)
            .toList();
        emit(TopRatedLoaded(updatedMovies));
      }
    });
  }
}
