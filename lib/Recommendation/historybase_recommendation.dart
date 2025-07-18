import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Categories/tour_description.dart';
import '../components/advanture_card.dart';

class HistoryBase extends StatefulWidget {
  const HistoryBase({Key? key}) : super(key: key);

  @override
  _HistoryBaseState createState() => _HistoryBaseState();
}

class _HistoryBaseState extends State<HistoryBase> {
  String? currentUserID;
  DatabaseReference paymentReference = FirebaseDatabase.instance.ref().child("Payments");
  List<Map<String, dynamic>> paymentData = [];
  List<Map<String, dynamic>> tours = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUserID = user?.uid;
    });

    if (currentUserID != null) {
      fetchPaymentDataForUser(currentUserID!);
    } else {
      print("User is not logged in.");
    }
  }

  void fetchPaymentDataForUser(String userID) async {
    print("Fetching payment data for user ID: $userID");
    try {
      final event = await paymentReference.orderByChild("id").equalTo(userID).once();

      final data = event.snapshot.value;

      print("Received payment data from the database: $data");

      if (data != null && data is Map) {
        List<Map<String, dynamic>> userPayments = [];
        Set<String> categories = Set();

        data.forEach((key, value) {
          if (value is Map && value['id'] == userID) {
            String category = value['category'];
            print("Category for user ID $userID: $category");
            categories.add(category);

            if (userPayments.isEmpty) {
              userPayments.add({key: value});
            }
          }
        });

        setState(() {
          paymentData = userPayments;
        });

        print("Payment data for user ID $userID: $userPayments");

        // Load data for each category
        categories.forEach((category) {
          loadData(category);
        });
      } else {
        print("No payment data found for user ID: $userID");
      }
    } catch (e) {
      print("Error fetching payment data: $e");
    }
  }

  void loadData(String category) {
    if (tours.isEmpty) {
      tours.clear();
      final ref = FirebaseDatabase.instance.ref().child('Tours').child(category);
      ref.onValue.listen((event) {
        final data = event.snapshot.value;
        if (data != null && data is Map) {
          final currentDate = DateTime.now();
          List<Map<String, dynamic>> highestRatedTours = [];

          data.forEach((key, value) {
            if (value is Map) {
              final adventureData = value as Map<Object?, Object?>;
              String dateStr = adventureData['Date']?.toString() ?? "";

              DateTime tripDate = parseCustomDate(dateStr);

              if (tripDate.isAtSameMomentAs(currentDate) || tripDate.isAfter(currentDate)) {
                tours.add({
                  "imageUrl": adventureData['ImageURL'].toString(),
                  "title": adventureData['Title']?.toString() ?? "",
                  "ratings": int.parse(adventureData['Rating']?.toString() ?? '0'),
                  "duration": adventureData['Duration']?.toString() ?? "",
                  "departure": adventureData['Departure']?.toString() ?? "",
                  "description": adventureData['Discription']?.toString() ?? "",
                  "price": double.parse(adventureData['Budget']?.toString() ?? '0.0'),
                  "Category": adventureData['Category']?.toString() ?? "",
                  "date": adventureData['Date']?.toString() ?? "",
                  "company": adventureData['Company']?.toString() ?? "",
                  "companyEmail": adventureData['CompanyEmail']?.toString() ?? "",
                });

                // Keep track of the highest-rated tours for each category
                if (highestRatedTours.length < 3 ||
                    int.parse(adventureData['Rating']?.toString() ?? '0') >
                        (highestRatedTours.last['ratings'] as int)) {
                  highestRatedTours.add({
                    "imageUrl": adventureData['ImageURL'].toString(),
                    "title": adventureData['Title']?.toString() ?? "",
                    "ratings": int.parse(adventureData['Rating']?.toString() ?? '0'),
                    "duration": adventureData['Duration']?.toString() ?? "",
                    "departure": adventureData['Departure']?.toString() ?? "",
                    "description": adventureData['Discription']?.toString() ?? "",
                    "price": double.parse(adventureData['Budget']?.toString() ?? '0.0'),
                    "Category": adventureData['Category']?.toString() ?? "",
                    "date": adventureData['Date']?.toString() ?? "",
                    "company": adventureData['Company']?.toString() ?? "",
                    "companyEmail": adventureData['CompanyEmail']?.toString() ?? "",
                  });

                  // Sort the highest-rated tours by ratings in descending order
                  highestRatedTours.sort((a, b) =>
                      (b["ratings"] as int).compareTo(a["ratings"] as int));

                  // Keep only the top 3 highest-rated tours for each category
                  highestRatedTours = highestRatedTours.take(3).toList();
                }
              }
            }
          });

          setState(() {
            // Update tours with the highest-rated tours for each category
            tours = [...highestRatedTours];
          });
        }
      });
    }
  }

  DateTime parseCustomDate(String dateStr) {
    final parts = dateStr.split('-');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } else {
      return DateTime(2000, 1, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sorting is not needed here, as the data is already sorted during loadData
    final top3Tours = tours;

    print("Building HistoryBase screen. Payment data: $paymentData");
    return Scaffold(
      appBar: AppBar(
        title: Text('History Base Recommendations', style: GoogleFonts.abel(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xff1034A6),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: top3Tours.map((tourData) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TourDescriptionScreen(data: tourData),
                  ),
                );
              },
              child: AdventureCard(
                imageUrl: tourData["imageUrl"],
                title: tourData["title"],
                duration: tourData["duration"],
                departure: tourData["departure"],
                price: tourData["price"],
                Category: tourData["Category"],
                date: tourData["date"],
                companyEmail: tourData["companyEmail"],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
