// ignore_for_file: curly_braces_in_flow_control_structures

enum DataType {
  any, movie, character;

  factory DataType.fromString(String type)
  {
    if(type == "movie") return movie;
    else if(type == "character") return character;
    else return any;
  }
}