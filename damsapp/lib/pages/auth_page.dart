import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dams/pages/bottomnav.dart';
import 'package:dams/pages/loginorsign.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //user logged in
          if (snapshot.hasData) {
            return const BottomNav();
          }

          // user not logged in
          else{
            return const Loginorsignpage();
          }
        },
      ),
    );
  }
}