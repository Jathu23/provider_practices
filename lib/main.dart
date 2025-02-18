import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider_practices/Providers/movie_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Movies List')),
        body: Consumer<MovieProvider>(
          builder: (context, movieProvider, child) {
            return ListView.builder(
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.movies[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.duration),
                  trailing: IconButton(
                    icon: Icon(
                      movieProvider.myFavMovies.contains(movie)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: movieProvider.myFavMovies.contains(movie)
                          ? Colors.red
                          : null,
                    ),
                    onPressed: () {
                      movieProvider.toggleFavorite(movie);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}




