import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  final String imagetitle;
  final String title;
  const HomeCard({super.key, required this.imagetitle,required this.title});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: AssetImage(widget.imagetitle),
              fit: BoxFit.cover,
            ),
          ),
          height: 100,
          width: 200,
        ),
          Positioned(
          top: 40,
          left: 50,
          child:   Text(
            widget.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
