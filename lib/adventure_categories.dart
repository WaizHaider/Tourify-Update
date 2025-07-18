import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/Categories/family_friends.dart';
import 'package:tourify/Categories/historical.dart';
import 'package:tourify/Categories/religious.dart';
import 'package:tourify/Categories/sightseeing.dart';

import 'Categories/adventurous.dart';

class AdventureCategory extends StatelessWidget {
  const AdventureCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height:MediaQuery.sizeOf(context).height*1.5,
                  width: MediaQuery.sizeOf(context).width,
                ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width*0.8,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 1.0),
                              child: Divider(color: Colors.white, thickness: 1,),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pick an Advanture',style:
                              GoogleFonts.abel(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                              // DropdownButton(items: , onChanged: onChanged)
                              Padding(
                                padding: const EdgeInsets.only(left: 64.0),
                                child: Icon(Icons.keyboard_arrow_down,color:Colors.white, size: 14,),
                              ),
                              Text('Filter',
                                style:
                                GoogleFonts.abel(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 140,

                    child: Column(children: [

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AdventurousScreen()));
                      debugPrint("Han jani ho rha he");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(image: AssetImage('assets/adventure.jpg'),
                          fit: BoxFit.cover,),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 150,
                      width:300,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Adventurous Tours',
                          style:
                          GoogleFonts.abel(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          debugPrint("Han jani ho rha he1");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReligiousScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(image: AssetImage('assets/religious.jpg'),
                              fit: BoxFit.cover,),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 150,
                          width:300,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Religious Tours',
                              style:
                              GoogleFonts.abel(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SightSeeing()));
                          debugPrint("Han jani ho rha he2");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(image: AssetImage('assets/sightseeing.jpg'),
                              fit: BoxFit.cover,),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 150,
                          width:300,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Sight Seeing Tours',
                              style:
                              GoogleFonts.abel(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HistoricalScreen()));
                          debugPrint("Han jani ho rha he2");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(image: AssetImage('assets/historical.jpg'),
                              fit: BoxFit.cover,),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 150,
                          width:300,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Historical Tours',
                              style:
                              GoogleFonts.abel(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsNFamily()));
                          debugPrint("Han jani ho rha he2");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(image: AssetImage('assets/family.png'),
                              fit: BoxFit.cover,),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 150,
                          width:300,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Family-Friends Tours',
                              style:
                              GoogleFonts.abel(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                ],))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
