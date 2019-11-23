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
}
