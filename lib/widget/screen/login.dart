import 'package:absensi/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 32, 16, 0),
              child: Column(
                children: [
                  Text(
                    "LOGIN",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 15,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(
                          MediaQuery.of(context).size.width / 1,
                          50,
                        ),
                      ),
                      maximumSize: MaterialStateProperty.all(
                        Size(
                          MediaQuery.of(context).size.width / 1,
                          50,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      var signInRes = await AuthServices.signIn();
                      if (signInRes != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, "/home");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Image.asset(
                              "assets/img/google-icon.png",
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const Text(
                            "Masuk dengan Google",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
