import 'package:flutter/material.dart';
import 'package:fwo_admin/src/apis/api.dart';
import 'package:get/get.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاقتراحات و الشكاوي'.tr,
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
        stream: Api.instance.suggestionsStream(),
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
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('لا توجد اقتراحات حتى الآن'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (context) => Container(
                            // height: 300,
                            width: double.infinity,
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                Get.back();
                                Get.dialog(
                                  Center(child: CircularProgressIndicator()),
                                );
                                await Api.instance
                                    .deleteSuggestion(
                                  snapshot.data![index]['id'],
                                )
                                    .then((value) {
                                  Get.back();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                              ),
                              child: Text('تم قرائة الاقتراح و الشكوى'.tr),
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
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نص الاقتراح او شكوى : ',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          '\"${snapshot.data![index]['data']['text']}\"',
                          maxLines: null,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                        Text(
                          'تاريخ الاقتراح : ',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          snapshot.data![index]['data']['date']
                              .toString()
                              .substring(0, 16),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
