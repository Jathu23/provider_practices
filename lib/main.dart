import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practices/Providers/movie_provider.dart';
import 'package:provider_practices/Screens/favorite_movies_page.dart';

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
      debugShowCheckedModeBanner: false, // Hide the debug badge
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movies List'),
          actions: [
            Consumer<MovieProvider>(
              builder: (context, movieProvider, child) {
                return IconButton(
                  icon: Badge(
                    count: movieProvider.myFavMovies.length,
                    child: const Icon(Icons.favorite),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoriteMoviesPage(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
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

class Badge extends StatelessWidget {
  final int count;
  final Widget child;

  const Badge({super.key, required this.count, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        if (count > 0)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
