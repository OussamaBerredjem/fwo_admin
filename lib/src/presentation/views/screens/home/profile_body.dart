import 'package:flutter/material.dart';
import 'package:fwo_admin/src/core/helper/utlis.dart';
import 'package:fwo_admin/src/presentation/controllers/auth_controller.dart';
import 'package:fwo_admin/src/presentation/models/user_model.dart';
import 'package:fwo_admin/src/presentation/views/widgets/button_widget.dart';
import 'package:get/get.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  AuthController controller = Get.find<AuthController>();
  UserModel? user = userBox.get('user');
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.05),
            Container(
              width: Get.width * 0.5,
              height: Get.width * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 5,
                ),
              ),
              child: Icon(
                Icons.person,
                size: Get.width * 0.4,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              user!.name!,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    // color: Theme.of(context).colorScheme.,
                    fontWeight: FontWeight.bold,
                    // fontStyle: FontStyle.italic,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              user!.email!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    // color: Theme.of(context).colorScheme.,
                    fontWeight: FontWeight.bold,
                    // fontStyle: FontStyle.italic,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              user!.phone!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    // color: Theme.of(context).colorScheme.,
                    fontWeight: FontWeight.bold,
                    // fontStyle: FontStyle.italic,
                  ),
            ),
            const Spacer(),
            const Divider(),
            const SizedBox(height: 16),
            ButtonWidget(
              labelText: 'تسجيل الخروج'.tr,
              onPressed: () {
                controller.signOut();
              },
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      );
  }
}
