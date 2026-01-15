import 'package:flutter/material.dart';
import 'package:flutter_app2/dashboard_details.dart';

class Dashboard extends StatelessWidget {

     const Dashboard({ super.key});

     @override
     Widget build( BuildContext context) {
          return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'), 
        leading: Icon(Icons.dashboard_customize_outlined),
        backgroundColor: Colors.greenAccent.shade100,
        foregroundColor: Colors.amberAccent.shade100,
        elevation: 4,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Color.fromARGB(255, 94, 203, 149)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search pressed!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings pressed!')),
              );
            },
          ),
        ],
      ),
      body: DashboardDetails(),
    );
  
  }

}