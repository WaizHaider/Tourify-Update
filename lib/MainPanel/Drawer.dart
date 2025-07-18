import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/CompanyFlow/Company_Login_Authentication/company_login.dart';
import 'package:tourify/Recommendation/recommendation_screen.dart';

import '../History/trip.dart';

class MainPanelDrawer extends StatelessWidget {
  MainPanelDrawer({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;
  void logoutAndNavigateToLogin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CompanySignIn()));
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? "User"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.black,
              ),
              accountEmail: Text(user?.email ?? ""),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CompanySignIn()));
              },
              leading: Icon(Icons.tour),
              title: Text(
                'Share your Tours',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => YourTrips()));
              },
                leading: const Icon(Icons.book_online),
                title: Text(
                  'Your Bookings',
                  style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
                )),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendationScreen()));
              },
              leading: const Icon(Icons.recommend_rounded),
              title: Text(
                'Want Recommendations',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'Account Settings',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'Logout',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              ),
              onTap: () {
                auth.signOut();
                Navigator.of(context).pushNamed('SignInScreen');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(
                'About Us',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              ),
              onTap: () {},
            ),
          ],
        ));
  }
}
