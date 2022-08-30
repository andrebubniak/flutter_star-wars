import 'package:star_wars/commom/data_type.dart';

class MovieOrCharacter
{
  final String name;
  final DataType dataType;
  bool isFavorited;

  MovieOrCharacter({required this.name, required this.dataType, this.isFavorited = false});
}