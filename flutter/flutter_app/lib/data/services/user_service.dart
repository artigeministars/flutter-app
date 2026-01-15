import 'dart:developer';
import 'package:flutter_app2/data/models/note_model.dart';
import 'package:flutter_app2/postgresinit.dart';
import 'package:postgres/postgres.dart' ;
import '../models/user_model.dart';
import '../models/photo_model.dart';


class UserService {

  UserService({ required PostgresMain postgresMain }) : _postgresMain = postgresMain ;

  final PostgresMain _postgresMain;
  late Connection _connection;

      Future<User?>  getUser({String email = '', String password = ''}) async {

          try {
          
          _connection = ( await _postgresMain.normalConnection(host : '0.0.0.0', database:'local',username:'root',password:'mysecretpassword') as Connection);
            
          final query = ' SELECT * FROM users WHERE email=@email AND password=@password ';
          
          final user = await _connection.execute(
            Sql.named(query),
            parameters: { 'email' : email.toString(), 'password': password.toString() },
          ); 

          await _connection.close();

          if( user.isEmpty ) {
            return null;
          } else {
          return 
            User(
              user[0][0].toString(), /// id
              user[0][1].toString(), /// username
              user[0][2].toString(), /// email
              user[0][3].toString(), /// password
            );
          }
          
        } on Exception catch(e) {
          log('Error: ${e.toString()}');
          return null;
        }

    }

  Future<String?> addUser({ String username = '', String email = '', String password = '' }) async {

    try {
      final query = r'INSERT INTO users ( username, password, email , created_on ) VALUES ( $1, $2, $3, $4) RETURNING id';
      final now = DateTime.now();
      _connection = ( await _postgresMain.normalConnection(host : '0.0.0.0', database:'local',username:'root',password:'mysecretpassword') as Connection);
     final userId = await _connection.execute(
            query,
            parameters: [ username.toString() , password.toString() , email.toString(), now.toString() ],
          ); 
      
      await _connection.close();
      
      log('geldi');
          
          
        return userId[0][0].toString();
        } on Exception catch(e) {
          log('Error: ${e.toString()}');
          return null;
        }
  }

  Future<String?> addPhoto({ var photo , String? user_id }) async {

    try {
      if( user_id != null && photo != null ) {
        final query = r'INSERT INTO photos ( photo, user_id, created_on ) VALUES ( $1, $2, $3 ) RETURNING id';
        final now = DateTime.now();
        _connection = ( await _postgresMain.normalConnection(host : '0.0.0.0', database:'local',username:'root',password:'mysecretpassword') as Connection);
        final photoId = await _connection.execute(
            query,
            parameters: [ photo , user_id , now.toString() ],
          ); 
          await _connection.close();
      log('geldi');
      return photoId[0][0].toString();
      }
        return null;
      } on Exception catch(e) {
          log('Error: ${e.toString()}');
          return null;
      }


  }

  Future<String?> addNote({ String headerValue = '', String expandedValue = '', String? user_id }) async {

    try {
      if( user_id != null && headerValue != '' && expandedValue != '' ) {
        final query = r'INSERT INTO notes ( headerValue, expandedValue , user_id, created_on ) VALUES ( $1, $2, $3 , $4 ) RETURNING id';
        final now = DateTime.now();
        _connection = ( await _postgresMain.normalConnection(host : '0.0.0.0', database:'local',username:'root',password:'mysecretpassword') as Connection);
        final noteId = await _connection.execute(
            query,
            parameters: [ headerValue , expandedValue, user_id , now.toString() ],
          ); 
          await _connection.close();
      
      log('geldi');
      return noteId[0][0].toString();
      }
      return null;
        
      } on Exception catch(e) {
          log('Error: ${e.toString()}');
          return null;
      }

  }

  Future<List<Photo>> getPhotos({ String? user_id }) async {

    try {
      if( user_id != null) {
        List<Photo> photosList = [];
        final query = ' SELECT * FROM photos WHERE user_id=@userid ';        
       
        _connection = ( await _postgresMain.normalConnection(host : '0.0.0.0', database:'local',username:'root',password:'mysecretpassword') as Connection);
        final photos = await _connection.execute(
            Sql.named(query),
            parameters: { 'userid' : user_id },
        ); 
        if(photos.isNotEmpty){
             for(var photo in photos) {
              photosList.add(Photo(photo[0].toString(),photo[1].toString(),photo[2].toString(),photo[3].toString()));
            }
        } 
          
        await _connection.close();
      
      log('users photos geldi');
      return photosList;
      }
      return [];
        
      } on Exception catch(e) {
          log('Error: ${e.toString()}');
          return [];
      }

  }

  Future<List<Note>> getNotes({ String? user_id }) async {

    try {
      if( user_id != null) {
        List<Note> notesList = [];
        final query = ' SELECT * FROM notes WHERE user_id=@userid ';        
      
        _connection = ( await _postgresMain.normalConnection(host : '0.0.0.0', database:'local',username:'root',password:'mysecretpassword') as Connection);
        final notes = await _connection.execute(
            Sql.named(query),
            parameters: { 'userid' : user_id },
        ); 
        if(notes.isNotEmpty){
             for(var note in notes) {
              notesList.add(Note(note[0].toString(),note[1].toString(),note[2].toString(),note[3].toString(),note[4].toString(),false));
            }
        } 
          
        await _connection.close();
      
      log('users photos geldi');
      return notesList;
      }
      return [];
        
      } on Exception catch(e) {
          log('Error: ${e.toString()}');
          return [];
      }

  }


}