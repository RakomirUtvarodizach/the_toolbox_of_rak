import 'package:json_annotation/json_annotation.dart';
import 'package:toolbox/models/providers/habitTrackerProvider.dart';
import 'package:toolbox/models/providers/notesProvider.dart';
import 'package:toolbox/models/providers/settingsProvider.dart';
import 'package:toolbox/models/providers/shoppingListProvider.dart';
import 'package:toolbox/models/providers/toDoListProvider.dart';
import 'package:toolbox/models/providers/weightTrackerProvider.dart';

part 'userSingleton.g.dart';

@JsonSerializable()
class UserSingleton {
  final String uid;
  String email;
  String firstName;
  String lastName;
  bool isVerified;
  String imageURL;
  //HabitTrackerProvider habitTrackerProvider;
  //NotesProvider notesProvider;
  //SettingsProvider settingsProvider;
  ShoppingListProvider shoppingListProvider;
  //ToDoListProvider toDoListProvider;
  //WeightTrackerProvider weightTrackerProvider;

  UserSingleton({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.isVerified,
    this.imageURL,
    //this.habitTrackerProvider,
    //this.notesProvider,
    //this.settingsProvider,
    this.shoppingListProvider,
    //this.toDoListProvider,
    //this.weightTrackerProvider,
  });

  Map toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isVerified': isVerified
    };
  }

  String readFieldsAsString() {
    return "email -> $email\nfirstName -> $firstName\nlastName -> $lastName\nisVerified -> " +
        isVerified.toString();
  }

  bool checkIfNull() {
    if (this.email == null) return true;
    if (this.firstName == null) return true;
    if (lastName == null) return true;
    return false;
  }
}
