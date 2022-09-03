import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:star_wars/screens/avatar_edition/components/avatar_save.dart';

import '../../commom/widget_view.dart';


class AvatarEdition extends StatelessWidget 
{
  final List<String> _avatarAttributes = const [
    "Cabelo",                       
    "Cor de Cabelo",
    "Barba",
    "Cor da Barba",
    "Roupa",
    "Cor da Roupa",
    "Olho",
    "Sobrancelha",
    "Boca",
    "Pele",
    "Acessório"
  ];
  
  const AvatarEdition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _AvatarEditionView(this);
}


class _AvatarEditionView extends StatelessView<AvatarEdition> 
{
  const _AvatarEditionView(super.widget);

  @override
  Widget build(BuildContext context) 
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: FluttermojiCircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[200],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FluttermojiCustomizer(
            attributeTitles: widget._avatarAttributes,
            autosave: true,
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 12), child: AvatarSaveWidget())
      ],
    );
  }
}