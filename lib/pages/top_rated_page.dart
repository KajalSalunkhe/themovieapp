import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themovieapp/constants/constants.dart';
import 'package:themovieapp/models/top_rated_model.dart';
import 'package:themovieapp/pages/description_page.dart';
import 'package:themovieapp/toprated/bloc/top_rated_bloc.dart';
import 'package:themovieapp/toprated/bloc/top_rated_event.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({super.key, required this.searchKeyword});
  final String searchKeyword;

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  List<TopRatedModel>? filteredMovies;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedBloc, TopRatedState>(
      builder: (context, state) {
        final TopRatedBloc topRatedBloc =
            BlocProvider.of<TopRatedBloc>(context);

        if (state is TopRatedInitial) {
          topRatedBloc.add(TopRatedFetchMovies()); // Trigger fetching movies
          return Center(child: CircularProgressIndicator());
        } else if (state is TopRatedLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TopRatedLoaded) {
          final List<TopRatedModel> movies = state.topmovies;
          //... handle UI with the fetched movies
          if (widget.searchKeyword.isNotEmpty) {
            filteredMovies = movies
                .where((movie) =>
                    (movie.title
                            ?.toLowerCase()
                            .contains(widget.searchKeyword) ??
                        false) ||
                    (movie.originalTitle
                            ?.toLowerCase()
                            .contains(widget.searchKeyword) ??
                        false))
                .toList();
          } else {
            filteredMovies =
                movies; 
          }
          if (filteredMovies != null && filteredMovies!.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TopRatedBloc>().add(TopRatedFetchMovies());
              },
              child: ListView.builder(
                itemCount: filteredMovies!.length,
                itemBuilder: (BuildContext context, int index) {
                  final movie = filteredMovies![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescriptionPage(
                            title: movie.title ?? "",
                            releaseDate: movie.releaseDate ?? "",
                            popularity: movie.popularity.toString(),
                            backgroundImageUrl:
                                "${Constants.imagePath}${movie.posterPath ?? ''}",
                            descriptionText: movie.overview ?? '',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.34,
                                height: 180,
                                child: Image.network(
                                  "${Constants.imagePath}${movie.backdropPath ?? ''}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.originalTitle ?? "",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                        height: 20), 
                                    Text(
                                      movie.overview ?? "",
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    final movieToDelete =
                                        filteredMovies![index];
                                    context
                                        .read<TopRatedBloc>()
                                        .add(TopRatedDelete(movieToDelete));
                                  });
                                },
                              ),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text(
                'No movies found.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
        } else if (state is TopRatedError) {
          return Center(child: Text('Failed to fetch movies.'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
