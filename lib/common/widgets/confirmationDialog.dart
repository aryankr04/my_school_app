import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/custom_button.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

enum DialogAction { Delete, Save, Exit }

class CustomConfirmationDialog extends StatelessWidget {
  final DialogAction action;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  CustomConfirmationDialog({
    required this.action,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    String title = '';
    String content = '';
    String confirmText = '';
    String cancelText = 'Cancel';
    Color color = Colors.black;
    Icon icon = Icon(Icons.circle);

    switch (action) {
      case DialogAction.Delete:
        title = 'Confirm Deletion';
        content = 'Are you sure you want to delete this item?';
        confirmText = 'Delete';
        color = SchoolDynamicColors.activeRed;
        icon = Icon(Icons.delete_forever_rounded, size: 24, color: color);
        break;
      case DialogAction.Save:
        title = 'Confirm Save';
        content = 'Are you sure you want to save this item?';
        confirmText = 'Save';
        color = SchoolDynamicColors.activeGreen;
        icon = Icon(Icons.save_rounded, size: 24, color: color);
        break;
      case DialogAction.Exit:
        title = 'Confirm Exit';
        content = 'Are you sure you want to exit without saving your changes?';
        confirmText = 'Exit';
        color = SchoolDynamicColors.activeRed;
        icon = Icon(Icons.exit_to_app_rounded, size: 24, color: color);
        break;
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.all(SchoolSizes.lg
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.1),
            child: icon,
          ),
          SizedBox(height: SchoolSizes.md),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SchoolSizes.sm),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SchoolSizes.lg),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onCancel != null) onCancel!();
                  },
                  text: cancelText,
                  color: Colors.grey.shade300,
                  style: CustomButtonStyle.outlined,
                ),
              ),
              SizedBox(width: SchoolSizes.md),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  text: confirmText,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Static method to show the dialog
  static Future<void> show(
    DialogAction action, {
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomConfirmationDialog(
          action: action,
          onConfirm: onConfirm,
          onCancel: onCancel,
        );
      },
    );
  }
}
