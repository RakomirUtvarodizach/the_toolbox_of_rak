class UserSingleton {
  final String uid;
  String email;
  String firstName;
  String lastName;
  bool isVerified;

  UserSingleton(
      {this.uid, this.email, this.firstName, this.lastName, this.isVerified});

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
