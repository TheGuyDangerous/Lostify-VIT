import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_chat/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  _IntroPage3State createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _scaleAnimation =
        Tween<double>(begin: 0.75, end: 1.0).animate(curvedAnimation);
    _opacityAnimation =
        Tween<double>(begin: 0.50, end: 1.0).animate(curvedAnimation);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedText(String text) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Text(
              text,
              style: GoogleFonts.nunito(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                color: Color(0xfffffcfd),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Lottie.network(
                    'https://lottie.host/3a77473f-dab2-40c7-9095-cc0b349d9526/yk2pLzHXfr.json',
                  ),
                ),
              ),
              SizedBox(height: 70.0),
              Center(
                child: Column(
                  children: [
                    _buildAnimatedText("Chat with your friends"),
                    _buildAnimatedText("on the go!"),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 0,
            child: ElevatedButton(
              onPressed: () {
                Get.find<WelcomeController>().handleSignIn();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  CircleBorder(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_forward,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
