import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> LoadImage() async {
      await precacheImage(const AssetImage('assets/Logo.png'), context);
    }

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Stack(
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
        ),
        const SizedBox(
          height: 200,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.pushNamed(context, 'SignInScreen');
            },
            child: Text(
              'Login',
              style:
              GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                foregroundColor: const Color(0xff1E90FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.pushNamed(context, 'SignUpScreen');
            },
            child: Text(
              'SignUp',
              style: GoogleFonts.abel(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),


        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                foregroundColor: const Color(0xff1E90FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.pushNamed(context, 'AdminRegistration');
            },
            child: Text(
              'Admin Login',
              style: GoogleFonts.abel(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'OfflineMaps');
            },
            icon: const Icon(Icons.location_on),
            label: Text(
              'Map',
              style:
              GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ]),
    );
  }
}