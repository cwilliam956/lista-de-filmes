import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/movie.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  Future<void> fetchMovies(String query) async {
    emit(MovieLoading());

    try {
      final url =
          'https://api.themoviedb.org/3/search/movie?api_key=0f37d5a8d246954d08c7454fdf9fabce&query=$query';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = (data['results'] as List)
            .map((movieData) => Movie.fromJson(movieData))
            .toList();
        emit(MovieLoaded(movies));
      } else {
        emit(MovieError('Erro ao carregar filmes'));
      }
    } catch (e) {
      emit(MovieError('Erro ao conectar: $e'));
    }
  }
}
