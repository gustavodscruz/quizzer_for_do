import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizzer_for_do/firebase_options.dart';
import 'package:quizzer_for_do/helper/functions.dart';
import 'package:quizzer_for_do/views/home.dart';
import 'package:quizzer_for_do/views/singin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  dynamic _isLoggedIn = false;

  @override
  void initState()  {
    super.initState();
    checkUserLoggedInStatus();
    
  }

  Future checkUserLoggedInStatus()async{
    HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        _isLoggedIn = value;
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: (_isLoggedIn ?? false) ? const Home() : const SignIn(),
    );
  }
}
