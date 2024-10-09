import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class SchoolIcon extends StatelessWidget {
  final dynamic icon; // Accepts both IconData and SvgPicture
  final String? text;
  final Color? color;
  final Widget? destination;

  const SchoolIcon({
    Key? key,
    required this.icon,
    this.text,
    this.color,
    this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue, // Update with your desired color
            borderRadius:
                BorderRadius.circular(12), // Update with your desired radius
          ),
          child: InkWell(
            onTap: () {
              if (destination != null) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => destination!));
              }
            },
            child: Container(
              width: 70,
              height: 70,
              padding: icon is SvgPicture
                  ? EdgeInsets.all(SchoolSizes.md)
                  : EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: color,
                // gradient: LinearGradient(
                //     colors: [Color(0xff1191FD), Color(0xff5E59F4)],begin: Alignment.topLeft,end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(
                    12), // Update with your desired radius
              ),
              child: icon is IconData // Check if the icon is IconData
                  ? Icon(
                      icon as IconData,
                      size: 30,
                      color: Colors.white,
                    )
                  : (icon is SvgPicture) // Check if the icon is SvgPicture
                      ? SizedBox(
                          width: 30,
                          height: 30,
                          child: icon as SvgPicture,
                        )
                      : Container(), // Return empty container if neither IconData nor SvgPicture
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          text ?? '',
          style: Theme.of(context)
              .textTheme
              .labelLarge, // Update with your desired text style
        ),
      ],
    );
  }
}
