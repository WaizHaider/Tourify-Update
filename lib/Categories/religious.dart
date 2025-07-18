import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/Categories/tour_description.dart';
import 'package:tourify/components/advanture_card.dart';

import '../HomeScreen.dart';

class ReligiousScreen extends StatefulWidget {
  const ReligiousScreen({super.key});

  @override
  _ReligiousScreenState createState() => _ReligiousScreenState();
}

class _ReligiousScreenState extends State<ReligiousScreen> {
  String selectedFilter = "Low to High"; // Default filter

  // Define your filter options
  List<String> filterOptions = [
    "Low to High",
    "High to Low",
    // Add more filter options as needed
  ];
  List<Map<String, dynamic>> tours = [];
  @override
  void initState() {
    super.initState();
    loadData(selectedFilter);
  }
  void logoutAndNavigateToLogin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Religious Tours", style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pick an Adventure',
                            style: GoogleFonts.abel(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Filter: ',
                                style: GoogleFonts.abel(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 29,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: DropdownButton<String>(
                                  value: selectedFilter,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedFilter = newValue!;
                                      loadData(selectedFilter);
                                    });
                                  },
                                  style: TextStyle(color: Colors.black), // Set the text color for the selected item
                                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                                  items: filterOptions.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 10, // Set the font size for the dropdown menu items
                                          color: Colors.black, // Set the text color for the dropdown menu items
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Column(
              children: tours.map((tourData) {
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
          ],
        ),
      ),
    );
  }
  void loadData(String filter) {
    tours.clear();
    final ref = FirebaseDatabase.instance.ref().child('Tours').child('Religious');
    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        final currentDate = DateTime.now();

        data.forEach((key, value) {
          if (value is Map) {
            final adventureData = value as Map<Object?, Object?>;

            // Add debug prints to check for null values
            print("AdventureData: $adventureData");

            // Check if key fields are not null before using them
            if (adventureData['Date'] != null &&
                adventureData['Rating'] != null &&
                adventureData['Budget'] != null &&
                adventureData['ImageURL'] != null &&
                adventureData['Title'] != null &&
                adventureData['Duration'] != null &&
                adventureData['Departure'] != null &&
                adventureData['Discription'] != null &&
                adventureData['Category'] != null &&
                adventureData['Company'] != null) {
              String dateStr = adventureData['Date'].toString();
              DateTime tripDate = parseCustomDate(dateStr);

              // Check if the trip date is today or in the future
              if (tripDate.isAtSameMomentAs(currentDate) || tripDate.isAfter(currentDate)) {
                tours.add({
                  "imageUrl": adventureData['ImageURL'].toString(),
                  "title": adventureData['Title'].toString(),
                  "ratings": int.parse(adventureData['Rating']?.toString() ?? '0'),
                  "duration": adventureData['Duration']?.toString() ?? "",
                  "departure": adventureData['Departure']?.toString() ?? "",
                  "description": adventureData['Discription']?.toString() ?? "",
                  "price": double.parse(adventureData['Budget']?.toString() ?? '0.0'),
                  "Category": adventureData['Category']?.toString() ?? "",
                  "date": adventureData['Date']?.toString() ?? "",
                  "company": adventureData['Company']?.toString() ?? "",
                  'companyEmail': adventureData['CompanyEmail'?.toString()??""],
                  // ... (rest of the fields)
                });
              }
            } else {
              // Add debug print to identify which field is null
              print("Null field in adventureData: $adventureData");
            }
          }
        });

        // Sort tours based on the selected filter
        if (filter == "Low to High") {
          tours.sort((a, b) => a["price"].compareTo(b["price"]));
        } else if (filter == "High to Low") {
          tours.sort((a, b) => b["price"].compareTo(a["price"]));
        }

        setState(() {
          print("Number of tours: ${tours.length}");
        });
      }
    });
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
}
