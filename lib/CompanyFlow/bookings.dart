import 'package:flutter/material.dart';
import '../Utilities/firebase_utlis.dart'; // Assuming your file is named firebase_utils.dart

class Bookings extends StatelessWidget {
  final String? currentUserEmail;

  const Bookings({Key? key, required this.currentUserEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('$currentUserEmail');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        elevation: 0,
        backgroundColor: const Color(0xff1034A6),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: currentUserEmail != null ? getCompanyDetails(currentUserEmail!) : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null) {
            return Center(child: Text('Company details not found'));
          } else {
            // Use the company name from the retrieved data
            String companyName = snapshot.data!['Company name'];
            print("Company Name: $companyName");  // Print company name for debugging

            // Use companyName to fetch company payments
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: getCompanyPayments(companyName),
              builder: (context, paymentsSnapshot) {
                if (paymentsSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (paymentsSnapshot.hasError) {
                  return Center(child: Text('Error fetching payments: ${paymentsSnapshot.error}'));
                } else {
                  List<Map<String, dynamic>> payments = paymentsSnapshot.data ?? [];

                  // Display payment data in cards
                  return ListView.builder(
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text('Title: ${payments[index]['title']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Duration: ${payments[index]['duration']}'),
                              Text('Departure: ${payments[index]['departure']}'),
                              Text('Category: ${payments[index]['category']}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
