import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_sync/pages/login_page.dart';
import 'package:todo_app_sync/pages/main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            // Get the user's surname from the snapshot data
            final user = snapshot.data!;
            final displayName = user.displayName;
            final surname = displayName != null ? displayName.split(' ').last : '';

            // Return the MainPage with the surname passed as a parameter
            return MainPage(surname: surname);
          }

          // No user is logged in
          else {
            // Return the LoginPage
            return const LoginPage();
          }
        },
      ),
    );
  }
}
