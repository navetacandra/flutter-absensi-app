import 'dart:ui' as ui;
import 'package:absensi/auth_services.dart';
import 'package:absensi/constant/current_date.dart';
import 'package:absensi/widget/ui/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Check is authenticated
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        setState(() {
          AuthServices.updateUserData();
        });
      }
    });
    return Scaffold(
      appBar: MyAppBar(
        title: "HOME",
        actionsAppBar: [
          IconButton(
            onPressed: () {
              GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              setState(() {});
              Navigator.pushReplacementNamed(context, "/login");
            },
            icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  // color: Colors.black,
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 102, 241, 255),
                      Color.fromARGB(255, 0, 191, 255),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      MediaQuery.of(context).size.height / 5 / 3,
                    ),
                    bottomRight: Radius.circular(
                      MediaQuery.of(context).size.height / 5 / 3,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 5 / 4,
                  left: (MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width / 1.15)) /
                      2,
                ),
                width: MediaQuery.of(context).size.width / 1.15,
                height: MediaQuery.of(context).size.height / 5,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height / 5 / 8,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${CurrentDate.getDay()}, ${CurrentDate.getDate()} ${CurrentDate.getMonth()} ${CurrentDate.getYear()}',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(
                            AuthServices.currentUser?.nama ?? "",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(
                            AuthServices.currentUser?.email ?? "",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 5 / 4,
            ),
            child: Column(
              children: <Widget>[
                !((AuthServices.currentUser?.role == 0) ||
                        (AuthServices.currentUser?.role == 1))
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5 / 4,
                          bottom: MediaQuery.of(context).size.height / 5 / 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: 75,
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, "/list-user"),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FaIcon(
                                        FontAwesomeIcons.userGroup,
                                        size: 40,
                                      ),
                                    ),
                                    Text(
                                      "List User",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 75,
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, "/add-siswa"),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FaIcon(
                                        FontAwesomeIcons.userPlus,
                                        size: 40,
                                      ),
                                    ),
                                    Text(
                                      "Add Siswa",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                !((AuthServices.currentUser?.role == 0) ||
                        (AuthServices.currentUser?.role == 1) ||
                        (AuthServices.currentUser?.role == 2))
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5 / 4,
                          bottom: MediaQuery.of(context).size.height / 5 / 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: 75,
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, "/list-absen"),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                        "assets/img/user-clock.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    Text(
                                      "List Absen",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
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
                  FontAwesomeIcons.house,
                  size: 35,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/profile");
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "assets/img/user-icon.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
