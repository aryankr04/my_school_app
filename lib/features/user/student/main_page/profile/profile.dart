import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/colors.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  late TabController tabController;
  bool isPrivate = false;
  late PageController _pageController;
  int _currentPage = 1;
  late Animation<double> _animation;
  bool isFront = true; // To track which card is shown
  late AnimationController _controller;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.9, // Show part of next/previous card
      initialPage: _currentPage,
    );
    _controller = AnimationController(
      vsync: this, // Use `this` as vsync for multiple controllers
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    tabController.dispose();
    _pageController.dispose();
    _controller.dispose(); // Dispose the animation controller as well
    super.dispose();
  }

  void flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    isFront = !isFront;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_outlined),
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(SchoolSizes.lg),
              child: GestureDetector(
                onTap: flipCard,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateY(_animation.value * 3.14), // Rotate the card
                      child: _animation.value < 0.5
                          ? _buildProfileHeader(context)
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(3.14),
                              child: buildBackCard(),
                            ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: SchoolSizes.xl),
            Center(
              child: SizedBox(
                height: 540, // Height of the card
                width: Get.height,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 4, // Number of items
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _carouselView(index);
                  },
                ),
              ),
            ),
            SizedBox(height: 24,)
          ],
        ),
      ),
    );
  }

  Widget _carouselView(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0); // Scaling effect
        }
        // Get screen width and height
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 625, // Scale effect
            width: Curves.easeOut.transform(value) * 450, // Scale effect
            child: child,
          ),
        );
      },
      child: _buildCard(index),
    );
  }

  // Function to create different cards based on index
  Widget _buildCard(int index) {
    switch (index) {
      case 0:
        return _buildCard1();
      case 1:
        return _buildCard2();
      case 2:
        return _buildCard3();
      case 3:
        return _buildCard4();
      default:
        return const SizedBox();
    }
  }

  // Card 1
  Widget _buildCard1() {
    return Card(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: _buildPersonalDetails(),
    );
  }

  // Card 2
  Widget _buildCard2() {
    return Card(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: _buildAcademicDetails(),
    );
  }

  // Card 3
  Widget _buildCard3() {
    return Card(
      color: SchoolDynamicColors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: _buildTransportDetails(),
    );
  }

  // Card 4
  Widget _buildCard4() {
    return Card(
      color: SchoolDynamicColors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.send, color: Colors.white, size: 48),
            SizedBox(height: 16),
            Text('Card 4: Send',
                style: TextStyle(fontSize: 24, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget buildFrontCard() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.red,
      child: Center(
        child: Text(
          'Front Card',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  final String qrData = "https://your-link.com";

  Widget buildBackCard() {
    return Container(
      padding: EdgeInsets.all(SchoolSizes.lg+24),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius:
            BorderRadius.all(Radius.circular(SchoolSizes.cardRadiusMd)),
        gradient: LinearGradient(
          colors: [Color(0xff1191FD), Color(0xff5E59F2)],
        ),
      ),
      child: Column(
        children: [
          Center(
              child: QrImageView(
            data: 'This QR code has an embedded image as well',
            version: QrVersions.auto,
            size: 260,
            gapless: false,
            backgroundColor: SchoolDynamicColors.white,
            dataModuleStyle: QrDataModuleStyle(
                color: SchoolColors.primaryColor,
                dataModuleShape: QrDataModuleShape.circle),
            eyeStyle: QrEyeStyle(
                eyeShape: QrEyeShape.circle, color: SchoolColors.primaryColor),
            embeddedImage: AssetImage('assets/logos/avatar.png'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(80, 80),
            ),
          )),
          SizedBox(height: SchoolSizes.sm,),
          Text('@aryankr_04',
              style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(color: SchoolDynamicColors.white,)),
          SizedBox(height: SchoolSizes.lg,),
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  vertical: SchoolSizes.sm + 4, horizontal: SchoolSizes.md),
              decoration: BoxDecoration(
                color: SchoolDynamicColors.white,
                borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Scan QR",
                      style: Theme.of(Get.context!)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w500, color: SchoolDynamicColors.activeBlue)),
                  SizedBox(width: SchoolSizes.md,),
                  Icon(Icons.document_scanner_rounded,color: SchoolColors.activeBlue,size: 22,)
                ],
              ),
            ),
          ),
          // Text('Aryan Kumar',
          //     style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(color: SchoolDynamicColors.white,))
        ],
      ),
    );
  }

  // Builds the Profile Header section with avatar and general details
  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildProfileCard(context),
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 52.5,
            backgroundColor: Colors.white,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/logos/avatar.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 65, // Adjust this value to overlap the CircleAvatar
            left: 0,
            right: -320,
            child: CircleAvatar(
              radius: 52.5,
              backgroundColor: Colors.white.withOpacity(0.1),
            )),
        Positioned(
            top: -20, // Adjust this value to overlap the CircleAvatar
            left: -350,
            right: 0,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white.withOpacity(0.1),
            )),
        Positioned(
            top: 60, // Adjust this value to overlap the CircleAvatar
            left: -310,
            right: 0,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(0.1),
            )),
        Positioned(
          top: 40, // Adjust this value to overlap the CircleAvatar
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 52.5,
            backgroundColor: Colors.white,
            child: Container(
              width: 100, // Diameter of the CircleAvatar
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/logos/avatar.png'),
                  fit: BoxFit
                      .contain, // Ensures the image covers the circle without distortion
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Builds the profile card with details
  Widget _buildProfileCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(SchoolSizes.md),
        color: SchoolDynamicColors.white,
      ),
      child: Column(
        children: [
          _buildEditButton(),
          const SizedBox(height: 60),
          _buildProfileText('Aryan Kumar', 'aryankr_04'),
          const Divider(thickness: 0.5, color: SchoolDynamicColors.grey),
          _buildInfoRow(['12', 'C', '10', '122473'],
              ['Class', 'Sec', 'Roll no.', 'Adm No.']),
          const Divider(thickness: 0.5, color: SchoolDynamicColors.grey),
          _buildInfoRow(['934M', '76', '463B', '237'],
              ['Followers', 'Following', 'Likes', 'Posts']),
          const SizedBox(height: SchoolSizes.md),
          _buildFollowMessageButtons(),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      height: 100,
      alignment: Alignment.topRight,
      padding:
          const EdgeInsets.only(right: SchoolSizes.md, top: SchoolSizes.md),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SchoolSizes.cardRadiusMd),
          topRight: Radius.circular(SchoolSizes.cardRadiusMd),
        ),
        gradient: LinearGradient(
          colors: [Color(0xff1191FD), Color(0xff5E59F2)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: SchoolDynamicColors.backgroundColorWhiteLightGrey,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Row(
                children: [
                  Text('Edit'),
                  SizedBox(width: 4),
                  Icon(Icons.edit, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileText(String name, String username) {
    return Column(
      children: [
        Text(name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: SchoolDynamicColors.headlineTextColor)),
        Text(username,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: SchoolDynamicColors.subtitleTextColor)),
      ],
    );
  }

  Widget _buildInfoRow(List<String> values, List<String> labels) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: SchoolSizes.md, horizontal: SchoolSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(values.length, (index) {
          return _buildTextColumn2(context, values[index], labels[index]);
        }),
      ),
    );
  }

  Widget _buildTextColumn2(BuildContext context, String text1, String text2) {
    return Column(
      children: [
        Text(text1, style: Theme.of(context).textTheme.titleMedium),
        Text(text2, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }

  // Follow and Message buttons
  Widget _buildFollowMessageButtons() {
    return Padding(
      padding: const EdgeInsets.all(SchoolSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (!isPrivate) _buildFollowButton(),
          if (!isPrivate) const SizedBox(width: 24),
          _buildMessageButton(),
        ],
      ),
    );
  }

  Widget _buildFollowButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
              vertical: SchoolSizes.sm + 4, horizontal: SchoolSizes.md),
          decoration: BoxDecoration(
            color: SchoolDynamicColors.activeBlue,
            borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
          ),
          child: Text("Follow",
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildMessageButton() {
    return Expanded(
      child: GestureDetector(
        onTap: null,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
              vertical: SchoolSizes.sm + 4, horizontal: SchoolSizes.md),
          decoration: BoxDecoration(
            color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
            borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
            border: Border.all(width: 1, color: SchoolDynamicColors.activeBlue),
          ),
          child: Text("Message",
              style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: SchoolDynamicColors.activeBlue)),
        ),
      ),
    );
  }

  // Section header widget
  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.center,
      child: Text(title, style: Theme.of(Get.context!).textTheme.headlineSmall),
    );
  }

  // Personal Details section
  Widget _buildPersonalDetails() {
    return Padding(
      padding: const EdgeInsets.all(SchoolSizes.md),
      child: Column(
        children: [
          _buildSectionHeader("Personal Details"),
          SizedBox(
            height: SchoolSizes.sm,
          ),
          buildTextColumn('Father', 'Anand Kumar'),
          buildTextColumn('Mother', 'Lalita Devi'),
          buildTextColumn('Mobile No', '9431098856'),
          buildTextColumn('Email', 'aryankumarimpossible@gmail.com'),
          buildTextColumn('Address', 'Chowk Road Dumraon'),
          buildTextColumn('City', 'Dumraon'),
          buildTextColumn('District', 'Buxar'),
          buildTextColumn('State', 'Bihar'),
        ],
      ),
    );
  }

  // Academic Details section
  Widget _buildAcademicDetails() {
    return Padding(
      padding: const EdgeInsets.all(SchoolSizes.md),
      child: Column(
        children: [
          _buildSectionHeader("Academic Details"),
          SizedBox(
            height: SchoolSizes.sm,
          ),
          buildTextColumn('Date of Birth', '4th July 2003'),
          buildTextColumn('Gender', 'Male'),
          buildTextColumn('Blood Group', 'B+'),
          buildTextColumn('Height', '5 ft 6 inch'),
          buildTextColumn('Weight', '60KG'),
          buildTextColumn('Religion', 'Hindu'),
          buildTextColumn('Category', 'OBC'),
        ],
      ),
    );
  }

  // Transportation Details section
  Widget _buildTransportDetails() {
    return Padding(
      padding: const EdgeInsets.all(SchoolSizes.md),
      child: Column(
        children: [
          _buildSectionHeader("Transportation Details"),
          SizedBox(
            height: SchoolSizes.sm,
          ),
          buildTextColumn('Admission Date', '1st March 2019'),
          buildTextColumn('Bus No.', 'KA01HF0007'),
          buildTextColumn('Route', 'Dumraon - Buxar'),
          buildTextColumn('Driver', 'Sunil Kumar'),
          buildTextColumn('Pickup Time', '07:30 AM'),
          buildTextColumn('Drop Time', '01:30 PM'),
        ],
      ),
    );
  }

  // Generic Text Column builder
  Widget buildTextColumn(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SchoolSizes.sm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
              color: SchoolDynamicColors.backgroundColorTintLightGrey,
            ),
            child: Icon(Icons.person,
                size: 20, color: SchoolDynamicColors.primaryIconColor),
          ),
          SizedBox(
            width: SchoolSizes.md,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: SchoolDynamicColors.subtitleTextColor, fontSize: 13),
              ),

              // Divider(
              //   color: SchoolColors.grey,
              //   thickness: 0.5,
              // )
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
        color: SchoolDynamicColors.backgroundColorPrimaryDarkGrey,
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
        //border: Border.all(width: 0.25,color: SchoolColors.grey)
      ),
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.md),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: SchoolDynamicColors.grey,
                    ),
                    const SizedBox(width: SchoolSizes.defaultSpace),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aryan Kumar',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: SchoolDynamicColors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'aryankr_04',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: SchoolDynamicColors.white
                                      .withOpacity(0.5)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color:
                              SchoolDynamicColors.backgroundColorWhiteLightGrey,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: const Row(
                          children: [
                            Text('Edit'),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ],
                        )))
              ],
            ),
            const SizedBox(height: SchoolSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTextColumn(context, '12', 'Class'),
                _buildTextColumn(context, 'C', 'Sec'),
                _buildTextColumn(context, '10', 'Roll No.'),
                _buildTextColumn(context, '122473', 'Adm No.'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextColumn(BuildContext context, String text1, String text2) {
    return Column(
      children: [
        Text(
          text1,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: SchoolDynamicColors.white),
        ),
        Text(
          text2,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: SchoolDynamicColors.white.withOpacity(0.6)),
        ),
      ],
    );
  }
}
