import 'dart:async';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;


Future<List<String>> fetchMovies() => _fetchData("https://swapi.dev/api/films");
Future<List<String>> fetchCharacters() => _fetchData("https://swapi.dev/api/people");

Future<List<String>> _fetchData(String url) async
{
  String? next = url;
  http.Response response;

  List<String> dataList = <String>[];
  while(next != null)
  {
    try
    {
      response = await http.get(Uri.parse(next));
    }
    catch(_)
    {
      return Future.error(Exception("Erro ao requisitar dados"));
    }
    
    if(response.statusCode != 200)
    {
      //print("Erro => ${response.statusCode}");
      return Future.error(Exception("Erro ao requisitar dados: ${response.body}"));
    }
    
    print("OK");
    final Map<String, dynamic> jsonData = json.jsonDecode(response.body);
    //final List<dynamic> characters = jsonData["results"];
    
    
    for(var data in (jsonData["results"] as List<dynamic>))
    {
      //print("NOME => ${characters[i]["name"]}");
      dataList.add( (data["name"] == null)? data["title"] : data["name"] );
    }
    next = jsonData["next"];
  }
  return dataList;

}

