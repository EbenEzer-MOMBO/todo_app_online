import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app_sync/pages/auth_page.dart';
import 'firebase_options.dart';

void main() async {
  //hive init
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('mybox');

  WidgetsFlutterBinding.ensureInitialized();
  GoogleSignIn googleSignIn = GoogleSignIn();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
