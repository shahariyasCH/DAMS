import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dams/pages/alert.dart';
import 'package:dams/pages/home_page.dart';
import 'package:dams/pages/management.dart';
import 'package:dams/pages/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, Key? keys});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Alert alert;
  late Management management;
  late Profile profile;

  @override
  void initState() {
    homepage = const Home();
    alert = const Alert();
    management = const Management();
    profile = Profile();
    pages = [homepage, alert, management, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        color: const Color.fromARGB(255, 86, 116, 181),
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.add_alert_sharp,
              color: Color.fromARGB(255, 176, 16, 16)),
          Icon(Icons.computer_rounded, color: Colors.white),
          Icon(Icons.person_outline_rounded, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex],
    )
    );
  }
}
