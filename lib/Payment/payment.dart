import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/custom_toast.dart';

class PaymentScreen extends StatelessWidget {
  final String title;
  final String duration;
  final String departure;
  final double price;
  final String company;
  final String category;

  const PaymentScreen({
    required this.title,
    required this.duration,
    required this.departure,
    required this.price,
    required this.company,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final newPrice = price * 0.3;
    final databaseReference = FirebaseDatabase.instance.reference();
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            onPressed: () {
              // Handle share button press here
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Handle logout here
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
        backgroundColor: Color(0xff1034A6),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xff1034A6),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 50,
                  child: Text(
                    'Strip Payment',
                    style: GoogleFonts.abel(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.15,
                  child: Image.asset(
                    'assets/Logo.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.435,
                  left: 50,
                  child: Text(
                    '$title',
                    style: GoogleFonts.abel(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1034A6),
                    ),
                  ),
                ),
                // Display other data here using similar Text widgets
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.45,
                  right: 30,
                  child: Text(
                    'Duration: $duration',
                    style: GoogleFonts.abel(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.47,
                  right: 30,
                  child: Text(
                    'Company: $company',
                    style: GoogleFonts.abel(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.45,
                  right: 30,
                  child: Text(
                    'Duration: $duration',
                    style: GoogleFonts.abel(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.48,
                  left: 50,
                  child: Text(
                    'Departure: $departure',
                    style: GoogleFonts.abel(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.51,
                  left: 50,
                  child: Text(
                    'Price: PKR $newPrice',
                    style: GoogleFonts.abel(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1034A6),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.55,
                  left: 50,
                  child: Text(
                    'Note: We will charge 30% of total amount for booking',
                    style: GoogleFonts.abel(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.57,
                  left: 50,
                  child: Text(
                    'and will charge remaining at the start of trip',
                    style: GoogleFonts.abel(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.63,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      backgroundColor: Color(0xff1034A6),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () async {
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user == null) {
                        // User is not authenticated, handle this case as needed
                        print('User not authenticated');
                        return;
                      }

                      String userID = user.uid;

                      Map<String, dynamic> paymentData = {
                        'title': title,
                        'duration': duration,
                        'departure': departure,
                        'price': price,
                        'status': 'Partially Paid',
                        'company': company,
                        'category': category,
                        'id': userID,
                      };
                      String companyName = company;
                      debugPrint('$userID');
                      int timestampInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

                      try {
                        await databaseReference
                            .child('Payments')
                            .child('$timestampInSeconds')
                            .set(paymentData);
                        print('Payment data uploaded to Payments node');
                      } catch (error) {
                        print('Error uploading payment data to Payments node: $error');
                      }

                      try {
                        await databaseReference
                            .child('$companyName')
                            .child('$timestampInSeconds')
                            .set(paymentData);
                        print('Payment data uploaded to new node under company name');
                        showCustomToast(context, "Your Trip is booked");
                        Future.delayed(Duration(seconds: 3), () {
                          showCustomToast(context, "Stripe is not available in Pakistan");
                        });
                      } catch (error) {
                        print('Error uploading payment data to new node under company name: $error');
                        showCustomToast(context, "Error Uploading Payment Data: $error");
                      }
                    },
                    child: Text(
                      "Pay a Trip",
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showCustomToast(BuildContext context, String message) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CustomToast(message: message),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
