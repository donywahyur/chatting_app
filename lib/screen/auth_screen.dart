import 'package:chatting_app/widget/form_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  //constructor

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void submitFormFn(
      String username, String email, String password, bool isLogin) async {
    try {
      if (isLogin) {
        //login
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        //signup
        final result =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //update displayname
        await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
        FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: FormAuth(submitForm: submitFormFn),
    );
  }
}
