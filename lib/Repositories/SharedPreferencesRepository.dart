

import 'package:shared_preferences/shared_preferences.dart';

enum ValueType{
  Int,
  String,
  Boolean,
  Double,
  ListString
}

class SharedPreferencesRepository {

  Future setValue(String key,Object value,ValueType type) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch(type){
      case ValueType.Int:
        await sharedPreferences.setInt(key, value as int);
        break;
      case ValueType.String:
        await sharedPreferences.setString(key, value as String);
        break;
      case ValueType.Boolean:
        await sharedPreferences.setBool(key, value as bool);
        break;
      case ValueType.Double:
        await sharedPreferences.setDouble(key, value as double);
        break;
      case ValueType.ListString:
        await sharedPreferences.setStringList(key, value as List<String>);
        break;
    }
  }

  Future<dynamic> getValue(String key,ValueType type) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch(type){
      case ValueType.Int:
        return sharedPreferences.getInt(key) ?? -1;
      case ValueType.String:
        return sharedPreferences.getString(key) ?? "";
      case ValueType.Boolean:
        return sharedPreferences.getBool(key) ?? false;
      case ValueType.Double:
        return sharedPreferences.getDouble(key) ?? -1.0;
      case ValueType.ListString:
        return sharedPreferences.getStringList(key) ?? [];
    }
  }


  Future remove(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

}