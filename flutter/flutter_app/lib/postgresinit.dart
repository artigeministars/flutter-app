import 'dart:developer';
import 'package:postgres/postgres.dart';



base class PostgresMain {
    PostgresMain(); // default constructor

    Future<dynamic> connection ({ String host = '0.0.0.0', String database = 'local', String username = 'root', String password = 'mysecretpassword'}) async {
        
        try { 

          final connection = await Connection.open(
          Endpoint(
            host: host,
            database: database,
            username: username,
            password: password,
          ),
               // The postgres server hosted locally doesn't have SSL by default. If you're
              // accessing a postgres server over the Internet, the server should support
             // SSL and you should swap out the mode with `SslMode.verifyFull`.
              settings: ConnectionSettings(sslMode: SslMode.disable),
          );
          
          await initialization(connection: connection);
          
          await connectionClose(connection: connection);
          log('has connection!');
          
          return connection;
          

        } catch (e) {
          
            log('Error: ${e.toString()}');
        }
      
          
    }

    Future<Connection?> normalConnection ({ String host = '127.0.0.1', String database = 'local', String username = 'root', String password = 'mysecretpassword'}) async {
         
        try {    
          
          final connection = await Connection.open(
          Endpoint(
            host: host,
            database: database,
            username: username,
            password: password,
          ),
               // The postgres server hosted locally doesn't have SSL by default. If you're
              // accessing a postgres server over the Internet, the server should support
             // SSL and you should swap out the mode with `SslMode.verifyFull`.
              settings: ConnectionSettings(sslMode: SslMode.disable),
          );
          
          log('has normal connection!');
          return connection;
          

        } catch (e) {
            log('Error normal Connection : ${e.toString()}');
            return null;
        } 
      
          
    }

    Future initialization({ dynamic connection = ''}) async {
      
          if (connection != null) {
            
            await connection.execute(
              '  CREATE TABLE IF NOT EXISTS users ( '
              '  id serial PRIMARY KEY, '
              '  username VARCHAR (50) UNIQUE NOT NULL, '
              '  password VARCHAR (50) NOT NULL, '
              '  email VARCHAR (355) UNIQUE NOT NULL, '
              '  created_on TIMESTAMP NOT NULL '
              ')',
            );

            await connection.execute(
              '  CREATE TABLE IF NOT EXISTS photos ( '
              '  id serial PRIMARY KEY, '
              '  photo bytea , '
              '  user_id INT, '
              '  created_on TIMESTAMP NOT NULL '
              ')',
            );

            await connection.execute(
              '  CREATE TABLE IF NOT EXISTS notes ( '
              '  id serial PRIMARY KEY, '
              '  headerValue text , '
              '  expandedValue text , '
              '  user_id INT, '
              '  created_on TIMESTAMP NOT NULL '
              ')',
            );
          }
          
    }

    Future<void> connectionClose({dynamic connection= '' }) async {
      await connection.close();
    }

}