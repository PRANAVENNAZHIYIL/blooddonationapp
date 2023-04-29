import 'package:ecommerce_app/screen/homescreen.dart';
import 'package:ecommerce_app/widgets/add.dart';
import 'package:ecommerce_app/widgets/update.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        home: const HomeScreen());
  }
}
