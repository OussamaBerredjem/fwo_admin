import 'package:flutter/material.dart';
import 'package:fwo_admin/src/core/helper/functions.dart';
import 'package:fwo_admin/src/presentation/views/screens/home/home_body.dart';
import 'package:fwo_admin/src/presentation/views/screens/home/profile_body.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          index == 0 ? 'صفحة الرئيسية'.tr : 'الحساب'.tr,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
          ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: index == 0 ? const HomeBody() : const ProfileBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items:  [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'صفحة الرئيسية'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'الحساب'.tr,
          ),
        ],
      ),
    );
  }
}