import 'package:flutter/material.dart';
import 'package:star_wars/commom/data_type.dart';
import 'package:star_wars/commom/widget_view.dart';
import 'package:http/http.dart';
import 'package:star_wars/models/movie_or_character.dart';

class ItemList extends StatefulWidget
{
  final MovieOrCharacter movieOrCharacter;
  final bool isFavoritedList;

  const ItemList({Key? key, required this.movieOrCharacter, this.isFavoritedList = false}) : super(key: key);
 
  @override
  State<ItemList> createState() => _ItemListState();

}


class _ItemListState extends State<ItemList>
{
  late Color _borderColor;
  late IconData _favoriteIcon;
  @override
  void initState() 
  {
    _favoriteIcon = (widget.movieOrCharacter.isFavorited)? Icons.favorite : Icons.favorite_border;
    switch(widget.movieOrCharacter.dataType)
    {     
      case DataType.character:
        _borderColor = (widget.isFavoritedList)? Colors.green : Colors.black;
        break;
      
      case DataType.movie:
        _borderColor = (widget.isFavoritedList)? Colors.red : Colors.black;
        break;
    }
    super.initState();
  }


  void _favoriteUnfavorite()
  {
    _favoriteIcon = (_favoriteIcon == Icons.favorite)? Icons.favorite_border : Icons.favorite;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _ItemListView(this);
}

class _ItemListView extends StatefulView<ItemList, _ItemListState>
{
  const _ItemListView(super.state);


  Widget? _tileTrailing()
  {
    return (widget.isFavoritedList)? null :
    IconButton(
      alignment: Alignment.centerRight,
      iconSize: 40,
      color: Colors.red,
      icon: Icon(state._favoriteIcon),
      onPressed: state._favoriteUnfavorite
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: state._borderColor)
        ),
        child: ListTile(
          title: Text(widget.movieOrCharacter.name, textAlign: TextAlign.center,),
          trailing: _tileTrailing()
        ),
      )
    );
  }
}


