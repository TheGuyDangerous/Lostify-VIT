import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  _IntroPage2State createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2>
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
        backgroundColor: Color.fromARGB(255, 226, 203, 55),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 70.0),
                SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    'https://doodleipsum.com/700/avatar-2?i=d381886b75ae27fa826ebaeb4a6c49cf',
                    // Ensure the image covers the available space
                  ),
                ),
                SizedBox(height: 70.0),
                Center(
                  child: Column(
                    children: [
                      _buildAnimatedText("Post your quest"),
                      _buildAnimatedText("and leave the rest!"),
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
