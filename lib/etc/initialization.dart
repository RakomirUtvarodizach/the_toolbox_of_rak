import 'package:flare_splash_screen/flare_splash_screen.dart';
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
      return SlideRightFadeRoute(widget: Wrapper());
      break;
    case '/home':
      return SlideRightFadeRoute(widget: Home());
      break;
    case '/settings':
      return SlideRightFadeRoute(widget: SettingsWidget());
      break;
    case '/shopping_list_editor':
      return FlareFadeRoute(widget: ShoppingListEditor());
      break;
    // case '/shopping_list_editor_view':
    // return MaterialPageRoute(builder:(context)=>SplashScreen.navigate(
    //           name: 'assets/grow_shrink_page_transition.flr',
    //           next: (context) => ShoppingListEditorView(),
    //           until: () => Future.delayed(Duration(milliseconds: 500)),
    //           startAnimation: 'go',
    //           fit: BoxFit.fitHeight,
    //         ),);
    // break;
    case '/shopping_list_editor_view':
      return FlareFadeRoute(widget: ShoppingListEditorView());
      break;
    case '/database_testing':
      return SlideRightFadeRoute(widget: DatabaseTesting());
      break;
    default:
      return SlideRightFadeRoute(
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
