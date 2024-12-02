import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/movie.dart';
import 'movie_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final movies = await _dbHelper.getMovies();
    setState(() {
      _favorites = movies;
    });
  }

  Future<void> _removeFavorite(int id) async {
    await _dbHelper.removeMovie(id);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
      ),
      body: _favorites.isEmpty
          ? const Center(child: Text("Nenhum filme favoritado."))
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final movie = _favorites[index];
                return ListTile(
                  title: Text(movie['title']),
                  subtitle: Text(movie['release_date']),
                  leading: movie['poster_path'] != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          width: 50,
                        )
                      : const Icon(Icons.movie),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeFavorite(movie['id']),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          movie: Movie.fromJson(movie),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
