import 'package:flutter/material.dart';

class Arc extends StatelessWidget {
  const Arc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Future<void> LoadImage() async {
      await precacheImage(const AssetImage('assets/Logo.png'), context);
    }
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Color(0xff1034A6),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0))),
        ),
        Positioned(
          top: 200,
          child: FutureBuilder(
            future: LoadImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Image.asset(
                  'assets/Logo.png',
                  height: 300,
                  width: 250,
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
