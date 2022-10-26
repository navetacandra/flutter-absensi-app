import 'package:absensi/auth_services.dart';
import 'package:absensi/widget/ui/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSiswaScreen extends StatefulWidget {
  const AddSiswaScreen({super.key});

  @override
  State<AddSiswaScreen> createState() => _AddSiswaScreenState();
}

class _AddSiswaScreenState extends State<AddSiswaScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.popUntil(context, ModalRoute.withName("/home"));
        Navigator.pushReplacementNamed(context, "/login");
      }
      setState(() {
        AuthServices.updateUserData();
      });
      if (!((AuthServices.currentUser?.role == 0) ||
          (AuthServices.currentUser?.role == 1))) {
        Navigator.popUntil(context, ModalRoute.withName("/home"));
      } else {
        setState(() {});
      }
    });
    return Scaffold(
      appBar: const MyAppBar(title: "Add Siswa"),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Card(
            elevation: 10,
            child: Container(
              margin: EdgeInsets.all(
                MediaQuery.of(context).size.width / 1.2 / 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Add Siswa",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        )
                      ],
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
