// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unnecessary_import

import 'package:firebase_chat/pages/welcome/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:firebase_chat/pages/welcome/intro_screens/intro_page_1.dart';
import 'package:firebase_chat/pages/welcome/intro_screens/intro_page_2.dart';
import 'package:firebase_chat/pages/welcome/intro_screens/intro_page_3.dart';


class WelcomePage extends GetView<WelcomeController> {
  WelcomePage({Key? key}) : super(key: key);
  //

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: [
          IntroPage1(),
          IntroPage2(),
          IntroPage3(),
        ],
        onPageChangeCallback: (page) {
          controller.changePage(page);
        },
        waveType: WaveType.liquidReveal,
        slideIconWidget: const Icon(Icons.arrow_back_ios), // Add a back icon
        enableLoop: false, // Disable loop for preventing going to the previous page
      ),

    );
  }
}