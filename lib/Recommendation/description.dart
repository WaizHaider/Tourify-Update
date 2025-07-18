import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/Reviews/reviews.dart';
import 'package:tourify/user_Auth_login_screens/SignIn.dart';

import '../History/trip.dart';
import '../Payment/payment.dart';

class DescriptionScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  DescriptionScreen({required this.data});
  Future<List<int>> fetchRatings() async {
    try {
      DataSnapshot snapshot =
          (await FirebaseDatabase.instance.ref().child('Ratings').child(data['Company'] ?? '').once()).snapshot;

      List<int> ratingsList = [];

      if (snapshot.value != null) {
        Map<dynamic, dynamic> ratingsData =
        (snapshot.value as Map<dynamic, dynamic>);
        ratingsData.forEach((key, value) {
          int ratingValue = value['rating'];
          ratingsList.add(ratingValue);
        });
      }

      return ratingsList;
    } catch (e) {
      print('Error fetching ratings: $e');
      return [];
    }
  }



  double calculateAverage(List<int> ratings) {
    if (ratings.isEmpty) {
      return 0.0; // Return 0 if there are no ratings
    }

    double sum = ratings.map((value) => value.toDouble()).reduce((value, element) => value + element);
    return sum / ratings.length;
  }
// Function to log out and navigate to the login screen
  void logoutAndNavigateToLogin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } catch (e) {
      print("Error logging out: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tour Description", style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
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
                logoutAndNavigateToLogin(context);
                // Handle logout here
              }else if(value == 'trips'){
                Navigator.push(context, MaterialPageRoute(builder: (context) => YourTrips()));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'trips',
                  child: Text('Your Trips'),
                ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
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
                    )),
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Positioned(
                  top: 100,
                  child: Image.network(
                    data['ImageURL'] ?? 'https://example.com/default_image.jpg',
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                  ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.435,
                    left: 50,
                    child: Text('${data['Title'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.47,
                    left: 50,
                    child: Text('Category: ${data['Category'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),)),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.49,
                  left: 50,
                  child: FutureBuilder<List<int>>(
                    future: fetchRatings(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}',style:
                        GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),);
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No ratings available.',style:
                        GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),);
                      } else {
                        double average = calculateAverage(snapshot.data!);
                        return Text('Rating: ${average.toStringAsFixed(2)}',style:
                        GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),);
                      }
                    },
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.47,
                    right: 50,
                    child: Text('Duration: ${data['Duration'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.49,
                    right: 50,
                    child: Text('Company: ${data['Company'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.51,
                    left: 50,
                    child: Text('Contact: ${data['companyEmail'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.528,
                    left: 50,
                    child: Text('Departure: ${data['departure'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),)),

                Positioned(
                    top: MediaQuery.of(context).size.height * 0.555,
                    left: 50,
                    child: Text('Description: ${data['description'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.68,
                    right: 50,
                    child: Text('Price: PKR ${data['Budget'] ?? 0.0}', style:
                    GoogleFonts.abel(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.45,
                    right: 40,
                    child: Text('Date: ${data['Date'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),)),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.72,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      backgroundColor: Color(0xff1034A6),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            title: data['Title'] ?? '',
                            duration: data['Duration'] ?? '',
                            departure: data['Departure'] ?? '',
                            price: double.parse(data['Budget']) ?? 0,
                            company: data['Company'] ??'',
                            category: data['Category'] ??'',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Book a Trip",
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  ,),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.68,
                  left: 40,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsScreen()));
                    },
                    child: Text('See Reviews', style: GoogleFonts.abel(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
