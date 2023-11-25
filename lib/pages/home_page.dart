import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themovieapp/bloc/movie_bloc.dart';
import 'package:themovieapp/models/new_playing_model.dart';
import 'package:themovieapp/pages/movie_list.dart';
import 'package:themovieapp/pages/top_rated_page.dart';
import 'package:themovieapp/toprated/bloc/top_rated_bloc.dart';
import 'package:themovieapp/widgets/search_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  String searchKeyword = ''; 
  List<NewPlayingModel>? filteredMovies; 
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildCurrentTab() {
    if (_currentIndex == 0) {
      return MovieList(searchKeyword: searchKeyword);
    } else {
      return TopRatedPage(searchKeyword: searchKeyword);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[600],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 10),
        child: Column(
          children: [
            AppBar(
                backgroundColor: Colors.amber[600],
                elevation: 1.0,
                title: SearchTextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchKeyword = value.toLowerCase();
                    });
                  },
                  onClear: () {
                    setState(() {
                      searchController.clear();
                      searchKeyword = '';
                    });
                  },
                  hintText: 'Search',
                )),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
          ],
        ),
      ),
      body: MultiBlocProvider(providers: [
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(),
        ),
        BlocProvider<TopRatedBloc>(
          create: (context) => TopRatedBloc(),
        ),
      ], child: _buildCurrentTab()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber[600],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedFontSize: 16, 
        unselectedFontSize: 14, 
        selectedItemColor:
            Colors.black, 
        unselectedItemColor:
            Colors.grey, 
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal), 
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie_creation_outlined,
              size: 35,
            ),
            label: 'Now Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_border,
              size: 40,
            ),
            label: 'Top Rated',
          ),
        ],
      ),
    );
  }
}
