import 'package:flutter/material.dart';
import 'package:fwo_admin/src/core/helper/functions.dart';

import '../../widgets/loading_widget.dart';
import '../../widgets/logo_widget.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
      Future.delayed(const Duration(seconds: 2), () {
        initializeScreen();
      });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.8,
            width: screenWidth,
            child: const LogoWidget(),
          ),
          SizedBox(
            height: screenHeight * 0.2,
            width: screenWidth,
            child: const LoadingWidget(),
          ),
        ],
      ),
    );
  }
}