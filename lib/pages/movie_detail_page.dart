import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../database/database_helper.dart'; // Importa o helper do banco de dados

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  Future<void> _addToFavorites(BuildContext context) async {
    try {
      // Adiciona o filme ao banco de dados
      await DatabaseHelper().addMovie({
        'id': movie.id,
        'title': movie.title,
        'release_date': movie.releaseDate,
        'overview': movie.overview,
        'poster_path': movie.posterPath,
      });

      // Mostra um feedback ao usuário
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Filme adicionado aos favoritos!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao adicionar o filme aos favoritos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            onPressed: () => _addToFavorites(context),
            icon: const Icon(Icons.favorite),
            tooltip: 'Adicionar aos Favoritos',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: movie.posterPath.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.movie, size: 100),
              ),
              const SizedBox(height: 16),
              Text(
                movie.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(movie.overview),
              const SizedBox(height: 16),
              Text("Data de Lançamento: ${movie.releaseDate}"),
            ],
          ),
        ),
      ),
    );
  }
}
