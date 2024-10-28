import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import 'text_form_feild.dart';

class DatePickerField extends StatefulWidget {
  final String labelText;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime>? onDateChanged;

  DatePickerField({
    required this.initialDate,
     this.onDateChanged,
    required this.firstDate,
    required this.lastDate,
    required this.labelText,
  });

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late TextEditingController _dateController;
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _dateController = TextEditingController(
      text: _selectedDate != null
          ? DateFormat('dd MMMM yyyy').format(_selectedDate!)
          : '',
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? null,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd MMMM yyyy').format(picked);
        widget.onDateChanged!(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SchoolTextFormField(
      validator: RequiredValidator(errorText: ''),
      labelText: widget.labelText,
      suffixIcon: Icons.calendar_month,
      controller: _dateController,
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }
}
