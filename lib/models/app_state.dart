class AppState
{
  final int? id;
  final String avatar;

  AppState({this.id, required this.avatar});

  factory AppState.fromMap(Map map) =>
  AppState(
    id: map["id"],
    avatar: map["avatar"] as String
  );

  Map<String, dynamic> toMap() =>
  {
    "avatar": avatar
  };
}