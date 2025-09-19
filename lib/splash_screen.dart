import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'main_tab.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();

    // Navigate to HomePage after 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainTab()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          // Spacer to center the logo and title
          Expanded(
            child: Center(
              child: ScaleTransition(
                scale: _animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Add a fun logo or icon for your Sunday School here
                    Image.asset(
                      'assets/splash_logo.png', // Make sure you add this asset in your project
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 20),
                    // Animated Text for the Splash Screen
                    AnimatedTextKit(

                      animatedTexts: [
                        WavyAnimatedText(
                          'Sunday Class',
                          // speed: Duration(milliseconds: 15),
                          textStyle: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Padding for the text at the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
            child: Text(
              'Made by EL♥️',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
    ),
          ),
        ],
      ),
    );
  }
}
