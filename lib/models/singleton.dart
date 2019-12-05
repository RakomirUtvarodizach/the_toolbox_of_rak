import 'package:toolbox/models/userSingleton.dart';

class Singleton {
  UserSingleton user = UserSingleton();
  int myCurrentDrawerWidgetIndex = 4;

  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  @override
  String toString() {
    return "All info from the singleton:\n\tUser: " + user.toJson().toString();
  }

  void disposeOfUser() {
    user = null;
  }
}
