import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_sync/pages/login_page.dart';
import 'package:todo_app_sync/pages/main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //utilisateur connecté
          if(snapshot.hasData){
            //page d'accueil
            return const MainPage();
          }

          //aucun utilisateur connecté
          else{
            //retour à la page de connexion
            return const LoginPage();
          }
        },
      ),
    );
  }
}