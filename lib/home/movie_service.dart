import 'package:dio/dio.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:moviesapp/environment_config.dart';
import 'package:moviesapp/home/movies_exception.dart';

import 'movie.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  final config = ref.read(environmentConfigProvider);
  return MovieService(config, Dio());
});

class MovieService {
  MovieService(this._environmentConfig, this._dio);

  final EnvironmentConfig _environmentConfig;
  final Dio _dio;

  Future<List<Movie>> getMovies() async {
    try {
      final responce = await _dio.get(
        "https://api.themoviedb.org/3/movie/popular?api_key=${_environmentConfig.movieApiKey}&language=en-US&page=1",
      );

      final results = List<Map<String, dynamic>>.from(responce.data['results']);

      List<Movie> movies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);
      return movies;
    } on DioError catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }
}
