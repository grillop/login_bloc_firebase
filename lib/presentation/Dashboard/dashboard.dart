import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final user = FirebaseAuth.instance.currentUser!;
    return MainPage(user: user);
  }
}
