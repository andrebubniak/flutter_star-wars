import 'package:flutter/material.dart';
import 'package:star_wars/models/movie_or_character.dart';
import '../../../commom/widget_view.dart';
import 'item_list.dart';

class ListOfNames extends StatelessWidget 
{
  final Future<List<MovieOrCharacter>> listOfMovieOrCharacter;
  const ListOfNames({
    Key? key,
    required this.listOfMovieOrCharacter
    }) : super(key: key);

  @override
  Widget build(BuildContext context) => (_ListOfNamesView(this));
}


class _ListOfNamesView extends StatelessView<ListOfNames>
{
  const _ListOfNamesView(super.widget);


  @override
  Widget build(BuildContext context) 
  {
    return FutureBuilder(
      future: widget.listOfMovieOrCharacter,
      builder: (context, snapshot) 
      {
        if(snapshot.hasData)
        {
          return ListView.builder(
            itemCount: (snapshot.data as List<MovieOrCharacter>).length,
            itemBuilder: (context, index)
            {
              return ItemList(movieOrCharacter: (snapshot.data as List<MovieOrCharacter>).elementAt(index),);
            },
          );
        }

        else if(snapshot.hasError)
        {
          return Center(
            child: Text(
              snapshot.error.toString()
            )
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

}