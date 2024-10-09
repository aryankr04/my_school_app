import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class ImagePickerWidget extends StatefulWidget {
  final File? image;
  final ValueChanged<File> onImageSelected;

  const ImagePickerWidget({
    Key? key,
    required this.image,
    required this.onImageSelected,
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
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        widget.onImageSelected(_image!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: SchoolDynamicColors.primaryColor,
                    width: 0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : null,
                  backgroundColor: SchoolDynamicColors.primaryTintColor,
                ),
              ),
               Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: SchoolDynamicColors.primaryColor,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: SchoolSizes.sm,
        ),
        Text(
          _image == null ? 'Select Profile Image' : 'Image Selected',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _image == null ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}
