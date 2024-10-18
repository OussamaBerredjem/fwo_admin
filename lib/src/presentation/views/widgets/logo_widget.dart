import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Image.asset('assets/images/logo.png',
            width: screenWidth * 0.8, height: screenWidth * 0.8),
      ),
    );
  }
}