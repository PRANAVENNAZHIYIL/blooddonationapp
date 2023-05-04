import 'package:ecommerce_app/screen/homescreen.dart';
import 'package:ecommerce_app/screen/signin_screen.dart';
import 'package:ecommerce_app/widgets/add.dart';
import 'package:ecommerce_app/widgets/update.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'helperfunctions/helperfunction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          'homescreen': (context) => const HomeScreen(),
          'adduser': (context) => const AddUser(),
          'updateuser': (context) => const UpdateUser(),
        },
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _isSignedIn ? const HomeScreen() : const LoginPage());
  }
}
