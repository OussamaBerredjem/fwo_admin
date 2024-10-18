import 'package:flutter/material.dart';
import 'package:fwo_admin/src/presentation/controllers/auth_controller.dart';
import 'package:fwo_admin/src/presentation/views/widgets/button_widget.dart';
import 'package:get/get.dart';

class AddAdminScreen extends StatefulWidget {
  const AddAdminScreen({super.key});

  @override
  State<AddAdminScreen> createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
  AuthController authController = Get.find<AuthController>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;
  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  FocusNode phone = FocusNode();
  FocusNode confirmPassword = FocusNode();
  FocusNode name = FocusNode();
  @override
  void initState() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اضافة ادمن'.tr,
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                'اضافة ادمن'.tr,
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
                      // Text(
                      // 'Name',
                      // style: Theme.of(context).textTheme.bodyLarge,
                      //  ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        focusNode: name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            gapPadding: 10.0,
                          ),
                          labelText: 'ادخل الاسم'.tr,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      TextField(
                        controller: emailController,
                        focusNode: email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            gapPadding: 10.0,
                          ),
                          labelText: 'ادخل البريد الالكتروني'.tr,
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      TextField(
                        controller: phoneController,
                        focusNode: phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            gapPadding: 10.0,
                          ),
                          labelText: 'ادخل رقم الهاتف'.tr,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 8),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      focusNode: password,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 10.0,
                        ),
                        labelText: 'ادخل كلمة المرور'.tr,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      TextField(
                        controller: confirmPasswordController,
                        focusNode: confirmPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            gapPadding: 10.0,
                          ),
                          labelText: 'ادخل تاكيد كلمة المرور'.tr,
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        enableSuggestions: false,
                      ),
                      const SizedBox(height: 8),
                    ]),
              ),
              ButtonWidget(
                labelText: 'اضافة'.tr,
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    Get.showSnackbar(
                      GetSnackBar(
                        message: 'كلمة المرور غير متطابقة'.tr,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  if (emailController.text.isEmpty ||
                      nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    Get.showSnackbar(
                      GetSnackBar(
                        message: 'الرجاء تعبئة جميع الحقول'.tr,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  if (passwordController.text.length < 6) {
                    Get.showSnackbar(
                      GetSnackBar(
                        message: 'كلمة المرور يجب الا تقل عن 6 حروف'.tr,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  await authController.register(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    password: passwordController.text,
                    type: 'admin',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
