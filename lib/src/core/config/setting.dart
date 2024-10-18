import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fwo_admin/src/presentation/controllers/auth_controller.dart';
import 'package:fwo_admin/src/presentation/models/user_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../helper/utlis.dart';
import 'firebase_options.dart';

Future<void> initSettings() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  userBox = await Hive.openBox<UserModel>('user');
  settingBox = await Hive.openBox('setting');
  Get.put(AuthController());
}
