import 'package:flutter/material.dart';
import 'package:star_wars/commom/widget_view.dart';

import '../screens/star_wars_web_view/web_view.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget
{
  final void Function() onOfficialSiteButtonClick;
  final void Function() onAvatarButtonClick;
  const MainAppBar({Key? key, required this.onAvatarButtonClick, required this.onOfficialSiteButtonClick}) : super(key: key);

  @override
  Widget build(BuildContext context) => _MainAppBarView(this);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
}


class _MainAppBarView extends StatelessView<MainAppBar>
{
  const _MainAppBarView(super.widget);

  Widget _avatarButton()
  {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: IconButton(
        iconSize: 40,
        color: Colors.black,
        padding: const EdgeInsets.all(0),
        icon: const Icon(Icons.account_circle_outlined),
        onPressed: widget.onAvatarButtonClick
      ),
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
