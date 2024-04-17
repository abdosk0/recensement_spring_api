import 'package:flutter/material.dart';
import '../models/indicateur.dart';
import 'date_form_field.dart';
import 'dropdown_form_field.dart';
import 'multi_selection_form_field.dart';
import 'nombre_form_field.dart';
import 'radio_form_field.dart';
import 'text_area_form_field.dart';
import 'text_field_widget.dart';
// Import other custom widgets for different types as needed

class DynamicIndicatorItem extends StatefulWidget {
  final Indicateur indicateur;
  final TextEditingController controller;
  final dynamic selectedValue;
  final Function(dynamic)?
      onValueSelected; // Update callback to accept a list of strings

  const DynamicIndicatorItem({
    Key? key,
    required this.indicateur,
    required this.controller,
    this.onValueSelected,
    this.selectedValue,
  }) : super(key: key);

  @override
  _DynamicIndicatorItemState createState() => _DynamicIndicatorItemState();
}

class _DynamicIndicatorItemState extends State<DynamicIndicatorItem> {
  dynamic currentValue; // Store the current value locally

  @override
  void initState() {
    super.initState();
    currentValue = widget.selectedValue; // Initialize with selected value
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.indicateur.type) {
      case 'Text':
        return TextFieldWidget(
          labelText: widget.indicateur.nomIndicateur,
          controller: widget.controller,
          isRequired: widget.indicateur.obligatoire,
        );
      case 'Nombre':
        return NombreFormField(
          labelText: widget.indicateur.nomIndicateur,
          controller: widget.controller,
          isRequired: widget.indicateur.obligatoire,
        );
      case 'Dropdown':
        return DropdownFormField(
          label: widget.indicateur.nomIndicateur,
          valeursPossibles: widget.indicateur.valeursPossibles,
          selectedOption: currentValue,
          onChanged: (String? value) {
            setState(() {
              currentValue = value;
              widget.onValueSelected!(value);
            });
          },
          isRequired: widget.indicateur.obligatoire,
        );
      case 'Radio':
        return RadioFormField(
          label: widget.indicateur.nomIndicateur,
          valeursPossibles: widget.indicateur.valeursPossibles,
          selectedOption: currentValue,
          onChanged: (String? value) {
            setState(() {
              currentValue = value;
              widget.onValueSelected!(value);
            });
          },
          isRequired: widget.indicateur.obligatoire,
        );
      case 'Multiselection':
        return MultiSelectionFormField(
          label: widget.indicateur.nomIndicateur,
          valeursPossibles: widget.indicateur.valeursPossibles,
          selectedOptions: widget.selectedValue != null
              ? widget.selectedValue!
                  .split(',') // Convert selectedValue to List
              : [],
          onChanged: (List<String> value) {
            setState(() {
              widget.onValueSelected!(
                  value.join(',')); // Join list back to string
            });
          },
          isRequired: widget.indicateur.obligatoire,
        );
      case 'Date':
        return DateFormField(
          label: widget.indicateur.nomIndicateur,
          controller: widget.controller,
          isRequired: widget.indicateur.obligatoire,
        );
      case 'TextArea':
        return TextAreaFormField(
          label: widget.indicateur.nomIndicateur,
          controller: widget.controller,
          isRequired:
              widget.indicateur.obligatoire, // Use the obligatoire field
        );

      default:
        return Container(); // Placeholder for unsupported types
    }
  }
}
