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
      leading: Icon(Icons.chevron_right, size: 16, color: Colors.white,),
      title: Text(title, style: TextStyle(color: Theme.of(context).primaryColorLight),),
      selectedColor: Theme.of(context).focusColor,
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
      backgroundColor: Theme.of(context).primaryColorDark,
      elevation: 75,
      child: ListView(
        children: [
          DrawerHeader(child: Column(
            children: [
              Icon(Icons.home,
                  size: 60,
                color: Colors.blue.shade900,
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text("Calorie Dashboard",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
            ],
          )),
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