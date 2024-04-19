// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shtodo/firebase_options.dart';
// import 'package:shtodo/firebase_options.dart'
import 'package:shtodo/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print("Firebase initialized successfully");

    runApp(const MyApp());
  } catch (e) {
    print("Error initializing Firebase: $e");
    // Handle the error or show a message to the user
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'SHAHRAM TODO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF0C7C99),
          ),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
