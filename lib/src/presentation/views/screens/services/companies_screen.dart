import 'package:flutter/material.dart';
import 'package:fwo_admin/src/apis/api.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'الشركات الجديدة'.tr,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.surface,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: Api.instance.newCompaniesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        }
        if (snapshot.hasError) {
          return _buildErrorMessage(snapshot.error);
        }
        if (snapshot.data!.isEmpty) {
          return _buildEmptyMessage();
        }
        return _buildListView(snapshot);
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorMessage(Object? error) {
    debugPrint('**********Error:  $error');
    return const Center(
      child: Text('حدث خطأ ما'),
    );
  }

  Widget _buildEmptyMessage() {
    return const Center(
      child: Text('لا توجد شركات جديدة حتى الآن'),
    );
  }

  Widget _buildListView(AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, snapshot.data![index]);
      },
    );
  }

  Widget _buildListItem(BuildContext context, Map<String, dynamic> company) {
    return InkWell(
      onTap: () {
        _showModalBottomSheet(context, company);
      },
      child: _buildListItemContainer(context, company),
    );
  }

  Widget _buildListItemContainer(
      BuildContext context, Map<String, dynamic> company) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: _buildListItemDecoration(context),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 16),
          _buildColumn(company),
        ],
      ),
    );
  }

  BoxDecoration _buildListItemDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
        strokeAlign: 1,
      ),
    );
  }

  Widget _buildIcon() {
    return const Icon(Icons.person, size: 50);
  }

  Widget _buildColumn(Map<String, dynamic> company) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRow('اسم الشركة: ', company['name']),
        _buildRow('رقم الهاتف: ', company['phone']),
        _buildRow('البريد الالكتروني: ', company['email']),
        Text(company['upload']
            ? 'تم رفع ملفات الشركة'.tr
            : 'لم يتم رفع ملفات الشركة'.tr),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return  Row(
        children: [
          Text(label),
          Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(Get.context!).size.width*0.47,
      ),child: Text(value,overflow: TextOverflow.ellipsis,)),
        ],
      );
  }

  void _showModalBottomSheet(
      BuildContext context, Map<String, dynamic> company) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => _buildModalBottomSheet(context, company),
    );
  }

  Widget _buildModalBottomSheet(
      BuildContext context, Map<String, dynamic> company) {
    return Container(
      width: double.infinity,
      height: Get.height * 0.8,
      // margin: const EdgeInsets.all(16),
      // padding:/ const EdgeInsets.all(16),
      decoration: _buildModalBottomSheetDecoration(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildListItemContainer(context, company),
            const SizedBox(height: 16),
            Text(company['upload']
                ? 'تم رفع ملفات الشركة'.tr
                : 'لم يتم رفع ملفات الشركة'.tr),
            const SizedBox(height: 16),
            if (company['upload'])
              ...List.generate(
                3,
                (index) => InkWell(
                  onTap: () async {
                    await _launchUrl(
                      index == 0
                          ? company['copyOfTheCommercialRegister']
                          : index == 1
                              ? company['copyOfTheContractorsIDcard']
                              : company['copyOfTheTaxIDCard'],
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                          strokeAlign: 1,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            index == 0
                                ? company['copyOfTheCommercialRegister']
                                : index == 1
                                    ? company['copyOfTheContractorsIDcard']
                                    : company['copyOfTheTaxIDCard'],
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: () async {
                Get.back();
                Get.dialog(const Center(
                  child: CircularProgressIndicator(),
                ));
                await Api.instance.contractCompany(company['uId']);
                Get.back();
              },
              style: _buildElevatedButtonStyle(context),
              child: Text('تم تجديد العقد'.tr),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildModalBottomSheetDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(8),
    );
  }

  ButtonStyle _buildElevatedButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri link = Uri.parse(url);
    if (!await launchUrl(link)) {
      throw Exception('Could not launch $url');
    }
  }
}
