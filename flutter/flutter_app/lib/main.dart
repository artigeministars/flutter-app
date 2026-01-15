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
    
  }
}

