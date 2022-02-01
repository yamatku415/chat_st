import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ud_flutterlab/pages/top_page.dart';
import 'package:ud_flutterlab/utils/firebase.dart';
import 'package:ud_flutterlab/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefs.setInstance();
  checkAccount();

  runApp(MyApp());
}

Future<void> checkAccount() async {
  String uid = SharedPrefs.getUid();
  if (uid == '') {
    Firestore.addUser();
  } else {
    Firestore.getRooms(uid);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopPage(),
    );
  }
}
