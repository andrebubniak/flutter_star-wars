import 'package:star_wars/commom/data_type.dart';

class MovieOrCharacter
{
  final int? appStateId; 
  final String name;
  final DataType dataType;
  bool isFavorited;

  MovieOrCharacter({this.appStateId = 1, required this.name, required this.dataType, this.isFavorited = false});

  Map<String, String> favoriteToJson()
  {
    return {
      "name": name,
      "type": dataType.name
    };
  }

  factory MovieOrCharacter.favoriteFromMap(Map map) =>
  MovieOrCharacter(
    appStateId: map["appState_id"],
    name: map["name"],
    dataType: DataType.fromString(map["type"]),
    isFavorited: true
  );

  Map<String, dynamic> favoriteToMap() =>
  {
    "appState_id": appStateId,
    "name": name,
    "type": dataType.name
  };

}