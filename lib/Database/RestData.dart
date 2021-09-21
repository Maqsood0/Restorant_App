import 'dart:async';
import 'package:restorant_app/Database/User.dart';
import 'package:restorant_app/Database/Database_helper.dart';

class RestData {
  DatabaseHelper db = new DatabaseHelper();

  Future<User?> getLogin(user) {
    dynamic result = db.getLogin(user);
    return result;
  }
}
