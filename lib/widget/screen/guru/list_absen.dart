import 'package:absensi/auth_services.dart';
import 'package:absensi/constant/current_date.dart';
import 'package:absensi/widget/ui/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListAbsenScreen extends StatefulWidget {
  const ListAbsenScreen({super.key});

  @override
  State<ListAbsenScreen> createState() => _ListAbsenScreenState();
}

class _ListAbsenScreenState extends State<ListAbsenScreen> {
  List<DataSiswa> dataSiswa = [];

  void fetchDatabase() {
    FirebaseDatabase.instance
        .ref("siswa")
        .onValue
        .listen((DatabaseEvent event) {
      DataSnapshot snap = event.snapshot;
      if (snap.exists && snap.value != null) {
        List<DataSiswa> tempDataSiswa = [];
        for (var child in snap.children) {
          String day = CurrentDate.getDay().toLowerCase();
          tempDataSiswa.add(DataSiswa(
            id: child.child("id").value as String,
            nama: (child.child("nama").value as String).isNotEmpty
                ? child.child("nama").value as String
                : "-",
            email: (child.child("email").value as String).isNotEmpty
                ? child.child("email").value as String
                : "-",
            kelas: (child.child("kelas").value as String).isNotEmpty
                ? child.child("kelas").value as String
                : "-",
            keteranganHadir:
                (child.child("absensi/$day/hadir/status").value as String)
                        .isNotEmpty
                    ? child
                        .child("absensi/${CurrentDate.getDay()}/hadir/status")
                        .value as String
                    : "-",
          ));
        }
        setState(() {
          dataSiswa = tempDataSiswa;
        });
      }
    });
  }

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
          (AuthServices.currentUser?.role == 1) ||
          (AuthServices.currentUser?.role == 2))) {
        Navigator.popUntil(context, ModalRoute.withName("/home"));
      } else {
        setState(() {
          fetchDatabase();
        });
      }
    });
    return Scaffold(
      appBar: const MyAppBar(title: "List Absen"),
      body: ListView.builder(
        itemCount: dataSiswa.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
                      dataSiswa[index].nama,
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      dataSiswa[index].email,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      dataSiswa[index].kelas,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DataSiswa {
  final String id;
  final String nama;
  final String email;
  final String kelas;
  final String keteranganHadir;
  const DataSiswa({
    required this.id,
    required this.nama,
    required this.email,
    required this.kelas,
    required this.keteranganHadir,
  });
}
