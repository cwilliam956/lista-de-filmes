import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieTile({Key? key, required this.movie, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movie.title),
      subtitle: Text(movie.releaseDate),
      leading: movie.posterPath.isNotEmpty
          ? Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.cover,
              width: 50,
            )
          : const Icon(Icons.movie),
      onTap: onTap,
    );
  }
}
