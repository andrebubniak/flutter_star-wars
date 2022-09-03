import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:star_wars/database/app_state_database.dart';
import '../../../commom/widget_view.dart';

//criando meu proprio save de avatar como o existente salva no shared preferences
class AvatarSaveWidget extends StatelessWidget
{
  final fluttermojiController = Get.find<FluttermojiController>();
  AvatarSaveWidget({Key? key}) : super(key: key);

  void _saveAvatarOnDatabase() async
  {
    final db = AppStateDatabase.instance;
    await db.updateAvatar(jsonEncode(fluttermojiController.selectedOptions));
  }

  @override
  Widget build(BuildContext context) => _AvatarSaveWidgetView(this);

}

class _AvatarSaveWidgetView extends StatelessView<AvatarSaveWidget>
{
  const _AvatarSaveWidgetView(super.widget);

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: widget._saveAvatarOnDatabase,
      child: const Text(
        "Salvar",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        )
      ),
    );
  }
}