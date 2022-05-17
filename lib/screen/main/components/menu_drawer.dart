import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTap;
  final bool selected;

  const DrawerTile({Key? key, required this.title, required this.icon, required this.onTap, required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap,
      leading: Image.asset(icon),
      title: Text(title),
      selectedColor: Theme.of(context).focusColor,
      tileColor: Theme.of(context).primaryColor
    );
  }
}

class MenuDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuDrawerState();
  }
}

class MenuDrawerState extends State<MenuDrawer> {
  bool showUsers = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 75,
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset("icons/Icon-192.png")),
          DrawerTile(
            title: "Users",
            icon: 'icons/Icon-192.png',
            onTap: (){
              setState(() {
                showUsers = true;
              });
            },
            selected: showUsers,
          ),
          DrawerTile(
            title: "Food Entries",
            icon: 'icons/Icon-192.png',
            onTap: (){
              setState(() {
                showUsers = false;
              });
            },
            selected: !showUsers,
          )
        ],
      ),
    );
  }
}