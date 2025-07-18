import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pagethree extends StatelessWidget {
  const Pagethree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/traveller.jpeg',
                    ),
                    fit: BoxFit.cover))),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome to Tourify",
                  style: GoogleFonts.montserrat(
                      fontSize: 25.0, fontWeight: FontWeight.bold)),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Text("All your travel plans in one place",
                  style: GoogleFonts.montserrat(
                      fontSize: 15.0, fontWeight: FontWeight.w300)),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1E90FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 10,
                  
                ),
                onPressed: (){
                  Navigator.pushNamed(context, 'HomeScreen');
                },
                child:  const Text("Get Started"), 
              )
              
            ],
          ),
        )
      ],
    ));
  }
}
