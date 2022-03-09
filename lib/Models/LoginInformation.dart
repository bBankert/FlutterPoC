class LoginInformation{
  String username;
  String password;

  LoginInformation({required this.username,required this.password});

  Map<String,dynamic> toJson() => {
    'username': username,
    'password': password,
  };

}