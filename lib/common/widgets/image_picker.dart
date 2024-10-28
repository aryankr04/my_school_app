import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class ImagePickerWidget extends StatefulWidget {
  final File? image;
  final ValueChanged<File> onImageSelected;
  final String? label;

  const ImagePickerWidget({
    Key? key,
    required this.image,
    required this.onImageSelected,
    this.label,
  }) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late File? _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        widget.onImageSelected(_image!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.activeBlue.withOpacity(0.05),
                  borderRadius: BorderRadius.all(
                      Radius.circular(SchoolSizes.cardRadiusXs)),
                  border: Border.all(
                    color: SchoolDynamicColors.primaryColor,
                    width: 1,
                  ),
                ),
                child: _image == null
                    ? Icon(
                        Icons.add_a_photo_rounded,
                        size: 28,
                        color: SchoolDynamicColors.activeBlue,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(SchoolSizes.cardRadiusXs)),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: SchoolSizes.lg,
        ),
        Expanded(
          // Wrap the container with Expanded
          child: InkWell(
            onTap: _pickImage,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _image == null
                    ? SchoolDynamicColors.activeBlue
                    : SchoolDynamicColors.activeBlue,
                borderRadius:
                    BorderRadius.all(Radius.circular(SchoolSizes.cardRadiusXs)),
              ),
              child: Text(
                _image == null
                    ? widget.label != null
                        ? "Select ${widget.label!} Image "
                        : 'Select a Profile Image'
                    : 'Change ${widget.label!} Image', // Use the label
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center the text
              ),
            ),
          ),
        ),
        const SizedBox(
          width: SchoolSizes.lg,
        ),
        _image != null
            ? CircleAvatar(
                backgroundColor: SchoolDynamicColors.activeGreen,
                radius: 14,
                child: Icon(
                  Icons.check_rounded,
                  size: 22,
                  color: SchoolDynamicColors.white,
                ))
            : SizedBox()
      ],
    );
  }
}
