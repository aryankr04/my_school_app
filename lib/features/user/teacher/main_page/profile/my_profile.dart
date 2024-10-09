import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/color_chips.dart';
import 'package:my_school_app/common/widgets/expansion.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<String> interestsAndHobbies = [
    'Reading',
    'Traveling',
    'Photography',
    'Cooking',
    'Gardening',
    'Painting',
    'Playing an instrument',
    'Hiking',
    'Blogging',
    'Yoga',
  ];

  List<Color> chipColors = [
    SchoolDynamicColors.activeBlue,
    SchoolDynamicColors.colorPurple,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];
  bool isPrivate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leadingWidth: 70,
        leading: IconButton(
          icon: Icon(
            Icons.menu_rounded,
          ),
          onPressed: () {},
        ),
      ),
      // backgroundColor: SchoolHelperFunctions.isDarkMode(context)
      //     ? SchoolColors.black
      //     : SchoolColors.softGrey,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            children: [
              // SafeArea(
              //   child: Row(mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Profile',style: Theme.of(context).textTheme.headlineSmall,)
              //     ],
              //   ),
              // ),
              //SizedBox(height: SchoolSizes.lg,),
              Container(
                // padding: const EdgeInsets.symmetric(
                //     vertical: SchoolSizes.md, horizontal: SchoolSizes.md),
                // decoration: BoxDecoration(
                //   // boxShadow: [
                //   //   BoxShadow(
                //   //     color: Colors.black.withOpacity(0.1),
                //   //     spreadRadius: 1,
                //   //     blurRadius: 3,
                //   //     offset: const Offset(0, 3),
                //   //   ),
                //   // ],
                //   color: SchoolColors.containerColorWDG,
                //   borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
                //   border:
                //       Border.all(width: .5, color: SchoolColors.borderColor),
                // ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.1), // Shadow color
                                spreadRadius: 2, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset: Offset(0, 3), // Offset
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 36,
                            backgroundColor: SchoolDynamicColors.primaryTintColor,
                            //backgroundImage: AssetImage('assets/your_image_name.png'),
                          ),
                        ),
                        SizedBox(
                          width: SchoolSizes.lg,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Aryan Kumar',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: SchoolDynamicColors.headlineTextColor,
                                              fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'aryankr_04',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Dumraon, Buxar',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(height: SchoolSizes.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '984',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Likes',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Container(
                            width: 1,
                            height: 24,
                            color: SchoolDynamicColors.borderColor),
                        Column(
                          children: [
                            Text(
                              '986',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Container(
                            width: 1,
                            height: 24,
                            color: SchoolDynamicColors.borderColor),
                        Column(
                          children: [
                            Text(
                              '856M',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Container(
                            width: 1,
                            height: 24,
                            color: SchoolDynamicColors.borderColor),
                        Column(
                          children: [
                            Text(
                              '54',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: SchoolSizes.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        isPrivate
                            ? SizedBox()
                            : Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    constraints: BoxConstraints(minWidth: 150),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: SchoolSizes.sm + 4,
                                        horizontal: SchoolSizes.md),
                                    decoration: BoxDecoration(
                                      color: SchoolHelperFunctions.isDarkMode(
                                              Get.context!)
                                          ? SchoolDynamicColors.activeBlue
                                              .withOpacity(0.8)
                                          : SchoolDynamicColors.activeBlue,
                                      borderRadius: BorderRadius.circular(
                                          SchoolSizes.cardRadiusSm),
                                    ),
                                    child: Text(
                                      "Follow",
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                        isPrivate
                            ? SizedBox()
                            : SizedBox(
                                width: 24,
                              ),
                        Expanded(
                          child: GestureDetector(
                            onTap: null,
                            child: Container(
                              constraints: BoxConstraints(minWidth: 150),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: SchoolSizes.sm + 4,
                                  horizontal: SchoolSizes.md),
                              decoration: BoxDecoration(
                                color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                                borderRadius: BorderRadius.circular(
                                    SchoolSizes.cardRadiusSm),
                                border: Border.all(
                                    width: 1, color: SchoolDynamicColors.activeBlue),
                              ),
                              child: Text(
                                "Message",
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: SchoolDynamicColors.activeBlue),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SchoolSizes.md,
              ),
              Divider(thickness: 0.5,color: SchoolDynamicColors.borderColor,),
              SizedBox(
                height: SchoolSizes.md,
              ),
              Container(
                // padding: const EdgeInsets.all(SchoolSizes.md),
                // decoration: BoxDecoration(
                //   color: SchoolColors.containerColorWDG,
                //   borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
                //   border:
                //       Border.all(width: .5, color: SchoolColors.borderColor),
                // ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Academics Details",
                            style: Theme.of(Get.context!)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                        InkWell(
                            child: Row(
                          children: [
                            Text(
                              'More Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: SchoolDynamicColors.activeBlue),
                            ),
                            SizedBox(
                              width: SchoolSizes.xs,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: SchoolDynamicColors.activeBlue,
                              size: 12,
                            )
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: SchoolSizes.md,
                    ),
                    buildInfoRow(SchoolDynamicColors.activeGreen, Icons.home_filled,
                        'School', 'Cambridge School Dumraon'),
                    SizedBox(
                      height: SchoolSizes.lg,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildInfoColumn(SchoolDynamicColors.activeOrange,
                            Icons.home_filled, 'Class', '8th'),
                        buildInfoColumn(SchoolDynamicColors.activeBlue, Icons.grid_3x3,
                            'Sec', 'C'),
                        buildInfoColumn(SchoolDynamicColors.activeRed, Icons.class_,
                            'Roll No', '44'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SchoolSizes.md,
              ),
              Divider(thickness: 0.5,color: SchoolDynamicColors.borderColor,),
              SizedBox(
                height: SchoolSizes.md,
              ),
              Container(
                // padding: const EdgeInsets.only(
                //     left: SchoolSizes.md,
                //     right: SchoolSizes.md,
                //     top: SchoolSizes.md,
                //     bottom: SchoolSizes.sm),
                // decoration: BoxDecoration(
                //   color: SchoolColors.containerColorWDG,
                //   borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
                //   border:
                //       Border.all(width: .5, color: SchoolColors.borderColor),
                // ),
                child: SchoolExpansionTile(
                  initiallyExpanded: true,
                  title: Text(
                    "Interests & Hobbies",
                    style: Theme.of(Get.context!)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  children: [
                    SizedBox(
                      height: SchoolSizes.sm,
                    ),
                    Wrap(
                      spacing: 12.0, // Spacing between chips
                      runSpacing: 12.0, // Spacing between lines of chips
                      children:
                          List.generate(interestsAndHobbies.length, (index) {
                        return ColorChips(
                          text: interestsAndHobbies[index],
                          color: chipColors[index %
                              chipColors
                                  .length], // Wrap around colors if needed
                        );
                      }),
                    ),
                    SizedBox(
                      height: SchoolSizes.sm,
                    )
                  ],
                ),
              ),

              SizedBox(
                height: SchoolSizes.md,
              ),
              Divider(thickness: 0.5,color: SchoolDynamicColors.borderColor,),
              SizedBox(
                height: SchoolSizes.md,
              ),
              Container(
                // padding: const EdgeInsets.only(
                //     left: SchoolSizes.md,
                //     right: SchoolSizes.md,
                //     top: SchoolSizes.md,
                //     bottom: SchoolSizes.sm),
                // decoration: BoxDecoration(
                //   color: SchoolColors.containerColorWDG,
                //   borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
                //   border:
                //       Border.all(width: .5, color: SchoolColors.borderColor),
                // ),
                child: SchoolExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      "About me",
                      style: Theme.of(Get.context!)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Aryan Kumar, a diligent computer science student, embarks on a journey fueled by curiosity and determination to unravel the mysteries of the digital world",
                          style: Theme.of(Get.context!)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: SchoolDynamicColors.subtitleTextColor,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: SchoolSizes.sm,
                      )
                    ]),
              ),

              SizedBox(
                height: SchoolSizes.lg,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(
    Color? color,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: color?.withOpacity(0.1),
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
              style: TextStyle(
                  fontSize: 12,
                  color: SchoolDynamicColors.subtitleTextColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 250,
              child: Text(
                value,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildInfoColumn(
    Color? color,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: color?.withOpacity(0.1),
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
              style: TextStyle(
                  fontSize: 12,
                  color: SchoolDynamicColors.subtitleTextColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              child: Text(
                value,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ],
    );
  }
}
