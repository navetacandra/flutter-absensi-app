import 'package:absensi/auth_services.dart';
import 'package:absensi/widget/ui/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUserScreen extends StatefulWidget {
  final String? id;
  final String? email;
  final int? role;
  const EditUserScreen({
    super.key,
    this.id,
    this.email,
    this.role,
  });

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  // void fetchDatabase() {
  //   FirebaseDatabase.instance
  //       .ref("siswa/${widget.id}")
  //       .onValue
  //       .listen((DatabaseEvent event) {
  //     DataSnapshot snap = event.snapshot;
  //     if (snap.exists && snap.value != null) {}
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Map<String, dynamic> args = Map<String, dynamic>.from(
      ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>,
    );
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.popUntil(context, ModalRoute.withName("/home"));
      }
      setState(() {
        AuthServices.updateUserData();
      });
      if ((AuthServices.currentUser?.role != 0)) {
        Navigator.popUntil(context, ModalRoute.withName("/home"));
      } else {
        // fetchDatabase();
      }
    });
    return Scaffold(
      appBar: const MyAppBar(title: "Edit User"),
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
                          "Edit User",
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

class EditUserArgs {
  final String id;
  final String email;
  final int role;

  const EditUserArgs({
    required this.id,
    required this.email,
    required this.role,
  });
}
