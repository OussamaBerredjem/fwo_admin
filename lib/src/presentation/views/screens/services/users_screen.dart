import 'package:flutter/material.dart';
import 'package:fwo_admin/src/apis/api.dart';
import 'package:get/get.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late TextEditingController searchController;
  String userType = 'person';
  String searchType = 'phone';
  bool isSearching = false;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المستخدمين'.tr,
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
      body: Center(
        child: Column(
          children: [
            Text(
              'البحث عن المستخدمين'.tr,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
            ),
            // chose the user type widget with 3 opthions (Admin, Employee, Customer)
            // Admin
            // Employee
            // Customer
            Text(
              'اختر نوع المستخدم'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SegmentedButton<String>(
              segments: [
                ButtonSegment<String>(
                  value: 'person',
                  label: Text('مستخدم'.tr),
                ),
                ButtonSegment<String>(
                  value: 'company',
                  label: Text('شركة'.tr),
                ),
                ButtonSegment<String>(
                  value: 'station',
                  label: Text('محطة'.tr),
                ),
              ],
              selected: {userType},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  userType = newSelection.first;
                  isSearching = false;
                });
                // print(userType);
              },
            ),
            Text(
              'اختر نوع البحث'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SegmentedButton<String>(
              segments: [
                ButtonSegment<String>(
                  value: 'phone',
                  label: Text('الهاتف'.tr),
                ),
                ButtonSegment<String>(
                  value: 'email',
                  label: Text('البريد الالكتروني'.tr),
                ),
              ],
              selected: {searchType},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  searchType = newSelection.first;
                  isSearching = false;
                });
                // print(userType);
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (val){
                  print("trying get it again");
                  if(val.isEmpty){
                    setState(() {
                      isSearching = false;
                    });
                  }
                },
                
                controller: searchController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    gapPadding: 10.0,
                  ),
                  labelText: searchType == 'phone'
                      ? 'ادخل رقم الهاتف'.tr
                      : 'ادخل البريد الالكتروني'.tr,
                ),
              ),
            ),
            !isSearching
                ? FutureBuilder(
                  future: Api.instance.getAllUsers(userType: userType),
                  builder:(context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.data!.isEmpty) {
                        return const Text('لا يوجد نتائج');
                      }
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length + 1,
                            itemBuilder: (context, index) {
                              if (index == snapshot.data!.length) {
                                return const SizedBox(
                                  height: 100,
                                );
                              }
                              return Container(
                                margin: const EdgeInsets.only(
                                  top: 16,
                                  right: 16,
                                  left: 16,
                                ),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2,
                                    )),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data![index]['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      snapshot.data![index]['email'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      snapshot.data![index]['phone'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  )
                : FutureBuilder(
                    future: Api.instance.getUsers(
                      userType: userType,
                      searchType: searchType,
                      searchValue: searchController.text,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.data!.isEmpty) {
                        return const Text('لا يوجد نتائج');
                      }
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length + 1,
                            itemBuilder: (context, index) {
                              if (index == snapshot.data!.length) {
                                return const SizedBox(
                                  height: 100,
                                );
                              }
                              return Container(
                                margin: const EdgeInsets.only(
                                  top: 16,
                                  right: 16,
                                  left: 16,
                                ),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2,
                                    )),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data![index]['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      snapshot.data![index]['email'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      snapshot.data![index]['phone'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        // extendedPadding: const EdgeInsets.all(32.0),
        onPressed: () {
          Get.focusScope!.unfocus();
          if (searchController.text.isEmpty) {
            Get.showSnackbar(
              const GetSnackBar(
                message: 'ادخل بيانات البحث',
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }
          setState(() {
            isSearching = true;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: const Icon(Icons.search, color: Colors.white),
        label: Text(
          'بحث'.tr,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
