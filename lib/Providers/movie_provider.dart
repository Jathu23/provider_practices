import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider_practices/Models/movie_model.dart';

List<Movie> initialMovies = List.generate(
  25,
  (index) => Movie(
    title: 'Movie $index',
    duration: "${Random().nextInt(3) + 1}h ${Random().nextInt(60)}m",
  ),
);

class MovieProvider extends ChangeNotifier {
  final List<Movie> _movies = initialMovies;
  final List<Movie> _myFavMovies = [];

  List<Movie> get movies => _movies;
  List<Movie> get myFavMovies => _myFavMovies;

  void toggleFavorite(Movie movie) {
    if (_myFavMovies.contains(movie)) {
      _myFavMovies.remove(movie);
    } else {
      _myFavMovies.add(movie);
    }
    notifyListeners();
  }

  void removeFavorite(Movie movie) {
    _myFavMovies.remove(movie);
    notifyListeners();
  }
}
