import 'package:firebase_database/firebase_database.dart';

class UserData {
  const UserData({
    required this.uid,
    required this.role,
  });

  final String uid;
  final String role;
  static FirebaseDatabase _database = FirebaseDatabase.instance;

  Object? getData() {
    return _database.ref('users/$uid').onValue.listen((DatabaseEvent event) {
      DataSnapshot _getDataSnapshot = event.snapshot;
      if (_getDataSnapshot.exists && _getDataSnapshot.value != null) {
        _getDataSnapshot.value;
      } else {
        null;
      }
    });
  }
}
