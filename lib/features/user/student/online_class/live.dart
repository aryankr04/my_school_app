import 'package:flutter/material.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';

import '../../../../common/widgets/option_list0.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/lists.dart';
import '../../../../utils/constants/sizes.dart';

class LiveClasses extends StatefulWidget {
  const LiveClasses({super.key});

  @override
  State<LiveClasses> createState() => _LiveClassesState();
}

class _LiveClassesState extends State<LiveClasses> {
  List<String> subjectList = SchoolLists.subjectList;

  String selectedClass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SchoolSizes.lg),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SchoolSizes.lg,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: SchoolDynamicColors.subtitleTextColor,
                        fontWeight: FontWeight.w400),
                    hintText: 'Search for live & recorded videos',
                    filled: true,
                    fillColor: SchoolDynamicColors.backgroundColorTintLightGrey,
                    suffixIcon: Icon(Icons.search_rounded)),
              ),
              const SizedBox(
                height: SchoolSizes.spaceBtwSections,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Videos',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'Filter ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: SchoolDynamicColors.primaryColor),
                        ),
                        SizedBox(
                          width: SchoolSizes.xs,
                        ),
                        Icon(
                          Icons.filter_list_rounded,
                          color: SchoolDynamicColors.primaryColor,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: SchoolSizes.spaceBtwItems,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  runSpacing: 8.0,
                  spacing: 16.0,
                  children: subjectList.asMap().entries.map((entry) {
                    String day = entry.value;

                    return CardButton(
                      text: day,
                      isSelected: day == selectedClass,
                      onPressed: () {
                        setState(() {
                          selectedClass = day;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              VideoItem(
                title: 'Trigonometry',
                imageAssetPath: '',
                duration: '24:34',
                views: 2546,
                subject: 'Maths',
                chapter: 'Height and Distance',
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              VideoItem(
                title: 'Trigonometry',
                imageAssetPath: '',
                duration: '24:34',
                views: 2546,
                subject: 'Maths',
                chapter: 'Height and Distance',
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              VideoItem(
                title: 'Trigonometry',
                imageAssetPath: '',
                duration: '24:34',
                views: 2546,
                subject: 'Maths',
                chapter: 'Height and Distance',
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              VideoItem(
                title: 'Trigonometry',
                imageAssetPath: '',
                duration: '24:34',
                views: 2546,
                subject: 'Maths',
                chapter: 'Height and Distance',
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              VideoItem(
                title: 'Trigonometry',
                imageAssetPath: '',
                duration: '24:34',
                views: 2546,
                subject: 'Maths',
                chapter: 'Height and Distance',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final String title;
  final String subject;
  final String chapter;
  final String? imageAssetPath;
  final VoidCallback? onPressed;
  final VoidCallback? onDownloadPressed;
  final String? duration;
  final int? views;
  final String? uploadedDate;
  final String? uploadedBy;

  VideoItem({
    required this.title,
    required this.subject,
    required this.chapter,
    this.imageAssetPath,
    this.onPressed,
    this.onDownloadPressed,
    this.duration,
    this.views,
    this.uploadedDate,
    Key? key,
    this.uploadedBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(SchoolSizes.sm),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
          borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(SchoolSizes.borderRadiusMd),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: SchoolDynamicColors.backgroundColorTintLightGrey,
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.borderRadiusMd),
                      image: DecorationImage(
                        image: AssetImage(
                            imageAssetPath ?? 'assets/placeholder_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(SchoolSizes.cardRadiusXs))),
                  margin: const EdgeInsets.all(SchoolSizes.sm),
                  padding: const EdgeInsets.all(SchoolSizes.sm),
                  child: Text(
                    duration ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: SchoolSizes.sm),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: SchoolSizes.sm),
            Text(
              'Chapter: $subject - $chapter',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Uploaded By: $uploadedBy',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye_rounded,
                      size: SchoolSizes.iconMd,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: SchoolSizes.sm),
                    Text(
                      _formatViews(views ?? 0),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.download_rounded,
                        size: SchoolSizes.iconMd,
                        color: Colors.grey,
                      ),
                      onPressed: onDownloadPressed,
                    ),
                    const SizedBox(width: SchoolSizes.sm),
                    const Icon(
                      Icons.access_time,
                      size: SchoolSizes.iconMd,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: SchoolSizes.sm),
                    Text(
                      uploadedDate ?? '1 day ago',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatViews(int views) {
    if (views < 1000) {
      return views.toString();
    } else if (views < 1000000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    } else if (views < 1000000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else {
      return '${(views / 1000000000).toStringAsFixed(1)}B';
    }
  }
}
