import 'package:absensi/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () {
    //   AuthServices.signOut();
    // });
    // AuthServices.signIn("", "");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LOGIN",
          style: TextStyle(
            wordSpacing: .5,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(FirebaseAuth.instance.currentUser != null
                ? "Signed In as ${FirebaseAuth.instance.currentUser!.email}"
                : "Login Boss"),
            Center(
              child: Text(FirebaseAuth.instance.currentUser != null
                  ? "Sign Out"
                  : "Sign In"),
            ),
            FirebaseAuth.instance.currentUser != null
                ? ElevatedButton(
                    child: Text("Sign Out"),
                    onPressed: () {
                      AuthServices.signOut();
                      setState(() {});
                    },
                  )
                : ElevatedButton(
                    child: Text("Sign In"),
                    onPressed: () {
                      AuthServices.signIn();
                      setState(() {});
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
