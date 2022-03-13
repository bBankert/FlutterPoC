
import 'dart:convert';

class UserInformation {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;

  UserInformation({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth});

  factory UserInformation.fromJson(Map<String, dynamic> json){
    return UserInformation(
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
    );
  }

  Map<String,dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'dateOfBirth': dateOfBirth.toIso8601String() //DateTimes don't translate well...
  };

  factory UserInformation.decodeInformation(String encodedUser){
    Map<String,dynamic> map = jsonDecode(encodedUser);
    return UserInformation.fromJson(map);
  }
}