import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yurimovieapp/models/comming_model.dart';
import 'package:yurimovieapp/models/detail_model.dart';
import 'package:yurimovieapp/models/now_model.dart';
import 'package:yurimovieapp/models/popular_model.dart';

class ApiService {
  static final String baseUrl = 'https://movies-api.nomadcoders.workers.dev';

  static Future<List<PopularModel>> getPopularMovies() async {
    List<PopularModel> popularInstances = [];
    final url = Uri.parse('$baseUrl/popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      for (var result in results) {
        popularInstances.add(PopularModel.fromJson(result));
      }
      return popularInstances;
    }
    throw Exception('Failed to load popular movies');
  }

  static Future<List<NowModel>> getNowMovies() async {
    List<NowModel> nowInstances = [];
    final url = Uri.parse('$baseUrl/now-playing');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      for (var result in results) {
        nowInstances.add(NowModel.fromJson(result));
      }
      return nowInstances;
    }
    throw Exception('Failed to load now movies');
  }

  static Future<List<CommingModel>> getCommingMovies() async {
    List<CommingModel> commingInstances = [];
    final url = Uri.parse('$baseUrl/coming-soon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      for (var result in results) {
        commingInstances.add(CommingModel.fromJson(result));
      }
      return commingInstances;
    }
    throw Exception('Failed to load comming movies');
  }

  static Future<DetailModel> getMovieById(String id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> movieData = jsonDecode(response.body);
      if (movieData.containsKey('id')) {
        return DetailModel.fromJson(movieData);
      } else {
        throw Exception('Invalid movie data received');
      }
    } else {
      throw Exception('Failed to load movie detail: ${response.statusCode}');
    }
  }

}
