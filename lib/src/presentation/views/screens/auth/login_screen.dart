import 'package:flutter/material.dart';
import 'package:fwo_admin/src/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../widgets/button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.find<AuthController>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تسجيل الدخول'.tr,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.surface, size: 30),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                )),
              ),
              Text(
                'سجل الدخول الى حسابك'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  // vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'البريد الالكتروني'.tr,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: emailController,
                        focusNode: email,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            gapPadding: 0.0,
                          ),
                          labelText: 'ادخل البريد الالكتروني'.tr,
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  // vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'كلمة المرور'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      focusNode: password,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 10.0,
                        ),
                        labelText: 'ادخل كلمة المرور'.tr,
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              ButtonWidget(
                labelText: 'تسجيل الدخول'.tr,
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    Get.showSnackbar(
                      GetSnackBar(
                        message: 'الرجاء ادخال البريد الالكتروني وكلمة المرور'.tr,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  authController
                  .login(
                    email: emailController.text, 
                    password: passwordController.text,
                    );
                },
              ),
              TextButton(
                onPressed: () async {
                  if(emailController.text.isEmpty) {
                    Get.showSnackbar(
                      GetSnackBar(
                        message: 'الرجاء ادخال البريد الالكتروني'.tr,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  // authController.resetPassword(
                  //   email: emailController.text,
                  // );
                },
                child: Text('نسيت كلمة المرور؟'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
