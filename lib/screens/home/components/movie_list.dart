import 'package:flutter/material.dart';
import 'package:star_wars/commom/data_type.dart';
import 'package:star_wars/models/movie_or_character.dart';
import 'package:star_wars/screens/home/components/list_of_names.dart';
import '../../../api/swapi/swapi.dart' as swapi;

class MovieList extends StatelessWidget 
{
  late Future<List<MovieOrCharacter>> _movieListData;
  MovieList({Key? key}) : super(key: key)
  {
    _movieListData = _getData();
  }

  Future<List<MovieOrCharacter>> _getData() async
  {
    List<String> movies = await swapi.fetchMovies();
    return movies.map<MovieOrCharacter>((movieName)
    {
      return MovieOrCharacter(name: movieName, dataType: DataType.movie);
    }).toList();
  }

  @override
  Widget build(BuildContext context) => ListOfNames(listOfMovieOrCharacter: _movieListData);
}