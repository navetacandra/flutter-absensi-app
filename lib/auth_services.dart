import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDataObject {
  String uid;
  int role;
  String photoURL;
  UserDataObject({
    required this.uid,
    required this.role,
    required this.photoURL,
  });
}

class UserData {
  String uid;
  String nama;
  String email;
  String alamat;
  String idCard;
  String kelas;
  int role;
  String photoURL;

  UserData({
    required this.uid,
    required this.nama,
    required this.email,
    required this.alamat,
    required this.idCard,
    required this.kelas,
    required this.photoURL,
    required this.role,
  });
}

class AuthServices {
  // ignore: prefer_final_fields
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseDatabase _database = FirebaseDatabase.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static UserDataObject? userData;
  static UserData? currentUser;

  static Future<User?> signIn() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return null;
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;
    updateUserData();
    return user;
  }

  static void signOut() {
    GoogleSignIn().signOut();
    _auth.signOut();
  }

  static void updateUserData() {
    if (_auth.currentUser != null) {
      _database.ref('users/${_auth.currentUser!.uid}').onValue.listen(
        (DatabaseEvent event) {
          DataSnapshot snap = event.snapshot;
          if (!snap.exists) {
            _database.ref('users/${_auth.currentUser?.uid}').update({
              "uid": _auth.currentUser?.uid,
              "role": 3,
              "photoURL": _auth.currentUser?.photoURL ?? "",
            });
            _database.ref('siswa/${_auth.currentUser!.uid}').update(
              {
                "id": _auth.currentUser!.uid,
                "id_card": "",
                "nama": "",
                "kelas": "",
                "alamat": "",
                "email": _auth.currentUser!.email,
                "tel_siswa": "",
                "tel_ortu": "",
                "absensi": {
                  "senin": {
                    "hadir": {
                      "code": 0,
                      "status": "",
                    },
                    "pulang": {
                      "code": 0,
                      "status": "",
                    },
                  },
                  "selasa": {
                    "hadir": {
                      "code": 0,
                      "status": "",
                    },
                    "pulang": {
                      "code": 0,
                      "status": "",
                    },
                  },
                  "rabu": {
                    "hadir": {
                      "code": 0,
                      "status": "",
                    },
                    "pulang": {
                      "code": 0,
                      "status": "",
                    },
                  },
                  "kamis": {
                    "hadir": {
                      "code": 0,
                      "status": "",
                    },
                    "pulang": {
                      "code": 0,
                      "status": "",
                    },
                  },
                  "jumat": {
                    "hadir": {
                      "code": 0,
                      "status": "",
                    },
                    "pulang": {
                      "code": 0,
                      "status": "",
                    },
                  },
                }
              },
            );
          }
          userData = snap.value != null
              ? UserDataObject(
                  uid: snap.child("uid").value as String,
                  role: snap.child("role").value as int,
                  photoURL: snap.child("photoURL").value as String)
              : null;
        },
      );
      _database.ref('siswa/${_auth.currentUser!.uid}').onValue.listen(
        (DatabaseEvent event) {
          DataSnapshot snap = event.snapshot;
          currentUser = snap.value != null
              ? UserData(
                  uid: (snap.child("id").value as String).isNotEmpty
                      ? snap.child("id").value as String
                      : "-",
                  nama: (snap.child("nama").value as String).isNotEmpty
                      ? snap.child("nama").value as String
                      : "-",
                  email: (snap.child("email").value as String).isNotEmpty
                      ? snap.child("email").value as String
                      : "-",
                  alamat: (snap.child("alamat").value as String).isNotEmpty
                      ? snap.child("alamat").value as String
                      : "-",
                  idCard: (snap.child("id_card").value as String).isNotEmpty
                      ? snap.child("id_card").value as String
                      : "-",
                  kelas: (snap.child("kelas").value as String).isNotEmpty
                      ? snap.child("kelas").value as String
                      : "-",
                  photoURL: userData?.photoURL ?? "",
                  role: userData?.role ?? 3,
                )
              : null;
        },
      );
    }
  }

  static bool isAuthenticated() {
    updateUserData();
    return _auth.currentUser != null;
  }
}
