import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fwo_admin/src/apis/api.dart';
import 'package:fwo_admin/src/core/helper/handleFirebaseExeption/firebase_exception_functions.dart';
import 'package:fwo_admin/src/core/helper/utlis.dart';
import 'package:fwo_admin/src/presentation/models/user_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final Api _api = Api.instance;
  XFile? copyOfTheCommercialRegister;
  XFile? copyOfTheTaxIDCard;
  XFile? copyOfTheContractorsIDcard;
  Future<void> login({
    required String email,
    required String password,
  }) async {
    var errorCode = await handleFirebaseError(() async {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
      );
      UserCredential userCredential = await _api.signIn(email, password);
      if (userCredential.user != null) {
        final userData =
            await _api.getUserFromFirestore(userCredential.user!.uid);
        UserModel userModel =
            UserModel.fromMap(userData.data() as Map<String, dynamic>);
        await userBox.put('user', userModel);
        Get.back();
        Get.offAllNamed('/');
      } else {
        Get.back();
        Get.showSnackbar(
          GetSnackBar(
            message: 'البريد الالكتروني او كلمة المرور غير صحيح'.tr,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
    if (errorCode != null) {
      _api.signOut();
      String errorMessage = getFirebaseErrorMessage(errorCode);
      print('error message: $errorMessage');
      Get.back();
      Get.showSnackbar(
        GetSnackBar(
          message: 'حدث خطأ ما'.tr,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  register({
    required String name,
    required String email,
    required String phone,
    required String type,
    required String password,
  }) async {
    var errorCode = await handleFirebaseError(() async {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
      );
      UserCredential userCredential = await _api.signUp(email, password);
      if (userCredential.user != null) {
        Map<String, dynamic> data = {
          'uId': userCredential.user!.uid,
          'name': name,
          'email': email,
          'phone': phone,
          'type': type,
        };

        await _api.addUserToFirestore(data);
        Get.back();
        Get.offAllNamed('/home');
       Get.showSnackbar(
         GetSnackBar(
           message: 'تم التسجيل بنجاح'.tr,
           duration: const Duration(seconds: 3),
         ),
       );
      }
    });
    if (errorCode != null) {
      _api.signOut();
      String errorMessage = getFirebaseErrorMessage(errorCode);
      print('error message: $errorMessage');
      Get.back();
      Get.showSnackbar(
        GetSnackBar(
          message: 'حدث خطأ ما'.tr,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  signOut() async {
    var errorCode = await handleFirebaseError(() async {
      await _api.signOut();
      await userBox.delete('user');
      Get.offAllNamed('/');
    });
    if (errorCode != null) {
      String errorMessage = getFirebaseErrorMessage(errorCode);
      print('error message: $errorMessage');
      Get.showSnackbar(
        GetSnackBar(
          message: 'حدث خطأ ما'.tr,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  resetPassword({required String email}) async {
    var errorCode = await handleFirebaseError(() async {
      await _api.resetPassword(email);
    });
    if (errorCode != null) {
      String errorMessage = getFirebaseErrorMessage(errorCode);
      print('error message: $errorMessage');
      Get.showSnackbar(
        GetSnackBar(
          message: 'حدث خطأ ما'.tr,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
