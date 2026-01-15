import 'package:flutter/material.dart';
import 'login.dart';

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        leading: Icon(Icons.login_outlined),
        backgroundColor: Colors.blueAccent.shade100
        ),
      body: LoginPage(),
    );
  }

}