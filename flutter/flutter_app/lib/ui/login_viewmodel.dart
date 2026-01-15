import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user_model.dart';
import '../../data/services/user_service.dart';

class LoginViewmodel extends ChangeNotifier {

  LoginViewmodel({
    required UserService userService
  }) : _userService = userService;

  final UserService _userService;

User? user;
User? get user_ => user;

Future<bool?> authUser({String email = '', String password = ''}) async {
  try {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final user = await _userService.getUser(email: email,password: password);
  if( user != null){
    await prefs.setString('user_id', user.id);
    print(user);
    return true;
  }
  return null;
  } on Exception catch(e) {
    print(e.toString());
    log('Error: ${e.toString()}');
    return null;
  } finally {
    notifyListeners();
  }

}

}