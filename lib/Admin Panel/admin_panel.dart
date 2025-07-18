import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/common_widgets/arc.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Arc(),
        const SizedBox(
          height: 300,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.pushNamed(context, 'Approved');
                },
                child: Text(
                  'Approved',
                  style: GoogleFonts.abel(fontSize: 20, color: Colors. white),
                )),
           
                 ElevatedButton(
                  style: ElevatedButton.styleFrom( padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.pushNamed(context, 'Pending');
                },
                child: Text(
                  'Pending',
                  style: GoogleFonts.abel(fontSize: 20, color: Colors.white),
                )),
          ],
        )
      ],
    ));
  }
}
