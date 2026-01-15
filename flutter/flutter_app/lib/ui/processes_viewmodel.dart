import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app2/data/models/note_model.dart';
import 'package:flutter_app2/data/models/photo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/user_service.dart';

class ProcessesViewmodel extends ChangeNotifier {

  ProcessesViewmodel({
    required UserService userService
  }) : _userService = userService;

  final UserService _userService;


Future<bool?> addingPhoto({ var photo , String? user_id }) async {
  
  try {
  final photoId = await _userService.addPhoto(photo: photo,user_id: user_id);
  if( photoId != null){
    print(photoId);
    print(" 222 ");
    return true;
  }
  return null;
  } on Exception catch(e) {
    print(e.toString());
    print(" 222 2 ");
    log('Error: ${e.toString()}');
    return null;
  } finally {
    notifyListeners();
  }

}

Future<bool?> addingNote({ String headerValue = '', String expandedValue = '', String? user_id }) async {
  try {
  final noteId = await _userService.addNote(headerValue: headerValue,expandedValue: expandedValue ,user_id: user_id);
  if( noteId != null){
    print(noteId);
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

Future<List<Photo>> getAllPhotos() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString("user_id");

  try {

  List<Photo> photos = await _userService.getPhotos(user_id: userId);

  if( photos.isNotEmpty ){
    // print(photos);
    return photos;
  }
  return [];
  } on Exception catch(e) {
    print(e.toString());
    log('Error: ${e.toString()}');
    return [];
  } finally {
    notifyListeners();
  }

}


Future<List<Note>> getAllNotes() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString("user_id");

  try {

  List<Note> notes = await _userService.getNotes(user_id: userId);

  if( notes.isNotEmpty ){
    // print(photos);
    return notes;
  }
  return [];
  } on Exception catch(e) {
    print(e.toString());
    log('Error: ${e.toString()}');
    return [];
  } finally {
    notifyListeners();
  }

}


}