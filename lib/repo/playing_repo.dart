import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:themovieapp/constants/constants.dart';
import 'package:themovieapp/models/new_playing_model.dart';

class PlayingRepo {
  static const playingurl =
      "${Constants.baseUrl}/3/movie/now_playing?api_key=${Constants.apiKey}";

  Future<List<NewPlayingModel>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(playingurl));

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> results = jsonResponse['results'];

        List<NewPlayingModel> movies = results
            .map((movieJson) => NewPlayingModel.fromJson(movieJson))
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
