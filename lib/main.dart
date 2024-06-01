import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mawakay_task_textformfield/Home_screen.dart';
import 'package:mawakay_task_textformfield/auth/login_screen.dart';
import 'package:mawakay_task_textformfield/auth/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyDG6HiRxgKOJVe0I9DqKD3K8nNtv5PvnKo",
     appId:  "1:782135128143:android:5dff6fbcf5ea1fbc3a3a3a",
      messagingSenderId: "782135128143", projectId: "mawakay-task",
      storageBucket:  "mawakay-task.appspot.com"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser != null)? const LoginScreen(): const HomeScreen(),
        );
  }
}

