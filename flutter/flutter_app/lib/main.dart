import 'package:flutter/material.dart';
import 'package:flutter_app2/dashboard.dart';
import 'package:flutter_app2/data/services/user_service.dart';
import 'package:flutter_app2/ui/login_viewmodel.dart';
import 'package:flutter_app2/ui/processes_viewmodel.dart';
import 'package:flutter_app2/ui/signup_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'postgresinit.dart';
import 'details_screen.dart';
import 'package:go_router/go_router.dart';
import 'signup.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  final postgre = PostgresMain();
  await postgre.connection(host : '0.0.0.0', database:'local', username:'root', password:'mysecretpassword');
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user_id','0');
   runApp(const MyApp());
}


final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/details',
      builder: (BuildContext context, GoRouterState state) {
        return const DetailsScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const SignupScreen();
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const Dashboard();
      },
    ),
  ],
);


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(
      providers: [ 
        ChangeNotifierProvider(create: (_) => LoginViewmodel(userService: UserService(postgresMain: PostgresMain()))),
        ChangeNotifierProvider(create: (_) => SignupViewModel(userService: UserService(postgresMain: PostgresMain()))),
        ChangeNotifierProvider(create: (_) => ProcessesViewmodel(userService: UserService(postgresMain: PostgresMain()))),
       ],
      child: MaterialApp.router(routerConfig: _router,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          )),
    );
    
    
    /*
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(title: 'Flutter Demo Home Page'),
    );
    */
  }
}

