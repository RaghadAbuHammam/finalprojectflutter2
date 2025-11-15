import 'dart:async';
import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RegisterScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.network('https://lottie.host/b3f0f760-6fe9-4cd3-9486-27ad763e9f01/avpqwf5DTF.json',
                height: screenHeight * 0.4,
                width: screenWidth * 0.8,
              ),
              SizedBox(height: screenHeight * 0.05),
              CircularProgressIndicator(color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
