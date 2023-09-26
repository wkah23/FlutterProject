import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
  User? user = FirebaseAuth.instance.currentUser;
  String userEmail = "";

class _HomeScreenState extends State<HomeScreen> {
  // final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    userEmail = user!.email!;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              Text(
                "환영합니다!  $userEmail 님",
                style: const TextStyle(fontSize: 20, 
                                       fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}