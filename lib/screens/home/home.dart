import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:star_wars/commom/widget_view.dart';
import 'package:star_wars/screens/home/components/character_list.dart';
import 'package:star_wars/screens/home/components/item_list.dart';
import 'package:star_wars/screens/home/components/movie_list.dart';
import '/commom/main_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:star_wars/api/swapi/swapi.dart' as swapi;

class Home extends StatefulWidget 
{
  MovieList get _movieList => MovieList();
  CharacterList get _characterList => CharacterList();

  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
{
  late Future<List<String>> charactersApiResponse;

  @override
  void initState()
  {
    //charactersApiResponse = fetchCharacters();
    charactersApiResponse = swapi.fetchMovies();
    super.initState();
    
  }

  Future<List<String>> listaTeste = Future<List<String>>.delayed(Duration(seconds: 5), () =>
    [
      "Luke Skywalker",
      "c-3PO",
      "R2-D2",
      "Darth Vader",
      "Leia Organa",
      "Owen lARS",
      "Beru",
      "Biggs",
      "Obi-Wan"
    ]
  );

  List<String> lista = 
  [
    "Luke Skywalker",
    "c-3PO",
    "R2-D2",
    "Darth Vader",
    "Leia Organa",
    "Owen lARS",
    "Beru",
    "Biggs",
    "Obi-Wan"
  ];

  void addName(String name)
  {
    lista.add(name);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) => _HomeView(this);
}


class _HomeView extends StatefulView<Home,_HomeState>
{
  const _HomeView(super.state);

  Widget _tabContainer(Tab tab)
  {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4)
      ),
      child: tab
    );
  }


  TabBar get _tabBar => 
  TabBar(
    indicatorWeight: .1,
    padding: const EdgeInsets.symmetric(horizontal: 0),
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey,
    tabs: [
      _tabContainer(const Tab(text: "Filmes", height: 30)),
      _tabContainer(const Tab(text: "Personagens", height: 30)),
      _tabContainer(const Tab(text: "Favoritos", height: 30)),
    ],
  );

  @override
  Widget build(BuildContext context) 
  {
    
    return Scaffold(
      appBar: const MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [ 
              _tabBar,
              Padding(
                padding: EdgeInsets.only(top: 18, left: 20, right: 20),
                child: Divider(
                  color: Colors.black,
                  thickness: 2,
                )
              ),
              Flexible(
                //width: double.maxFinite,
                //height: MediaQuery.of(context).size.height/1.5,
                child: TabBarView(
                  children: [
                    //ListView.builder()
                    widget._movieList,
                    widget._characterList,
                    Center(child: Text("Favoritos"),)
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
    
  }

}