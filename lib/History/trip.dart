import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../user_Auth_login_screens/SignIn.dart';

class YourTrips extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.ref();
  String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  final DatabaseReference ratingsRef = FirebaseDatabase.instance.ref().child("Ratings");


  void logoutAndNavigateToLogin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } catch (e) {
      print("Error logging out: $e");
    }
  }
  double userRating = 0;
  void showRateTourDialog(BuildContext context, String title, String company) {
    double userRating = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rate the Tour'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Company: $company', style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 18,),),
              Text('Tour: $title', style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff1034A6))),
              RatingBar.builder(
                initialRating: userRating, // Set initial rating to 0
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  userRating = rating;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Submit',style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xff1034A6)),),
              onPressed: () {
                // Handle the rating submission
                Map<String, dynamic> ratingData = {
                  'company': company,
                  'rating': userRating,
                };
                String? randomKey = ratingsRef.child(company).push().key;
                ratingsRef.child(company).child(randomKey!).set(ratingData); // Use 'title' instead of 'company'
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xff1034A6)),
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tour History"),
        backgroundColor: Color(0xff1034A6),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0, left: 10, right: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: MediaQuery.of(context).size.width,
                      child: FirebaseAnimatedList(
                        query: dbRef
                            .child('Payments')
                            .orderByChild('id')
                            .equalTo(currentUserId),
                        itemBuilder: (BuildContext context, DataSnapshot snapshot,
                            Animation<double> animation, int index) {
                          debugPrint("Data snapshot: ${snapshot.value}");
                          final title = snapshot.child('title').value.toString();
                          final status = snapshot.child('status').value.toString();
                          final price = snapshot.child('price').value.toString();
                          final duration = snapshot.child('duration').value.toString();
                          final departure = snapshot.child('departure').value.toString();
                          final company = snapshot.child('company').value.toString();

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              title,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              duration,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "PKR $price",
                                          style: TextStyle(
                                            color: Color(0xff1034A6),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          company,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Departure: $departure",
                                          style: TextStyle(
                                            color: Color(0xff1034A6),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          status,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showRateTourDialog(context, title, company);
                                          },
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              width: 85,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey.shade300
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: Text(
                                                  "Rate the Tour",
                                                  style: GoogleFonts.abel(fontSize: 15, color: Color(0xff1034A6),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}