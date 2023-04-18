import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  //google sign in
  signInWithGoogle() async {
    //debut interactions
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtenir details de l'authentification
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create un utilisateur
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //se connecter
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }

}