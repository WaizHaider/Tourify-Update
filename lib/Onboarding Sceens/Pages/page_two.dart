import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Pagetwo extends StatelessWidget {
  const Pagetwo({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        70.0,
                      ),
                      color: Colors.blueGrey),
                  child: const Image(
                    image: AssetImage('assets/maps.jpg'),
                    fit: BoxFit.cover,
                  )),
            ),
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,  
            ),
             Container(
              width: MediaQuery.of(context).size.width * 0.8,
               child: Text(
                "Map out your upcoming travels and organize them into a perfect travel plan",
                style: GoogleFonts.montserrat(
                  fontSize: 15.0,
                  color: Colors.blueGrey
                
                ),
                maxLines: 3,
                textAlign: TextAlign.center,
                         ),
             )
          ],
        ),
      ),
    );
  }
}
