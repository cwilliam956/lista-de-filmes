import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieRepository {
  final String apiKey = '0f37d5a8d246954d08c7454fdf9fabce';  // Substitua pela sua chave de API

  Future<List<Movie>> fetchMovies(String query) async {
    // URL para buscar filmes de ação, ou filmes baseados na pesquisa
    final genreId = '28'; // Gênero de ação na API do TMDB
    final url = query.isEmpty
        ? 'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreId&language=pt-BR'
        : 'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&language=pt-BR';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Movie> movies = (data['results'] as List).map((movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw Exception('Falha ao carregar filmes');
    }
  }
}
