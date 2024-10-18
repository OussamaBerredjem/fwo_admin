import 'package:flutter/material.dart';
import 'package:fwo_admin/src/presentation/views/screens/home/home_screen.dart';
import 'package:fwo_admin/src/presentation/views/screens/auth/login_screen.dart';
import 'package:fwo_admin/src/presentation/views/screens/auth/splash_screen.dart';
import 'package:fwo_admin/src/presentation/views/screens/services/addadmin_screen.dart';
import 'package:fwo_admin/src/presentation/views/screens/services/companies_screen.dart';
import 'package:fwo_admin/src/presentation/views/screens/services/orders_screen.dart';
import 'package:fwo_admin/src/presentation/views/screens/services/renewal_screen.dart';
import 'package:fwo_admin/src/presentation/views/screens/services/suggestions_screen.dart';
import 'package:fwo_admin/src/presentation/views/screens/services/users_screen.dart';
import 'package:get/get.dart';

import 'config/theme_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'fwo admin',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      locale:  Locale('en', 'US'),
      textDirection: TextDirection.rtl,
      theme: lightTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/orders', page: () => const OrdersScreen()),
        GetPage(name: '/companies', page: () => const CompaniesScreen()),
        GetPage(name: '/renewal', page: () => const RenewalScreen()),
        GetPage(name: '/users', page: () => const UsersScreen()),
        GetPage(name: '/suggestions', page: () => const SuggestionsScreen()),
        GetPage(name: '/addadmin', page: () => const AddAdminScreen()),
        // GetPage(name: '/profile', page: () => const ProfilePage()),
        // GetPage(name: '/suggestionsAndComplaintsScreen', page: () => const SuggestionsAndComplaintsScreen()),
      ],
    );
  }
}