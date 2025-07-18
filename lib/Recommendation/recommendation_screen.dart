import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/Recommendation/customize_option.dart';
import 'package:tourify/Recommendation/historybase_recommendation.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations', style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: Color(0xff1034A6),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 1,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xff1034A6),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0))),
                    child: Image.asset(
                      'assets/Logo.png',
                      height: 90,
                      width: 90,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height*0.25,
                  child: Text(
                    "What's Your Choice",
                    style: GoogleFonts.abel(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height*0.3,
                    child: Text('Choose your recommendation type',                      style: GoogleFonts.abel(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),),),
                Positioned(
                  top: MediaQuery.sizeOf(context).height*0.4,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HistoryBase()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff1034A6),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      height: 40,
                      width: 180,
                      child: Center(
                        child: Text("History Base",
                        style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                      ),
                ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height*0.48,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomizedOption()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff1034A6),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      height: 40,
                      width: 180,
                      child: Center(
                        child: Text("Customized",
                          style: GoogleFonts.abel(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
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
