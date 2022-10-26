import 'package:absensi/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.popUntil(context, ModalRoute.withName("/home"));
      } else {
        if (AuthServices.currentUser == null) {
          setState(() {
            AuthServices.updateUserData();
          });
        } else {
          if (AuthServices.currentUser?.role != 0 ||
              AuthServices.currentUser?.role != 1) {
            Navigator.popUntil(context, ModalRoute.withName("/home"));
          }
        }
      }
    });
    Future.delayed(Duration.zero, () {
      if (!(AuthServices.isAuthenticated() &&
          AuthServices.userData!.role == 0)) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
    return const Scaffold();
  }
}
