import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';  // Certifique-se de importar o flutter_bloc
import '../bloc/movie_cubit.dart';
import '../widgets/movie_tile.dart';
import 'movie_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Usando o 'BlocProvider' para fornecer o cubit para a árvore de widgets
    final movieCubit = context.read<MovieCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquise Pelo Seu Filmes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Pesquisar filmes',
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (query) {
                movieCubit.fetchMovies(query); // Chama o cubit com a pesquisa
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
                } else if (state is MovieLoaded) {
                  final movies = state.movies;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return MovieTile(
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(movie: movie),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('Nenhum filme encontrado.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
