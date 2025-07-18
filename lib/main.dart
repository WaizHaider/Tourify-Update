import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tourify/Admin%20Panel/admin_panel.dart';
import 'package:tourify/Admin%20Panel/admin_signIn.dart';
import 'package:tourify/Admin%20Panel/approved.dart';
import 'package:tourify/Admin%20Panel/pending_request.dart';
import 'package:tourify/CompanyFlow/Company_Login_Authentication/company_login.dart';
import 'package:tourify/CompanyFlow/CompanyHomeScreen/company_homescreen.dart';
import 'package:tourify/HomeScreen.dart';
import 'package:tourify/MainPanel/MainPanel.dart';
import 'package:tourify/Recommendation/machine-learning.dart';
import 'package:tourify/user_Auth_login_screens/SignIn.dart';
import 'package:tourify/user_Auth_login_screens/SignUp.dart';
import 'package:tourify/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tourify/CompanyFlow/Company_Login_Authentication/registeration.dart';

import 'Admin Panel/admin_registration.dart';
import 'Maps/map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackgroundHandler);
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color(0xff1034A6),

    ),

    initialRoute: '/',

    routes: {
      '/':(context) => const SplashScreen (),
      'HomeScreen':(context) => const HomeScreen (),
      'SignUpScreen':(context) => const SignUpScreen (),
      'SignInScreen':(context) => const SignInScreen (),
      'MainScreen':(context) => const MainScreen (),
      'CompanyRegistration':(context) => const CompanyRegisteration (),
      'CompanySignInScreen':(context) => const CompanySignIn (),
      'CompanyHomeScreen':(context) => const CompanyHomeScreen (),
      '/login':(context)=> const SignInScreen(),
      'AdminHome':(context) =>  const AdminHome (),
      'Pending':(context) =>  Pending (),
      'Approved':(context) => const Approved (),
      'OfflineMaps':(context) => const MapScreen(),
      'AdminRegistration':(context) => const AdminSignInScreen (),
      'AdminSignIn':(context) => const AdminSignInScreen (),

    },
  ));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessageBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
}