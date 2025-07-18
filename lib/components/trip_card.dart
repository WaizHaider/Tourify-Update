import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class TripCard extends StatelessWidget {
  final String title;
  final String company;
  final String duration;
  final String departure;
  final double price;
  final String status;
  const TripCard({
    required this.company, required this.title, required this.status, required this.duration, required this.departure, required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.pink,
      height: 280,
      width: 300,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: Card(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text(title,style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),
                        ),
                        SizedBox(height: 5,),
                        Text(duration,style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                        SizedBox(height: 5,),
                        Text("Departure: "+departure,style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                        SizedBox(height: 5,),
                        Text("Company: $company ",style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                        SizedBox(height: 5,),
                        Text("Status: $status ",style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 210,
              right: 30,
              child:Container(
                height: 60,
                width: 90,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff1034A6)
                ),
                child: Center(child: Text("PKR "+ "$price", style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
              ))

        ],
      ),
    );
  }
}
