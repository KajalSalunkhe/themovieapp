import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:themovieapp/constants/constants.dart';
import 'package:themovieapp/models/top_rated_model.dart';

class TopRatedRepo {
  static const topUrl =
      "${Constants.baseUrl}/3/movie/top_rated?api_key=${Constants.apiKey}";

  Future<List<TopRatedModel>> fetchTopRatedMovies() async {
    try {
      final response = await http.get(Uri.parse(topUrl));

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> results = jsonResponse['results'];

        List<TopRatedModel> movies = results
            .map((movieJson) => TopRatedModel.fromJson(movieJson))
            .toList();

        return movies;
      } else {
        throw Exception('Failed to load movie data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
