import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  _IntroPage1State createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1>
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
        backgroundColor: Color(0xffE23744),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 70.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: SizedBox(
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        'https://doodleipsum.com/700/flat?i=366f07b78c8218519c32858e70d7e35d',
                        // Ensure the image covers the available space
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Center(
                  child: Column(
                    children: [
                      _buildAnimatedText("Lost something?"),
                      _buildAnimatedText("We'll find it together."),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ],
        ));
  }
}
