import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/MainPanel/Drawer.dart';
import 'package:tourify/adventure_categories.dart';
import 'package:tourify/notifications_services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NotificationServices notificationServices = NotificationServices();

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessages(context);
    //notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      print('Device Token');
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Tourify"),
        centerTitle: true,
        backgroundColor: const Color(0xff1034A6),
      ),
      drawer: MainPanelDrawer(),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                top: MediaQuery.of(context).size.height * 0.25,
                child: Text(
                  "Your Ultimate Guide...",
                  style: GoogleFonts.abel(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1034A6)),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.32,
                child: Text(
                  "Let's Explore The World",
                  style: GoogleFonts.abel(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.37,
                child: Text(
                  "With",
                  style: GoogleFonts.abel(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.42,
                child: Text(
                  "Tourify",
                  style: GoogleFonts.abel(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1034A6)),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    backgroundColor: Color(0xff1034A6),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdventureCategory()));
                  },
                  child: Text("Let's Begin",
                      style: GoogleFonts.abel(
                          fontSize: 22,
                          fontWeight: FontWeight.bold) //TextStyle
                  )),)
            ],
          ),
          const SizedBox(
            height: 200,
          ),
        ]),
      ),
    );
  }
}
