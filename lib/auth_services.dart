import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  // ignore: prefer_final_fields
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseDatabase _database = FirebaseDatabase.instance;

  static Future signUp(String email, String password) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res;
    } on FirebaseAuthException catch (err) {
      return err;
    }
  }

  static Future<UserCredential> signIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential res = await _auth.signInWithCredential(credential);
    print(res);
    return res;
  }

  static void signOut() {
    GoogleSignIn().signOut();
    _auth.signOut();
  }

  static Future getUserData() async {
    _database
        .ref('users/${_auth.currentUser?.uid}')
        .onValue
        .listen((DatabaseEvent event) {
      DataSnapshot snap = event.snapshot;
      if (snap.exists) {}
    });
  }

  static bool isAuthenticated() {
    return _auth.currentUser != null;
  }
}
