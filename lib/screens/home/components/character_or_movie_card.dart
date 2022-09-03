import 'package:flutter/material.dart';
import 'package:star_wars/commom/data_type.dart';
import 'package:star_wars/commom/widget_view.dart';
import 'package:star_wars/models/movie_or_character.dart';

class CharacterOrMovieCard extends StatefulWidget
{
  final MovieOrCharacter movieOrCharacter;
  final bool isFavoritedList;

  const CharacterOrMovieCard({Key? key, required this.movieOrCharacter, this.isFavoritedList = false}) : super(key: key);
 
  @override
  State<CharacterOrMovieCard> createState() => _CharacterOrMovieCardState();

}


class _CharacterOrMovieCardState extends State<CharacterOrMovieCard>
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

      default:
        _borderColor = Colors.black;
        break;
    }
    super.initState();
  }

  
  void _favoriteUnfavorite()
  {
    _favoriteIcon = (_favoriteIcon == Icons.favorite)? Icons.favorite_border : Icons.favorite;
    widget.movieOrCharacter.isFavorited = !widget.movieOrCharacter.isFavorited;
    FavoriteNotification(movieOrCharacter: widget.movieOrCharacter).dispatch(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _ItemListView(this);
}

class _ItemListView extends StatefulView<CharacterOrMovieCard, _CharacterOrMovieCardState>
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
          side: BorderSide(color: state._borderColor, width: (widget.isFavoritedList)? 2 : 1)
        ),
        child: ListTile(
          title: Text(widget.movieOrCharacter.name, textAlign: TextAlign.center,),
          trailing: _tileTrailing()
        ),
      )
    );
  }
}



class FavoriteNotification extends Notification
{
  final MovieOrCharacter movieOrCharacter;
  const FavoriteNotification({required this.movieOrCharacter});
}
