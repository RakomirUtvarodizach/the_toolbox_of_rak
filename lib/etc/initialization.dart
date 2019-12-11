import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toolbox/etc/styles.dart';
import 'package:toolbox/screens/database_testing.dart';
import 'package:toolbox/screens/home.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/settings.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/shopping_list_widgets/shopping_list_editor.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/shopping_list_widgets/shopping_list_editor_view.dart';
import 'package:toolbox/screens/wrapper.dart';
import 'custom_routes.dart';

PageRouteBuilder routeManaging(String routeName) {
  switch (routeName) {
    case '/wrapper':
      return GrowShrinkRoute(widget: Wrapper());
      break;
    case '/home':
      return GrowShrinkRoute(widget: Home());
      break;
    case '/settings':
      return GrowShrinkRoute(widget: SettingsWidget());
      break;
    case '/shopping_list_editor':
      return GrowShrinkRoute(widget: ShoppingListEditor());
      break;

    case '/shopping_list_editor_view':
      return GrowShrinkRoute(widget: ShoppingListEditorView());
      break;
    case '/database_testing':
      return GrowShrinkRoute(widget: DatabaseTesting());
      break;
    default:
      return GrowShrinkRoute(
          widget: Container(
        color: DarkColor,
        child: Center(
          child: Text(
            "404 Page $routeName not found.",
            style: TextStyle(
                fontSize: LargeTextSize,
                color: AccentColor,
                fontWeight: FontWeight.w800),
          ),
        ),
      ));
      break;
  }
}
