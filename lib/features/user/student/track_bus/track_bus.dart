import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';

class TrackBus extends StatelessWidget {
  const TrackBus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Bus'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Search for Bus',
                    filled: true,
                    fillColor: SchoolDynamicColors.backgroundColorTintLightGrey,
                    suffixIcon: Icon(Icons.search_rounded)),
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Buses',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
                ),
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolBusContainer(
                busNo: 'B123',
                driverName: 'John Doe',
                driverContact: '123-456-7890',
                route: 'Route A',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SchoolBusContainer extends StatelessWidget {
  final String busNo;
  final String driverName;
  final String driverContact;
  final String route;

  SchoolBusContainer({
    required this.busNo,
    required this.driverName,
    required this.driverContact,
    required this.route,
  });

  Widget buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(
            icon,
            color: color,
            size: 16,
          ),
        ),
        SizedBox(width: SchoolSizes.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label',
              style: TextStyle(fontSize: 12,
                  color: SchoolDynamicColors.subtitleTextColor, fontWeight: FontWeight.w500),
            ),
            Text(
              value,
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SchoolSizes.md),
      decoration: BoxDecoration(
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        border: Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SchoolSizes.cardRadiusXs),
                        color: SchoolDynamicColors.backgroundColorTintLightGrey,
                      ),
                      child: Icon(Icons.directions_bus,
                          size: 20, color: SchoolDynamicColors.primaryIconColor),
                    ),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    Text(
                      'Vehicle No - ',
                      style: Theme.of(Get.context!).textTheme.titleMedium,
                    ),
                    Text(
                      busNo,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: SchoolDynamicColors.activeBlue),
                    ),
                  ],
                ),
                // SizedBox(height: SchoolSizes.sm),

                Divider(
                  thickness: 1,
                  color: SchoolDynamicColors.borderColor,
                ),
                SizedBox(height: SchoolSizes.md),
                buildInfoRow(Icons.person, 'Driver', driverName,SchoolDynamicColors.activeGreen),
                SizedBox(height: SchoolSizes.md),
                buildInfoRow(Icons.call_rounded, 'Contact', driverContact,SchoolDynamicColors.activeRed),
                SizedBox(height: SchoolSizes.md),
                buildInfoRow(Icons.location_on, 'Route', route,SchoolDynamicColors.activeOrange,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
