import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fwo_admin/src/apis/api.dart';
import 'package:fwo_admin/src/core/helper/functions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Position position = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الطلبات'.tr,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder(
        stream: Api.instance.ordersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print('**********Error:  ${snapshot.error}');
            return const Center(
              child: Text('حدث خطأ ما'),
            );
          }
          print(snapshot.data);

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('لا توجد طلبات حتى الآن'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              String type = snapshot.data!.docs[index].data()['type'] ?? 'none';
              type = _type(type);
              return MyWidget(
                  snapshot: snapshot.data!.docs[index],
                  type: type,
                  position: position);
            },
          );
        },
      ),
    );
  }

  String _type(String type) {
    switch (type) {
      case 'person':
        return 'مجمع زيوت';
      case 'company':
        return 'شركة';
      case 'station':
        return 'محطة';
      case 'none':
        return 'بلا حساب';
      default:
        return 'بلا حساب';
    }
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget(
      {super.key,
      required this.snapshot,
      required this.type,
      required this.position});
  final QueryDocumentSnapshot snapshot;
  final String type;
  final Position position;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double distance = 0;
  @override
  void initState() {
    distance = Geolocator.distanceBetween(
          widget.position.latitude,
          widget.position.longitude,
          widget.snapshot['lat'],
          widget.snapshot['long'],
        ) /
        1000;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // DirectCaller().makePhoneCall(snapshot.data!.docs[index]['phone']);
        showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (context) => Container(
                  // height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () async {
                          Get.back();
                          openMapsSheet(context, widget.snapshot['lat'],
                              widget.snapshot['long']);
                        },
                        radius: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              Text(
                                'الاتجاه نحو الوقع'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${distance.toStringAsFixed(2)} كم',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              Get.back();
                              await Api.instance
                                  .updateOrderStatus(
                                widget.snapshot.id,
                                'done',
                              )
                                  .then((value) {
                                Get.back();
                                Get.showSnackbar(
                                  GetSnackBar(
                                    message: 'تم معالجة الطلب'.tr,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            ),
                            child: Text('تم معالجة الطلب'.tr),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Get.back();
                              await Api.instance
                                  .updateOrderStatus(
                                widget.snapshot.id,
                                'rejected',
                              )
                                  .then((value) {
                                Get.back();
                                Get.showSnackbar(
                                  GetSnackBar(
                                    message: 'تم رفض الطلب'.tr,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            ),
                            child: Text('رفض الطلب'.tr),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 16,
          right: 16,
          left: 16,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
              strokeAlign: 1,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.person,
              size: 50,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('اسم العميل: '.tr),
                    Text(widget.snapshot['fullName']),
                  ],
                ),
                Row(
                  children: [
                    Text('رقم الهاتف: '.tr),
                    Text(widget.snapshot['phone']),
                  ],
                ),
                Row(
                  children: [
                    Text('الكمية: '.tr),
                    Text(widget.snapshot['quantity']),
                  ],
                ),
                Row(
                  children: [
                    Text('تاريخ الطلب: '.tr),
                    Text((widget.snapshot['date'] as Timestamp)
                        .toDate()
                        .toString()
                        .split(' ')[0]),
                  ],
                ),
                Row(
                  children: [
                    Text('نوع الحساب: '.tr),
                    Text(
                      widget.type,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text('${distance.toStringAsFixed(2)} كم'.tr,
                style: Get.textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
