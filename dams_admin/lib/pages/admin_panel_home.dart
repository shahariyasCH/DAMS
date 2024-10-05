import 'package:dams_admin/pages/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart'; // Import your LoginPage

class AdminPanelHomePage extends StatelessWidget {
  const AdminPanelHomePage({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    try {
      // Show circular loading indicator while logging out
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      await FirebaseAuth.instance.signOut();
      // Navigate to the login page after successful logout
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } catch (e) {
      // Close the loading indicator if an error occurs during logout
      Navigator.pop(context);
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 136, 189, 232), // Set app bar color
        title: const Text('Disaster Alert Admin Panel'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => _logout(context),
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      body: const ResponsiveLayout(
        mobileLayout: MobileLayout(),
        tabletLayout: TabletLayout(),
        desktopLayout: DesktopLayout(),
      ),
    );
  }
}
