import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import 'next_screen.dart';

class CustomizedOption extends StatefulWidget {
  const CustomizedOption({Key? key}) : super(key: key);

  @override
  _CustomizedOptionState createState() => _CustomizedOptionState();
}

class _CustomizedOptionState extends State<CustomizedOption> {
  final priceController = TextEditingController();
  final daysController = TextEditingController();
  final departureController = TextEditingController();
  final destinationController = TextEditingController();
  String selectedValue = 'Adventure';
  DateTime? selectedDate;
  DateTime? initialDate = DateTime.now();
  List<String> category = [
    'Adventure',
    'Historical',
    'Religious',
    'Sight Seeing',
    'Family n Friends'
  ];
  final selectedDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customize Option',
          style: GoogleFonts.abel(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Color(0xff1034A6),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Customize Your Recommendation',
                style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: category.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Category Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 330,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: departureController,
                validator: (value) => value!.isEmpty ? 'Enter departure' : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_history),
                  labelText: 'Departure',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                  hintText: 'Enter departure',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent),
                ),
                style: GoogleFonts.abel(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 330,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: destinationController,
                validator: (value) => value!.isEmpty ? 'Enter destination' : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_city_rounded),
                  labelText: 'Destination',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                  hintText: 'Enter destination',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent),
                ),
                style: GoogleFonts.abel(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 330,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: daysController,
                validator: (value) => value!.isEmpty ? 'Enter Days' : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.timelapse_rounded),
                  labelText: 'Duration',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                  hintText: 'Enter Days',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent),
                ),
                style: GoogleFonts.abel(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 330,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                validator: (value) => value!.isEmpty ? 'Enter Price Range' : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.price_change_rounded),
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                  hintText: 'Enter Price Range',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent),
                ),
                style: GoogleFonts.abel(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 330,
              child: TextFormField(
                enabled: false,
                controller: selectedDateController,
                decoration: InputDecoration(
                  labelText: 'Selected Date',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent),
                ),
                style: GoogleFonts.abel(color: Color(0xff1034A6), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff01e90ff),
                elevation: 20,
                shadowColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );

                if (selectedDate != null) {
                  selectedDateController.text =
                  "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}";
                }

                setState(() {});
              },
              child: Text(
                'Choose Date',
                style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff01e90ff),
                elevation: 20,
                shadowColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: navigateToNextScreen,
              child: Text(
                'Next',
                style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToNextScreen() {
    if (selectedDate != null) {
      // Format the selected date as "dd-MM-yyyy"
      var formattedDate =
          "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}";

      // TODO: Implement navigation to the next screen and pass the data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NextScreen(
            category: selectedValue,
            departure: departureController.text,
            destination: destinationController.text,
            duration: daysController.text,
            priceRange: priceController.text,
            selectedDate: formattedDate,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Please choose a date');
    }
  }
}
