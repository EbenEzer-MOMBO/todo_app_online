import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google sign in
  signInWithGoogle() async {
    // Start sign-in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Get authentication details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Create a user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Sign in with the credential
    final authResult =
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Retrieve the user's display name
    final user = authResult.user;
    final displayName = user?.displayName;

    // Extract the surname from the display name
    final surname = displayName != null ? displayName.split(' ').last : '';

    // Return the user object along with the surname
    return {'user': user, 'surname': surname};
  }
}
