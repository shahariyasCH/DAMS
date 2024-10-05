import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for authentication
import 'pages/admin_panel_home.dart';
import 'pages/alerts_page.dart';
import 'pages/responses_page.dart';
import 'pages/settings_page.dart';
import 'pages/login_page.dart'; // Import your login page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB2C3-nX9EX5sp9VDfPVPZO8llw287ylw0",
      authDomain: "dams-232cd.firebaseapp.com",
      projectId: "dams-232cd",
      storageBucket: "dams-232cd.appspot.com",
      messagingSenderId: "1063123971943",
      appId: "1:1063123971943:web:75ab4e6888c65b90bf49c2",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disaster Alert Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the initial route to your login page
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        if (settings.name == '/login' || isAuthenticated()) {
          // If the route is '/login' or the user is authenticated, allow access to the route
          return MaterialPageRoute(
            builder: (context) {
              switch (settings.name) {
                case '/login':
                  return const LoginPage();
                case '/home':
                  return const AdminPanelHomePage();
                case '/alerts':
                  return const AlertsPage();
                case '/responses':
                  return const ResponsesPage();
                case '/settings':
                  return const SettingsPage();
                default:
                  return const Scaffold(
                    body: Center(
                      child: Text('404 - Page not found'),
                    ),
                  );
              }
            },
          );
        } else {
          // If the user is not authenticated, redirect to the login page
          return MaterialPageRoute(builder: (context) => const LoginPage());
        }
      },
    );
  }

  // Function to check if the user is authenticated using Firebase Authentication
  bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
