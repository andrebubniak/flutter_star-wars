import 'package:flutter/material.dart';
import 'package:star_wars/commom/widget_view.dart';
import 'package:star_wars/screens/avatar_edition/avatar_edition.dart';
import 'package:star_wars/screens/home/components/character_or_movie_card.dart';
import 'package:star_wars/screens/home/components/character_or_movie_list.dart';
import 'package:star_wars/screens/star_wars_web_view/web_view.dart';

import '../../../commom/data_type.dart';

class HomeBody extends StatefulWidget 
{
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => HomeBodyState();
}

class HomeBodyState extends State<HomeBody> 
{
  late CharacterOrMovieList _movieList;
  late CharacterOrMovieList _characterList;
  late CharacterOrMovieList _favoriteList;
  late _WidgetToView _currentWidgetToView;

  @override
  void initState()
  {
    _movieList = CharacterOrMovieList(dataType: DataType.movie);
    _characterList = CharacterOrMovieList(dataType: DataType.character);
    _favoriteList = CharacterOrMovieList(isFavoritedList: true);
    _currentWidgetToView = _WidgetToView.list;
    super.initState();
  }

  bool _updateFavoriteList(FavoriteNotification notification)
  {
    _favoriteList.updateFavoriteList(notification.movieOrCharacter);
    return true;
  }

  void changeAvatarView()
  {
    if(_currentWidgetToView == _WidgetToView.avatar)
    {
      _currentWidgetToView = _WidgetToView.list;
    }
    else
    {
      _currentWidgetToView = _WidgetToView.avatar;
    }
    setState(() {});
  }

  void changeWebView()
  {
    if(_currentWidgetToView == _WidgetToView.web)
    {
      _currentWidgetToView = _WidgetToView.list;
    }
    else
    {
      _currentWidgetToView = _WidgetToView.web;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _HomeBodyView(this);
}


class _HomeBodyView extends StatefulView<HomeBody, HomeBodyState>
{

  const _HomeBodyView(super.state);

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

  Widget get _tabsView => Padding(
    padding: const EdgeInsets.only(top: 24),
    child: DefaultTabController(
      length: 3,
      child: Column(
        children: [ 
          _tabBar,
          const Padding(
            padding: EdgeInsets.only(top: 18, left: 20, right: 20),
            child: Divider(
              color: Colors.black,
              thickness: 2,
            )
          ),
          Flexible(
            child: NotificationListener(
              onNotification: state._updateFavoriteList,
              child: TabBarView(
                children: [
                  state._movieList,
                  state._characterList,
                  state._favoriteList
                ],
              ),
            ),
          )
        ],
      )
    ),
  );

  @override
  Widget build(BuildContext context)
  {
    switch(state._currentWidgetToView)
    {
      case _WidgetToView.list:
        return _tabsView;
      
      case _WidgetToView.avatar:
        return const AvatarEdition();

      case _WidgetToView.web:
        return const WebView();
    }
  }
}


enum _WidgetToView {list, avatar, web}