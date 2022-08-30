import 'package:flutter/material.dart';
import 'package:star_wars/commom/data_type.dart';
import 'package:star_wars/models/movie_or_character.dart';
import 'package:star_wars/screens/home/components/list_of_names.dart';
import '../../../api/swapi/swapi.dart' as swapi;

class CharacterList extends StatelessWidget 
{
  late Future<List<MovieOrCharacter>> _characterListData;
  CharacterList({Key? key}) : super(key: key)
  {
    _characterListData = _getData();
  }

  Future<List<MovieOrCharacter>> _getData() async
  {
    List<String> movies = await swapi.fetchCharacters();
    return movies.map<MovieOrCharacter>((characterName)
    {
      return MovieOrCharacter(name: characterName, dataType: DataType.character);
    }).toList();
  }

  @override
  Widget build(BuildContext context) => ListOfNames(listOfMovieOrCharacter: _characterListData);
}