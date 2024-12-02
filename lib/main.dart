import 'package:flutter/material.dart';
import 'package:untitled2/screens/home_screen.dart';
import 'package:untitled2/screens/profile_screen.dart';
import 'package:untitled2/screens/register_screen.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/profile': (context) => ProfileScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}