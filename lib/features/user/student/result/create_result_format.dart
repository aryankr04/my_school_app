import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/datatable.dart';
import 'package:my_school_app/common/widgets/elevated_button.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/dropdown_form_feild.dart';
import '../../../../common/widgets/text_form_feild.dart';
import '../syllabus_and_routine/syllabus.dart';

class CreateResultFormat extends StatefulWidget {
  @override
  State<CreateResultFormat> createState() => _CreateResultFormatState();
}

class _CreateResultFormatState extends State<CreateResultFormat> {
  final RxString selectedClass = ''.obs;
  final TextEditingController examNameController = TextEditingController();
  final RxList<SubjectFormat> subjectFormats = <SubjectFormat>[].obs;
  final RxList<TextEditingController> parameterControllers =
      <TextEditingController>[].obs;
  final RxList<TextEditingController> parameterMarksControllers =
      <TextEditingController>[].obs;

  @override
  void initState() {
    super.initState();
    parameterControllers.add(TextEditingController());
    parameterMarksControllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Result Format'),
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
              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: 'Class',
                validator: RequiredValidator(errorText: 'Select class'),
                onSelected: (value) {
                  selectedClass.value = value;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolTextFormField(
                labelText: 'Exam Name',
                keyboardType: TextInputType.name,
                controller: examNameController,
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              Obx(() => Wrap(
                    spacing: SchoolSizes.md,
                    runSpacing: SchoolSizes.md,
                    children: List.generate(subjectFormats.length, (index) {
                      return subjectFormatRow(subjectFormats[index], () {
                        final TextEditingController subjectNameController =
                            TextEditingController(
                                text: subjectFormats[index].subjectName);
                        final TextEditingController subjectMarksController =
                            TextEditingController(
                                text: subjectFormats[index].marks);
                        buildShowModalBottomSheetForAddingSubjectFormat(
                            context,
                            subjectNameController,
                            subjectMarksController,
                            true,
                            index);
                      }, () {
                        subjectFormats.remove(subjectFormats[index]);
                      });
                    }),
                  )),
              Obx(
                () => subjectFormats.isNotEmpty
                    ? SizedBox(
                        height: SchoolSizes.lg,
                      )
                    : SizedBox(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                    onPressed: () {
                      final TextEditingController subjectNameController =
                          TextEditingController();
                      final TextEditingController subjectMarksController =
                          TextEditingController();
                      buildShowModalBottomSheetForAddingSubjectFormat(
                          context,
                          subjectNameController,
                          subjectMarksController,
                          false,
                          0);
                    },
                    child: Text('Add new Subject')),
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolElevatedButton(
                  text: 'Create',
                  onPressed: () {
                    sendSubjectFormatsToFirebase(subjectFormats);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendSubjectFormatsToFirebase(
      List<SubjectFormat> subjectFormats) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference subjectFormatsCollection =
          FirebaseFirestore.instance.collection('examFormats');

      // Convert the list of SubjectFormat objects into a map
      Map<String, dynamic> data = {
        'subjectFormats': subjectFormats
            .map((subjectFormat) => {
                  'subjectName': subjectFormat.subjectName,
                  'marks': subjectFormat.marks,
                  'parameters': subjectFormat.parameters
                      .map((parameter) => {
                            'parameterName': parameter.parameterName,
                            'marks': parameter.marks,
                          })
                      .toList(),
                })
            .toList(),
        'examName': examNameController.text,
        'className': selectedClass.value,
        'schoolId': 'SCH0000000001'
      };

      // Add the data to Firestore as a single document
      await subjectFormatsCollection.doc('subjectFormatsDocument').set(data);

      print('SubjectFormats data sent successfully to Firebase.');
    } catch (e) {
      print('Failed to send SubjectFormats data to Firebase: $e');
    }
  }

  Future<dynamic> buildShowModalBottomSheetForAddingSubjectFormat(
      BuildContext context,
      TextEditingController subjectNameController,
      TextEditingController subjectMarksController,
      bool isEdit,
      int? index) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: SchoolHelperFunctions.isDarkMode(context)
          ? SchoolDynamicColors.black
          : Colors.white,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            // constraints: BoxConstraints(minHeight: Get.width),
            height: Get.height * 0.8,
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: SchoolTextFormField(
                              controller: subjectNameController,
                              labelText: 'Subject Name',
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                                hintText: 'Enter a subject name',
                                hintStyle: Theme.of(Get.context!)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SchoolSizes.md,
                          ),
                          Flexible(
                            flex: 1,
                            child: SchoolTextFormField(
                              controller: subjectMarksController,
                              keyboardType: TextInputType.number,
                              labelText: 'Total Marks',
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                                hintText: 'Total Marks',
                                hintStyle: Theme.of(Get.context!)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SchoolSizes.md,
                      ),
                      ...buildTopicFormFields(),
                      Align(
                        alignment: FractionalOffset.centerRight,
                        child: TextButton(
                          onPressed: () {
                            parameterControllers.add(TextEditingController());
                            parameterMarksControllers
                                .add(TextEditingController());
                          },
                          child: Text('Add new parameter'),
                        ),
                      ),
                      SchoolElevatedButton(
                        text: isEdit ? 'Edit' : 'Add',
                        onPressed: () {
                          SubjectFormat newSubject = SubjectFormat(
                            subjectName: subjectNameController.text ?? '',
                            marks: subjectMarksController.text ?? '',
                            parameters: parameterControllers.value
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              TextEditingController? controller = entry.value;
                              TextEditingController? marksController =
                                  parameterMarksControllers.value[index];
                              return Parameter(
                                parameterName: controller?.text ?? '',
                                marks: marksController?.text ?? '',
                              );
                            }).toList(),
                          );
                          if (isEdit) {
                            // Update existing subject
                            if (index != null &&
                                index >= 0 &&
                                index < subjectFormats.length) {
                              subjectFormats[index] = newSubject;
                            }
                          } else {
                            // Add new subject
                            subjectFormats.add(newSubject);
                          }
                          Navigator.pop(context); // Close the bottom sheet
                        },
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  Widget subjectFormatRow(SubjectFormat subjectFormat,
      VoidCallback onEditPressed, VoidCallback onDeletePressed) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: SchoolSizes.md, horizontal: SchoolSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${subjectFormat.subjectName} (${subjectFormat.marks} Marks)',
                    style: Theme.of(Get.context!).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        onEditPressed();
                      },
                      child: Icon(
                        Icons.edit,
                        color: SchoolDynamicColors.activeBlue,
                      ),
                    ),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    InkWell(
                      onTap: () {
                        onDeletePressed();
                      },
                      child: Icon(
                        Icons.delete,
                        color: SchoolDynamicColors.activeRed,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: SchoolSizes.sm,
            ),
            Wrap(
              direction: Axis.vertical,
              children: List.generate(subjectFormat.parameters.length, (index) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: SchoolDynamicColors.activeBlue,
                    ),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    Text(
                        '${subjectFormat.parameters[index].parameterName} -  ${subjectFormat.parameters[index].marks} Marks'),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildTopicFormFields() {
    return parameterControllers.value.asMap().entries.map((entry) {
      int index = entry.key;
      TextEditingController controller = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: SchoolTextFormField(
                  controller: controller,
                  labelText: 'Parameter',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                    hintText: 'Theory / Practical / Assignment',
                    hintStyle: Theme.of(Get.context!)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                width: SchoolSizes.md,
              ),
              Flexible(
                flex: 1,
                child: SchoolTextFormField(
                  controller: parameterMarksControllers.value[index],
                  keyboardType: TextInputType.number,
                  labelText: 'Marks',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                    hintText: 'Marks',
                    hintStyle: Theme.of(Get.context!)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  parameterControllers.removeAt(index);
                  parameterMarksControllers.removeAt(index);
                },
                icon: Icon(
                  Icons.remove_circle,
                  color: SchoolDynamicColors.activeRed,
                ),
              ),
            ],
          ),
          SizedBox(
            height: SchoolSizes.md,
          )
        ],
      );
    }).toList();
  }
}

class SubjectFormat {
  String subjectName;
  String marks;
  List<Parameter> parameters;

  SubjectFormat({
    required this.subjectName,
    required this.parameters,
    required this.marks,
  });
}

class Parameter {
  String parameterName;
  String marks;

  Parameter({
    required this.parameterName,
    required this.marks,
  });
}

class ExamFormat {
  String examName;
  List<SubjectFormat> subjects;

  ExamFormat({
    required this.examName,
    required this.subjects,
  });
}

class StudentResult {
  String studentName;
  Map<String, SubjectResult> subjects;
  String rollNo;
  String id;
  String total;

  StudentResult(
      this.studentName, this.subjects, this.rollNo, this.id, this.total);
}

class SubjectResult {
  Map<String, dynamic> additionalParameters;

  SubjectResult(this.additionalParameters);
}
