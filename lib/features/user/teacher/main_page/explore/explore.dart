import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/color_chips.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import 'package:photo_view/photo_view.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.close_rounded,
          color: SchoolDynamicColors.iconColor,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_rounded,
        color: SchoolDynamicColors.iconColor,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search Results for: $query'),
    );
  }

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
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  @override
  Widget buildSuggestions(BuildContext context) {
    return FadeTransition(
      opacity: transitionAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: SchoolSizes.md, vertical: SchoolSizes.lg),
        child: Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: List.generate(interestsAndHobbies.length, (index) {
            return ColorChips(
              text: interestsAndHobbies[index],
              color: chipColors[index % chipColors.length],
              textSize: 13,
            );
          }),
        ),
      ),
    );
  }
}

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with TickerProviderStateMixin {
  String comment =
      'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SchoolHelperFunctions.isDarkMode(context)?SchoolDynamicColors.darkerGreyBackgroundColor:SchoolDynamicColors.lightGrey,
      appBar: AppBar(
        leadingWidth: 70,
        leading: IconButton(icon: Icon(Icons.menu_rounded,),onPressed: (){},),
        title: Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.favorite_border_rounded,
              ),
              onPressed: () {}),
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SchoolSizes.sm,vertical: SchoolSizes.sm),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(SchoolSizes.sm),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: SchoolDynamicColors.activeBlue,
                                  radius: 37,
                                  child: CircleAvatar(
                                    radius: 34,
                                    backgroundColor:
                                        SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                                    child: CircleAvatar(
                                      backgroundColor: SchoolDynamicColors.activeGreen,
                                      radius: 31,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor:
                                        SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: SchoolDynamicColors.activeBlue,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SchoolSizes.sm,
                            ),
                            Text(
                              'Your Story',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const StatusCircleAvatar(),
                      const StatusCircleAvatar(),
                      const StatusCircleAvatar(),
                      const StatusCircleAvatar(),
                      const StatusCircleAvatar(),
                      const StatusCircleAvatar(),
                      const StatusCircleAvatar(),
                    ],
                  ),
                )),
            PostWidget(comment: comment),
            PostWidget(comment: comment),
            PostWidget(comment: comment),
          ],
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final String comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SchoolSizes.md),
      decoration:  BoxDecoration(
        color: SchoolDynamicColors.backgroundColorWhiteLightGrey,
          //border: Border.all(color: SchoolColors.borderColor, width: 0.5),
          borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),

        boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
           ],
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          MyCarousel(),
          _buildReactions(),
          _buildCaption(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SchoolSizes.sm + 4,
        vertical: SchoolSizes.sm + 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildUserInfo(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
         CircleAvatar(
          backgroundColor: SchoolDynamicColors.activeBlue,
          radius: 20,
          backgroundImage: AssetImage('assets/logos/csd.png'),
        ),
        const SizedBox(width: SchoolSizes.sm + 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'aryankr_04',
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(height: 1, fontSize: 15),
            ),
            Text(
              'Aryan Kumar',
              style: Theme.of(Get.context!)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w400, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildFollowButton(),
        const SizedBox(width: SchoolSizes.md),
        Icon(Icons.more_vert_rounded, color: SchoolDynamicColors.iconColor),
      ],
    );
  }

  Widget _buildFollowButton() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: SchoolSizes.lg, vertical: SchoolSizes.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SchoolSizes.sm),
        color: SchoolDynamicColors.activeBlue,
      ),
      child: Text(
        'Follow',
        style: Theme.of(Get.context!)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget _buildReactions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SchoolSizes.md, vertical: SchoolSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildReaction(Icons.favorite_border_rounded, '365K', 26),
          _buildReaction(Icons.mode_comment_outlined, '365K', 26),
          _buildReaction(Icons.share, '365K', 22),
          Icon(Icons.bookmark_outline_rounded,
              size: 28, color: SchoolDynamicColors.iconColor),
        ],
      ),
    );
  }

  Widget _buildReaction(IconData icon, String count, double iconSize) {
    return Row(
      children: [
        Icon(icon, size: iconSize, color: SchoolDynamicColors.iconColor),
        const SizedBox(width: SchoolSizes.sm),
        Text(count, style: Theme.of(Get.context!).textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SchoolSizes.md,),
      child: Column(
        children: [
          ReadMoreText(
            'aryankr_04 - $comment',
            trimLines: 2,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'More',
            trimExpandedText: 'Less',
            moreStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            lessStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: SchoolSizes.md,)
        ],
      ),
    );
  }
}

class StatusCircleAvatar extends StatelessWidget {
  const StatusCircleAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SchoolSizes.sm),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: SchoolDynamicColors.activeBlue,
            radius: 37,
            child: CircleAvatar(
              radius: 34,
              backgroundColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
              child: CircleAvatar(
                backgroundColor: SchoolDynamicColors.activeOrange,
                radius: 31,
              ),
            ),
          ),
          const SizedBox(
            height: SchoolSizes.sm,
          ),
          Text(
            'Your Story',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

class MyCarousel extends StatefulWidget {
  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController(); // No need for alias


  List<Map<String, dynamic>> mediaItems = [
    {
      'type': 'image',
      'url': 'https://loremflickr.com/320/240', // Placeholder image 2
    },
    {
      'type': 'image',
      'url': 'https://picsum.photos/400/300', // Placeholder image 3
    },
    {
      'type': 'image',
      'url': 'https://picsum.photos/300/400', // Placeholder image 4
    },
    {
      'type': 'image',
      'url': 'https://picsum.photos/250/350', // Placeholder image 5
    },
    {
      'type': 'image',
      'url': 'https://picsum.photos/500/250', // Placeholder image 6
    },
    {
      'type': 'image',
      'url': 'https://picsum.photos/500/400', // Placeholder image 7
    },
    {
      'type': 'image',
      'url': 'https://picsum.photos/500/300', // Placeholder image 8
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(

            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            viewportFraction: 1,

            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: mediaItems.map((item) {
            return Builder(
              builder: (BuildContext context) {
                late Widget carouselItem; // Declare as late and initialize inside the if-else blocks
                if (item['type'] == 'image') {
                  carouselItem = PhotoView(
                    imageProvider: NetworkImage(item['url']),
                    //tightMode: true,
                    //customSize: Size(double.maxFinite, double.minPositive),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained * 1,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    loadingBuilder: (context, event) {
                      if (event == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      double progress = event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 100);
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.isNaN ? null : progress,
                        ),
                      );
                    },
                    backgroundDecoration: const BoxDecoration(
                      color: SchoolDynamicColors.black,
                    ),
                  );
                } else if (item['type'] == 'video') {
                  carouselItem = Container(
                    child: VideoPlayerWidget(videoUrl: item['url']),
                  );
                }
                return carouselItem; // Return carouselItem
              },
            );
          }).toList(),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: mediaItems.map((item) {
              int index = mediaItems.indexOf(item);
              return Container(
                width: _current == index ? 7 : 6,
                height: _current == index ? 7 : 6,
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Colors.blue
                      : Colors.grey.withOpacity(0.5),
                  boxShadow: _current == index
                      ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ]
                      : null,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      })
      ..setLooping(true)
      ..addListener(() {
        if (!_controller.value.isPlaying &&
            _controller.value.isInitialized &&
            (_controller.value.duration == _controller.value.position)) {
          // Video reached the end, rewind to the beginning
          _controller.seekTo(Duration.zero);
        }
      })
      ..play();

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  void _toggleVideoPlayback() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.play();
      } else {
        _controller.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleVideoPlayback,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
                  if (!_isPlaying) // Show play button if video is paused
                    const Icon(Icons.play_arrow, size: 50),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
