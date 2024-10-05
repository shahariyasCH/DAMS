import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dams_admin/pages/fetch_firestore.dart';
import 'package:flutter/material.dart';
class ResponsesPage extends StatelessWidget {
  const ResponsesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? selectedAlertId;
    TextEditingController replyController = TextEditingController();
    void sendReply(String replyMessage) {
      if (selectedAlertId != null) {
        CollectionReference alertsCollection =
            FirebaseFirestore.instance.collection('alerts');
        alertsCollection.doc(selectedAlertId).update({
          'replyMessage': replyMessage,
          'replyTimestamp': Timestamp.now(),
        });
        replyController.clear();
        selectedAlertId = null;
      }
    } 
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Alerts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center( // Center the CircularProgressIndicator
              child: FetchFirestore(
                filter:(doc) => true,
                onAlertSelected: (String alertId) {
                  selectedAlertId = alertId;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Enter Reply'),
                        content: TextField(
                          controller: replyController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your reply...',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              sendReply(replyController.text);
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Send'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
