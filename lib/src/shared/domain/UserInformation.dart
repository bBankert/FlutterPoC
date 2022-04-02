
import 'dart:convert';

class UserInformation {
  final String firstName;
  final String lastName;
  final String dateOfBirth;

  const UserInformation({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth});

  factory UserInformation.fromJson(Map<String, dynamic> json){
    return UserInformation(
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
    );
  }

  Map<String,dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'dateOfBirth': dateOfBirth
  };

  factory UserInformation.decodeUserInformation(String encodedUser){
    Map<String,dynamic> map = jsonDecode(encodedUser);
    return UserInformation.fromJson(map);
  }

  static const empty = UserInformation(firstName: "-", lastName: "-", dateOfBirth: "-");
}