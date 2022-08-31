import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:star_wars/commom/widget_view.dart';
import 'package:star_wars/screens/home/components/character_list.dart';
import 'package:star_wars/screens/home/components/item_list.dart';
import 'package:star_wars/screens/home/components/movie_list.dart';
import '../star_wars_web_view/web_view.dart';
import '/commom/main_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:star_wars/api/swapi/swapi.dart' as swapi;

class Home extends StatelessWidget 
{
  MovieList get _movieList => MovieList();
  CharacterList get _characterList => CharacterList();

  Home({Key? key}) : super(key: key);

  void _goToOfficialSite(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => const WebView()));

  void _goToAvatarScreen(BuildContext context) {}

  @override
  Widget build(BuildContext context) => _HomeView(this);
}



class _HomeView extends StatelessView<Home>
{
  const _HomeView(super.widget);

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
      appBar: MainAppBar(
        onOfficialSiteButtonClick: () => widget._goToOfficialSite(context),
        onAvatarButtonClick: () => widget._goToAvatarScreen(context),
      ),
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
                child: TabBarView(
                  children: [
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

