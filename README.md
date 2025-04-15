Disaster Alert & Management System (DAMS)

A real-time Disaster Alert & Management System (DAMS) built using Flutter and Firebase, designed to enhance communication between citizens and disaster management authorities during emergency situations. The system includes both a mobile app for users and a web-based control panel for response teams.

Key Features

-  User Mobile App (Flutter)
  - Send real-time emergency alerts with a single tap
  - Automatically share GPS location using Google Maps API
  - View acknowledgment or instructions from control center

-  Admin Web Control Panel
  - Monitor incoming alerts on a live map
  - Filter and prioritize incidents by severity/location
  - Respond to users and mark emergencies as resolved

-  Geolocation & Mapping
  - Integrated Google Maps API for live location tracking
  - Visualize alerts geographically for better decision-making

 Tech Stack

- Mobile App: Flutter (Dart)
- Backend/Database: Firebase (Authentication + Firestore + Cloud Messaging)
- Maps: Google Maps API
- Web Dashboard: Flutter Web / Firebase Hosting (or other stack as applicable)

 Installation

 For Mobile App

```bash
# Clone the repo
git clone https://github.com/shahariyasCH/DAMS.git
cd DAMS/mobile-app

# Get packages
flutter pub get

# Run on emulator or device
flutter run
