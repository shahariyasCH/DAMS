import 'package:flutter/material.dart';
import 'package:dams/pages/login_page.dart';
import 'package:dams/pages/registerpage.dart';


class Loginorsignpage extends StatefulWidget {
  const Loginorsignpage({super.key});

  @override
  State<Loginorsignpage> createState() => _Loginorsignpagestate();
}

class _Loginorsignpagestate extends State<Loginorsignpage> {
  bool showLoginpage = true;

  void togglepages() {
    setState((){
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return LoginPage(
        onTap: togglepages,
      );
    } else {
      return RegisterPage(
        onTap: togglepages,
      );
    }
  }
}