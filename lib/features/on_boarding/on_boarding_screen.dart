import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/authentication/screens/create_account.dart';
import 'package:my_school_app/utils/constants/colors.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/constants/text_strings.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../authentication/screens/login.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/illustration/high_school.svg",
      "title": "Your Complete School Hub",
      "description":
          "Welcome to ${SchoolTexts.schoolName}! Access everything you need in one place—whether it's grades, schedules, or important announcements."
    },
    {
      "image": "assets/images/illustration/college_projet.svg",
      "title": "Engage & Achieve Together",
      "description":
          "With ${SchoolTexts.schoolName} App, stay updated on assignments, communicate easily, and receive feedback. Learning is better when everyone’s connected!"
    },
    {
      "image": "assets/images/illustration/success.svg",
      "title": "Built for Success & Privacy",
      "description":
          "A secure platform you can trust. We put privacy first, giving you safe access to all your school data."
    },
    {
      "image":
          "assets/images/illustration/mobile_login.svg", // Update this path to your SVG for the last page
      "title": "Get Started With Us!",
      "description":
          "Ready to get started? Log in or register to join our school community!"
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Login()));
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    _pageController.jumpToPage(_onboardingData.length - 1);
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) => OnboardingPage(
                    image: _onboardingData[index]["image"]!,
                    title: _onboardingData[index]["title"]!,
                    description: _onboardingData[index]["description"]!,
                  ),
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: _onboardingData.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: SchoolColors.activeBlue,
                  dotColor: SchoolColors.activeBlue.withOpacity(0.25),
                ),
              ),
              //SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(SchoolSizes.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      TextButton(
                        style: TextButton.styleFrom(
                          splashFactory:
                              NoSplash.splashFactory, // Disables splash effect
                        ),
                        onPressed: _previousPage,
                        child: Text(
                          "Prev",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    if (_currentPage < _onboardingData.length - 1)
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              splashFactory: NoSplash
                                  .splashFactory, // Disables splash effect
                            ),
                            onPressed: _nextPage,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white, // Adjust color as needed
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                                border: Border.all(
                                    color: SchoolColors.activeBlue, width: 1.5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Next",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            color: SchoolColors.activeBlue),
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Spacing between text and icon
                                  Icon(
                                    Icons.arrow_forward,
                                    color: SchoolColors.activeBlue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          _currentPage!=_onboardingData.length-1?
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory, // Disables splash effect
              ),
              onPressed: _skipOnboarding,
              child: Text(
                "Skip",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: SchoolColors.activeBlue),
              ),
            ),
          ):SizedBox(),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image,
            height: title == "Get Started With Us!"
                ? Get.width*0.9
                : Get.width * 1.1 // Show buttons only on the last page
            ,
            fit: BoxFit.fitWidth),
        Padding(
          padding: const EdgeInsets.all(SchoolSizes.md),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SchoolSizes.sm),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: SchoolDynamicColors.subtitleTextColor,fontWeight: FontWeight.w500,fontSize: 15),
                textAlign: TextAlign.center,
              ),
              if (title ==
                  "Get Started With Us!") // Show buttons only on the last page
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0), // Add padding if necessary
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: SchoolSizes.lg), // Space between buttons

                      ElevatedButton(
                        onPressed: () {
                          SchoolHelperFunctions.navigateToScreen(
                              context, Login());
                        },
                        child: Text("Login"),
                      ),
                      SizedBox(height: SchoolSizes.lg), // Space between buttons
                      OutlinedButton(
                        onPressed: () {
                          SchoolHelperFunctions.navigateToScreen(
                              context, CreateAccount());
                        },
                        child: Text("Register"),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
