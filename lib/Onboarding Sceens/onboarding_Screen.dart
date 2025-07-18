import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tourify/Onboarding%20Sceens/Pages/page_one.dart';
import 'package:tourify/Onboarding%20Sceens/Pages/page_two.dart';

import 'Pages/page_three.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final page_Controller = PageController(initialPage: 0);
  bool lastpage = false;

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      PageView(
          onPageChanged: (value) {
            setState(() {
              if (value == 2) {
                lastpage = true;
              } else {
                lastpage = false;
              }
            });
          },
          controller: page_Controller,
          children: const [PageOne(), Pagetwo(), Pagethree()]),
      Container(
          alignment: const Alignment(0, 0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    page_Controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: const Text("Back")),
              SmoothPageIndicator(
                controller: page_Controller,
                count: 3,
                effect: const WormEffect(dotColor: Color(0xff1034A6)),
              ),

              //HERE A VERY IMPORTANT LOGIC IS IMPLEMENTED WHERE WE CHECK IF THE PAGE IS LAST OR NOT AND IF IT IS LAST THEN WE WILL NOT SHOW THE NEXT BUTTON
              lastpage == false
                  ? TextButton(
                      onPressed: () {
                        page_Controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: const Text("Next"))
                  //EMPTY BUTTON IS USED TO MAINTAIN THE ALIGNMENT OF THE NEXT BUTTON
                  : TextButton(
                      onPressed: () {},
                      child: const Text(" "),
                    )
            ],
          ))
    ]));
  }
}
