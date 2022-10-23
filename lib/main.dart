import 'package:absensi/firebase_options.dart';
import 'package:absensi/widget/screen/admin/edit_siswa.dart';
import 'package:absensi/widget/screen/home.dart';
import 'package:absensi/widget/screen/guru/list_absen.dart';
import 'package:absensi/widget/screen/login.dart';
import 'package:absensi/widget/screen/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi',
      routes: {
        "/home": (context) => const HomeScreen(),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/list-absen": (context) => const ListAbsenScreen(),
        "/edit-siswa": (context) => const EditSiswaScreen()
      },
      initialRoute: "/login",
    );
  }
}
