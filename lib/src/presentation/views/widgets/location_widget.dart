import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_widget.dart';


class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.8,
      height: screenWidth * 0.7,
      margin: const EdgeInsets.only(
        bottom: 32,
      ),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ]),
      child: Center(
        child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 100,
                  color: Colors.grey,
                ),
                const LoadingWidget(),
                Text(
                  'getting location...'.tr,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
      ),
    );
  }
}
