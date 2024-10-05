import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Alert extends StatefulWidget {
  const Alert({super.key, Key? keys});
  @override
  _AlertState createState() => _AlertState();
}
class _AlertState extends State<Alert> {
  List<String> disasterTypes = [
    "Earthquake","Flood","Fire","Tornado","Hurricane","Wildfire","Avalanche","Landslide","Volcanic Eruption","Tsunami",
    "Blizzard","Sandstorm","Cyclone","Sinkhole","Thunderstorm","Hailstorm","Chemical Spill","Nuclear Accident","Oil Spill",
    "Biological Hazard","Explosion","Infrastructure Failure","Air Quality Emergency",
  ];
  bool showUnwantedAlertMessage = false;
  String? selectedDisasterType;
  String? userMessage;
  bool sendingAlert = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("DAMS"),
            backgroundColor: const Color.fromARGB(255, 86, 116, 181),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Icon(
                      Icons.warning,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: sendingAlert ? null : () => _showDisasterAlert(context),
                    child: const Text("Raise Alert"),
                  ),
                  const SizedBox(height: 20),
                  if (showUnwantedAlertMessage)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Warning: Unauthorized use of the alert system may result in penalties. Ensure alerts are valid and necessary.",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (sendingAlert)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  void _showDisasterAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Disaster Alert"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select the type of disaster:"),
                  DropdownButton<String>(
                    value: selectedDisasterType,
                    items: disasterTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedDisasterType = value;
                      });
                    },
                    hint: selectedDisasterType != null
                        ? Text('$selectedDisasterType')
                        : const Text("Select"),
                  ),
                  const SizedBox(height: 20),
                  const Text("Enter your message:"),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Enter your message...",
                    ),
                    onChanged: (value) {
                      setState(() {
                        userMessage = value; // Update the userMessage variable
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _sendAlert(); // Start sending alert
                Navigator.pop(context);
              },
              child: const Text("Confirm"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _sendAlert() async {
    setState(() {
      sendingAlert = true; // Set sendingAlert flag to true
    });
    await _fetchAndSaveUserLocation();
    setState(() {
      sendingAlert = false; // Set sendingAlert flag to false when done
    });
  }

  Future<void> _fetchAndSaveUserLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return;
    }
  }
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userId = user.uid;
    final userDoc = await FirebaseFirestore.instance.collection('profiles').doc(userId).get();
    if (userDoc.exists) {
      final userName = userDoc.get('name');
      final userPhoneNumber = userDoc.get('phoneNumber');
      await FirebaseFirestore.instance.collection('alerts').add({
        'userId': userId,'name': userName,'phoneNumber': userPhoneNumber,'disaster': selectedDisasterType,
        'message': userMessage,'latitude': position.latitude,'longitude': position.longitude,'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alert raised successfully!')),
      );
    } 
  }
}

void main() {
  runApp(const MaterialApp(
    home: Alert(),
  ));
}
}