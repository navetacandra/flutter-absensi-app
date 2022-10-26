import 'dart:ui' as ui;
import 'package:absensi/auth_services.dart';
import 'package:absensi/widget/ui/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Check is authenticated
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.popUntil(context, ModalRoute.withName("/home"));
        Navigator.pushReplacementNamed(context, "/login");
      }
      setState(() {
        AuthServices.updateUserData();
      });
    });
    return Scaffold(
      appBar: const MyAppBar(
        title: "Profile",
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height / 15, 0, 0),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.15,
                    height: MediaQuery.of(context).size.height / 2,
                    margin: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width -
                              (MediaQuery.of(context).size.width / 1.15)) /
                          2,
                      right: (MediaQuery.of(context).size.width -
                              (MediaQuery.of(context).size.width / 1.15)) /
                          2,
                      top: MediaQuery.of(context).size.width / 2.25 / 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 20,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, .5),
                          blurRadius: 4,
                          offset: Offset.zero,
                        )
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.width / 2.25) -
                            (MediaQuery.of(context).size.width / 3 / 3),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Text(
                              "Nama : ${AuthServices.currentUser?.nama ?? "-"}",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Text(
                              "Email : ${AuthServices.currentUser?.email ?? "-"}",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Text(
                              "Kelas : ${AuthServices.currentUser?.kelas ?? "-"}",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Text(
                              "ID : ${AuthServices.currentUser?.idCard ?? "-"}",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Text(
                              "Alamat : ${AuthServices.currentUser?.alamat ?? "-"}",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Text(
                              "Status : ${(AuthServices.currentUser?.role ?? 3) == 0 ? "super-admin" : (AuthServices.currentUser?.role ?? 3) == 1 ? "admin" : (AuthServices.currentUser?.role ?? 3) == 2 ? "guru" : (AuthServices.currentUser?.role ?? 3) == 3 ? "siswa" : "-"}",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    margin: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width -
                              (MediaQuery.of(context).size.width / 2.25)) /
                          2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 2.25 / 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, .5),
                          blurRadius: 4,
                          offset: Offset.zero,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 2.25 / 2,
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 2.25,
                        width: MediaQuery.of(context).size.width / 2.25,
                        child: Image.network(
                          FirebaseAuth.instance.currentUser?.photoURL ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, .5),
                offset: Offset.zero,
                blurRadius: 5,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50 / 2),
              topRight: Radius.circular(50 / 2),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                // Navigator.pushReplacementNamed(context, "/home");
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset("assets/img/home-icon.png"),
              ),
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                return ui.Gradient.linear(
                  const Offset(0, 55),
                  const Offset(55, 0),
                  [
                    const Color.fromARGB(255, 0, 191, 255),
                    const Color.fromARGB(255, 102, 241, 255),
                  ],
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const FaIcon(
                  FontAwesomeIcons.solidUser,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
