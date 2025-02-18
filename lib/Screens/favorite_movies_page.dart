import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practices/Providers/movie_provider.dart';

class FavoriteMoviesPage extends StatelessWidget {
  const FavoriteMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favorite Movies')),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.myFavMovies.isEmpty) {
            return const Center(child: Text("No Favorite Movies Yet!"));
          }

          return ListView.builder(
            itemCount: movieProvider.myFavMovies.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.myFavMovies[index];
              return ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.duration),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    movieProvider.removeFavorite(movie);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
