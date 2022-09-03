import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:star_wars/commom/widget_view.dart';
import 'package:star_wars/database/app_state_database.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget
{
  final void Function() onOfficialSiteButtonClick;
  final void Function() onAvatarButtonClick;
  MainAppBar({Key? key, required this.onAvatarButtonClick, required this.onOfficialSiteButtonClick}) : super(key: key)
  {
    Future.delayed(const Duration(milliseconds: 100), () async
    {
      FluttermojiController fluttermojiController;
      fluttermojiController = Get.find<FluttermojiController>();

      final db = AppStateDatabase.instance;
      
      String curentAvatar = await db.getAvatar();
      Map<String?, dynamic> currentAvatarOptions = jsonDecode(curentAvatar);

      if(currentAvatarOptions.isNotEmpty)
      {
        fluttermojiController.selectedOptions = currentAvatarOptions;
        fluttermojiController.updatePreview();
      }
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => _MainAppBarView(this);
  
}


class _MainAppBarView extends StatelessView<MainAppBar>
{
  const _MainAppBarView(super.widget);

  Widget _avatarButton()
  {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: TextButton(
        onPressed: widget.onAvatarButtonClick,
        child: FluttermojiCircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[400],
        )
      )
    );
  }

  Widget _officialSiteButton(BuildContext context)
  {
    return Padding(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom( 
            side: const BorderSide(width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)
            )
          ),
          onPressed: widget.onOfficialSiteButtonClick,
          child: const Text(
            "Site Oficial",
            style: TextStyle(
              color: Colors.black
            )
          )
        ),
      );
  }

  @override
  Widget build(BuildContext context) 
  {
    return AppBar(
      leadingWidth: 120,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: _officialSiteButton(context),
      actions: [
        _avatarButton()
      ],
    );
  }

}
