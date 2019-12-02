import 'package:flutter/material.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/screens/widgets/drawer_widget.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/notes_widget.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/habit_tracker_widget.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/shopping_list_widgets/shopping_list_widget.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/to_do_list_widget.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/weight_tracker_widget.dart';

class DrawerHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerHomeState();
  }
}

class DrawerHomeState extends State<DrawerHome>
    with SingleTickerProviderStateMixin {
  Singleton _singleton = Singleton();
  int currentDrawerWidgetIndex = 4;

  @override
  void initState() {
    // debugPrint(
    //     "Init state of Drawer Home, this is cdwi -> $currentDrawerWidgetIndex");
    currentDrawerWidgetIndex = _singleton.myCurrentDrawerWidgetIndex;
    // debugPrint("And this is after Singleton -> $currentDrawerWidgetIndex");
    super.initState();
  }

  _changeDrawerWidget(int newWidgetId) => setState(() {
        currentDrawerWidgetIndex = newWidgetId;
        _singleton.myCurrentDrawerWidgetIndex = newWidgetId;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Toolbar Drawer',
          style: TextStyle(fontWeight: FontWeight.w700),
        )),
        backgroundColor: Colors.brown[200],
        body: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: currentWidget(),
        ),
        drawer: DrawerWidget(parentAction: _changeDrawerWidget));
  }

  Widget currentWidget() {
    int id = currentDrawerWidgetIndex;
    debugPrint("ID -> $id");
    if (id == 0) {
      return NotesWidget();
    } else if (id == 1) {
      return HabitTrackerWidget();
    } else if (id == 2) {
      return ToDoListWidget();
    } else if (id == 3) {
      return WeightTrackerWidget();
    } else if (id == 4) {
      return ShoppingListWidget();
    } else
      return NotesWidget();
  }
}
