// firebase_utils.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

Future<Map<String, dynamic>?> getCompanyDetails(String email) async {
  try {
    // Query the Company collection based on the email
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Company')
        .where('Email', isEqualTo: email)
        .limit(1)
        .get();

    // Check if any documents match the query
    if (snapshot.docs.isNotEmpty) {
      // Retrieve the data of the first document
      Map<String, dynamic> companyData = snapshot.docs[0].data()!;
      print("Company details retrieved: $companyData");
      return companyData;
    } else {
      print("Company does not exist");
      return null;
    }
  } catch (e) {
    print("Error retrieving company details: $e");
    return null;
  }
}

Future<List<Map<String, dynamic>>> getCompanyPayments(String companyName) async {
  try {
    DatabaseReference paymentsRef = FirebaseDatabase.instance.ref().child('Payments');

    // Use the `DatabaseEvent` type
    DatabaseEvent event = await paymentsRef.orderByChild('company').equalTo(companyName).once();

    // Access the snapshot property to get the DataSnapshot
    DataSnapshot snapshot = event.snapshot;

    print("Snapshot value: ${snapshot.value}");

    // Check if any data matches the query
    if (snapshot.value != null) {
      // Retrieve the data
      Map<dynamic, dynamic>? paymentsData = snapshot.value as Map?;

      if (paymentsData != null) {
        List<Map<String, dynamic>> payments = [];

        paymentsData.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            payments.add(Map<String, dynamic>.from(value));
          }
        });

        print("Payments retrieved: $payments");
        return payments;
      } else {
        print("Data in snapshot is null");
        return [];
      }
    } else {
      print("No payments found for the company");
      return [];
    }
  } catch (e) {
    print("Error retrieving payments: $e");
    return [];
  }
}