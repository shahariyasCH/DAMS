import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AlertsPage extends StatelessWidget {
  const AlertsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Locations'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          return false; // Prevent default behavior
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('alerts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return const Center(
                child: Text('No new alert!'),
              );
            }
            List<LatLng> coordinates = [];
            for (var doc in documents) {
              double latitude = doc['latitude'];
              double longitude = doc['longitude'];
              coordinates.add(LatLng(latitude, longitude));
            }
            return MapWidget(coordinates: coordinates);
          },
        ),
      ),
    );
  }
}
class MapWidget extends StatefulWidget {
  final List<LatLng> coordinates;
  const MapWidget({Key? key, required this.coordinates}) : super(key: key);
  @override
  _MapWidgetState createState() => _MapWidgetState();
}
class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapsController;
  final List<Marker> _markers = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.coordinates.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId('marker_$i'),
        position: widget.coordinates[i],
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _markers.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: GoogleMap(
                onMapCreated: (controller) {
                  setState(() {
                    mapsController = controller;
                  });
                },
                markers: Set<Marker>.of(_markers),
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target: widget.coordinates.first,
                  zoom: 13,
                ),
              ),
            )
          : const CircularProgressIndicator(color: Colors.amber),
    );
  }
}
