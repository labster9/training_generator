import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Menu',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile('Overview', Icons.view_module_sharp, () {
            Navigator.of(context).pushReplacementNamed('/tabs');
          }),
          buildListTile('Generator', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed('/generator');
          }),
          buildListTile('Your trainings', Icons.self_improvement, () {
            Navigator.of(context).pushReplacementNamed('/user-trainings');
          })
        ],
      ),
    );
  }
}
