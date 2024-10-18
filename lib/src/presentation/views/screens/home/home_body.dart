import 'package:flutter/material.dart';
import 'package:fwo_admin/src/core/helper/functions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      children: [
        HomeItemWidget(
          text: 'الطلبات'.tr,
          icon: Icons.list,
          onPressed: () async {
            Get.dialog(Center(child: CircularProgressIndicator()));
            await requestPermissions();
            Position position = await determinePosition();
            Get.back();
            Get.toNamed('/orders', arguments: position);
          },
        ),
        HomeItemWidget(
          text: 'الشركات الجديدة'.tr,
          icon: Icons.business,
          onPressed: () {
            Get.toNamed('/companies');
          },
        ),
        HomeItemWidget(
          text: 'طلبات تجديد العقد'.tr,
          icon: Icons.recycling,
          onPressed: () {
            Get.toNamed('/renewal');
          },
        ),
        HomeItemWidget(
          text: 'المستخدمين'.tr,
          icon: Icons.supervised_user_circle,
          onPressed: () {
            Get.toNamed('/users');
          },
        ),
        HomeItemWidget(
          text: 'الاقتراحات و الشكاوي'.tr,
          icon: Icons.question_mark,
          onPressed: () {
            Get.toNamed('/suggestions');
          },
        ),
        HomeItemWidget(
          text: 'اضافة حساب ادمن'.tr,
          icon: Icons.add,
          onPressed: () {
            Get.toNamed('/addadmin');
          },
        ),
      ],
    );
  }
}

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
              strokeAlign: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Spacer(),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    // color: Theme.of(context).colorScheme.,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
