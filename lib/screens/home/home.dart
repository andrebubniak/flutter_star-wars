import 'package:flutter/material.dart';

import 'package:star_wars/commom/widget_view.dart';
import 'package:star_wars/screens/home/components/home_body.dart';
import '/commom/main_app_bar.dart';

class Home extends StatelessWidget 
{
  final bodyStateKey = GlobalKey<HomeBodyState>();
  Home({Key? key}) : super(key: key);

  void changeAvatarScreen() => bodyStateKey.currentState!.changeAvatarView();
  void changeWebScreen() => bodyStateKey.currentState!.changeWebView();

  @override
  Widget build(BuildContext context) => _HomeView(this);
}


class _HomeView extends StatelessView<Home>
{
  const _HomeView(super.widget);

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: MainAppBar(
        onOfficialSiteButtonClick: widget.changeWebScreen,
        onAvatarButtonClick: widget.changeAvatarScreen,
      ),
      body: HomeBody(key: widget.bodyStateKey)
    ); 
  }
}

