import 'package:absensi/auth_services.dart';
import 'package:absensi/firebase_options.dart';
import 'package:absensi/widget/screen/admin/add_siswa.dart';
import 'package:absensi/widget/screen/admin/edit_siswa.dart';
import 'package:absensi/widget/screen/home.dart';
import 'package:absensi/widget/screen/guru/list_absen.dart';
import 'package:absensi/widget/screen/login.dart';
import 'package:absensi/widget/screen/profile.dart';
import 'package:absensi/widget/screen/super_admin/edit_user.dart';
import 'package:absensi/widget/screen/super_admin/list_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return const _MyApp();
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp();

  @override
  State<_MyApp> createState() => __MyAppState();
}

class __MyAppState extends State<_MyApp> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser != null) {
        setState(() {
          AuthServices.updateUserData();
        });
      }
    });
    return MaterialApp(
      title: 'Absensi',
      routes: {
        "/profile": (context) => const ProfileScreen(),
        "/home": (context) => const HomeScreen(),
        "/login": (context) => const LoginScreen(),
        "/list-absen": (context) => const ListAbsenScreen(),
        "/list-user": (context) => const ListUserScreen(),
        "/edit-user": (context) => const EditUserScreen(),
        "/edit-siswa": (context) => const EditSiswaScreen(),
        "/add-siswa": (context) => const AddSiswaScreen(),
      },
      initialRoute: "/home",
    );
  }
}
