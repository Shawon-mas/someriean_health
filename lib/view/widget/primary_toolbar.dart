import 'package:flutter/material.dart';
class PrimaryToolbar extends StatelessWidget implements PreferredSizeWidget{
  const PrimaryToolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pinkAccent,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(10.0,0,0,0),
        child: Image.asset('assets/images/splash.png'),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}