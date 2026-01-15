

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app2/data/services/user_service.dart';

class SignupViewModel extends ChangeNotifier {
     SignupViewModel({
      required UserService userService
     }) : _userService = userService;

final UserService _userService;


Future<bool?> addingUser({String username = '' ,String email = '', String password = ''}) async {
  try {
  final userId = await _userService.addUser(username: username, email: email,password: password);
  if( userId != null){
    return true;
  }
  return false;
  } on Exception catch(e) {
    log('Error: ${e.toString()}');
    return false;
  } finally {
    notifyListeners();
  }

}



}