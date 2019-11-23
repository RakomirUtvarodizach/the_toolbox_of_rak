import 'package:flutter/material.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/red_cross/authService.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/settings.dart';

class DrawerWidget extends StatefulWidget {
  final void Function(int newWidgetId) parentAction;
  const DrawerWidget({Key key, this.parentAction}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DrawerWidgetState();
  }
}

class _DrawerWidgetState extends State<DrawerWidget>
    with SingleTickerProviderStateMixin {
  AuthService _authService = AuthService();
  Singleton _singleton = Singleton();
  String currentUserName = "";
  String currentUserEmail = "";

  @override
  void initState() {
    currentUserName = (_singleton.user.firstName ?? "Dummy") +
        " " +
        (_singleton.user.lastName ?? "Name");
    currentUserEmail = _singleton.user.email ?? "dummy@gmail.com";
    //debugPrint("CURRENTS: " + currentUserName + " | " + currentUserEmail);
    super.initState();
  }

//comment
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              image: DecorationImage(
                  image: AssetImage('images/logo_dummy.png'),
                  fit: BoxFit.fitWidth)),
          accountName: Text(currentUserName),
          accountEmail: Text(currentUserEmail),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('images/logo_dummy.png'),
          ),
        ),
        ListTile(
          onTap: () {
            widget.parentAction(0);
            Navigator.of(context).pop();
          },
          leading: Icon(Icons.archive),
          title: Text('Notes'),
        ),
        ListTile(
          onTap: () {
            widget.parentAction(1);
            Navigator.of(context).pop();
          },
          leading: Icon(Icons.donut_small),
          title: Text('Habit Tracker'),
        ),
        ListTile(
          onTap: () {
            widget.parentAction(2);
            Navigator.of(context).pop();
          },
          leading: Icon(Icons.view_list),
          title: Text('To-Do List'),
        ),
        ListTile(
          onTap: () {
            widget.parentAction(3);
            Navigator.of(context).pop();
          },
          leading: Icon(Icons.casino),
          title: Text('Weight Tracker'),
        ),
        ListTile(
          onTap: () {
            widget.parentAction(4);
            Navigator.of(context).pop();
          },
          leading: Icon(Icons.shopping_cart),
          title: Text('Shopping List'),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SettingsWidget();
            }));
          },
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        ListTile(
          onTap: () async {
            /*Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Wrapper()),
                (Route<dynamic> route) => false);*/
            //TODO ALWAYS CLOSE THE DRAWER BEFORE LOGGING OUT OR ELSE AN ANNOYING AS FUCK ERROR WILL OCCUR.
            Navigator.of(context).pop();
            _authService.logOut();
            _singleton.user = null;
            //debugPrint("Singleton user: " + _singleton.user.toString());
          },
          leading: Icon(Icons.exit_to_app),
          title: Text('Log Out'),
        ),
      ],
    ));
  }
}
