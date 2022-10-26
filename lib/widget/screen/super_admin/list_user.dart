import 'package:absensi/auth_services.dart';
import 'package:absensi/widget/ui/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  List<DataUser> dataUser = [];
  List<UsersData> usersData = [];

  void newFetch() {
    for (var user in dataUser) {
      if (user.role == 3) {
        FirebaseDatabase.instance.ref("siswa/${user.id}").onValue.listen(
          (DatabaseEvent event) {
            DataSnapshot snap = event.snapshot;
            if (snap.exists && snap.value != null) {
              List<UsersData> tempUsersData = [];
              tempUsersData.add(UsersData(
                id: user.id,
                nama: (snap.child("nama").value as String).isNotEmpty
                    ? snap.child("nama").value as String
                    : "-",
                email: snap.child("email").value as String,
                kelas: (snap.child("kelas").value as String).isNotEmpty
                    ? snap.child("kelas").value as String
                    : "-",
                alamat: (snap.child("alamat").value as String).isNotEmpty
                    ? snap.child("alamat").value as String
                    : "-",
                telSiswa: (snap.child("telSiswa").value as String).isNotEmpty
                    ? snap.child("telSiswa").value as String
                    : "-",
                telOrtu: (snap.child("telOrtu").value as String).isNotEmpty
                    ? snap.child("telOrtu").value as String
                    : "-",
                role: user.role,
              ));
              setState(() {
                usersData = tempUsersData;
              });
            }
          },
        );
      }
    }
  }

  void fetchDatabase() {
    FirebaseDatabase.instance
        .ref("users")
        .onValue
        .listen((DatabaseEvent event) {
      DataSnapshot snap = event.snapshot;
      if (snap.exists && snap.value != null) {
        List<DataUser> tempDataUser = [];
        for (var child in snap.children) {
          tempDataUser.add(DataUser(
            id: child.child("uid").value as String,
            role: child.child("role").value as int,
          ));
        }
        setState(() {
          dataUser = tempDataUser;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.popUntil(context, ModalRoute.withName("/home"));
      }
      setState(() {
        AuthServices.updateUserData();
      });
      if (!((AuthServices.currentUser?.role == 0) ||
          (AuthServices.currentUser?.role == 1) ||
          (AuthServices.currentUser?.role == 2))) {
        Navigator.popUntil(context, ModalRoute.withName("/home"));
      } else {
        fetchDatabase();
        newFetch();
      }
    });
    return Scaffold(
      appBar: const MyAppBar(title: "List User"),
      body: ListView.builder(
        itemCount: usersData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/edit-user",
                  arguments: {
                    'id': usersData[index].id,
                    'email': usersData[index].email,
                    'role': usersData[index].role,
                  },
                );
              },
              child: Card(
                elevation: 8,
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "ID: ${usersData[index].id}",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Nama: ${usersData[index].nama}",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Email: ${usersData[index].email}",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DataUser {
  final String id;
  final int role;
  const DataUser({
    required this.id,
    required this.role,
  });
}

class UsersData {
  final String id;
  final String nama;
  final String email;
  final String kelas;
  final String alamat;
  final String? telSiswa;
  final String? telOrtu;
  final int role;
  UsersData({
    required this.id,
    required this.nama,
    required this.email,
    required this.kelas,
    required this.alamat,
    this.telSiswa,
    this.telOrtu,
    required this.role,
  });
}
