import 'package:flutter/material.dart';
import 'package:star_wars/commom/data_type.dart';
import 'package:star_wars/commom/widget_view.dart';
import 'package:star_wars/database/app_state_database.dart';
import 'package:star_wars/models/movie_or_character.dart';
import 'package:star_wars/screens/home/components/character_or_movie_card.dart';
import '../../../api/swapi/swapi.dart' as swapi;

class CharacterOrMovieList extends StatelessWidget 
{
  late final Future<List<MovieOrCharacter>> _futureDataList;
  late final List<MovieOrCharacter> _listOfMovieOrCharacter;
  final DataType dataType;
  final bool isFavoritedList;
  final Key? listOfNamesStateKey;
  CharacterOrMovieList({Key? key, this.dataType = DataType.any, this.isFavoritedList = false, this.listOfNamesStateKey}) : super(key: key)
  {
    if(!isFavoritedList)
    {
      _futureDataList = _getData();
    }
    else
    {
      _futureDataList = _getFavorites();
    }
    _futureDataList.then(
      (value) {_listOfMovieOrCharacter = value;},
      onError: (_) {}
    );
  }


  Future<List<MovieOrCharacter>> _getData() async
  {
    try
    {
      final favorites = await _getFavorites();
      List<String> dataList = (dataType == DataType.character)? await swapi.fetchCharacters() : await swapi.fetchMovies();
      return dataList.map<MovieOrCharacter>((name)
      {
        return MovieOrCharacter(
          name: name,
          dataType: dataType,
          isFavorited: favorites.firstWhere(
            (element) => element.name == name && element.dataType == dataType,
            orElse: () => MovieOrCharacter(name: '', dataType: DataType.any)
          ).isFavorited
        );
      }).toList();
    }
    catch(err)
    {
      return Future.error(err);
    }
  }

  Future<List<MovieOrCharacter>> _getFavorites() async
  {
    final database = AppStateDatabase.instance;
    return database.getFavorites();
  }

  void updateFavoriteList(MovieOrCharacter data) async
  {
    final database = AppStateDatabase.instance;
    if(isFavoritedList)
    {
      if(data.isFavorited)
      {
        _listOfMovieOrCharacter.add(data);
        await database.insertFavorite(data);
      }
      else
      {
        _listOfMovieOrCharacter.remove(
          _listOfMovieOrCharacter.firstWhere(
            (element) => element.name == data.name && element.dataType == data.dataType
          )
        );
        await database.deleteFavorite(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) => _CharacterOrMovieListView(this);
}


class _CharacterOrMovieListView extends StatelessView<CharacterOrMovieList>
{
  const _CharacterOrMovieListView(super.widget);

  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      future: widget._futureDataList,
      builder: (context, snapshot)
      {
        if(snapshot.hasData)
        {
          //return ListOfNames(listOfMovieOrCharacter: widget._dataList, isFavoritedList: widget.isFavoritedList);
          return ListView.builder(
            itemCount: widget._listOfMovieOrCharacter.length,
            itemBuilder: (context, index)
            {
              return CharacterOrMovieCard(
                movieOrCharacter: widget._listOfMovieOrCharacter.elementAt(index),
                isFavoritedList: widget.isFavoritedList,
              );
            }    
          );
        }

        else if(snapshot.hasError)
        {
          return const Center(
            child: Text("Erro ao requisitar dados")
          );
        }

        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}
