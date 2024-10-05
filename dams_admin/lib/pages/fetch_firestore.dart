import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class FetchFirestore extends StatefulWidget {
  final Function(String) onAlertSelected;
  final bool Function(QueryDocumentSnapshot<Map<String, dynamic>>) filter;
  const FetchFirestore({Key? key, required this.onAlertSelected, required this.filter}) : super(key: key);
  @override
  _FetchFirestoreState createState() => _FetchFirestoreState();
}
class _FetchFirestoreState extends State<FetchFirestore> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('alerts')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        if (documents.isEmpty) {
          return const Center(child: Text('No new Alerts!')); // Display this message when there are no alerts
        }
        return ListView(
          children: documents.map((doc) {
            return Card(
              child: ListTile(
                title: Text('disaster: ${doc['disaster']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Message:               ${doc['message']}'),
                    Text('Latitude:               ${doc['latitude']}'),
                    Text('Longitude:          ${doc['longitude']}'),
                    Text('Timestamp:        ${doc['timestamp'].toDate()}'),
                    Text('User ID:               ${doc['userId']}'),
                    Text('Name:                  ${doc['name']}'),
                    Text('Phonenumber:    ${doc['phoneNumber']}'),
                  ],
                ),
                onTap: () {
                  widget.onAlertSelected(doc.id);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
