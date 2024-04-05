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

  const DynamicIndicatorItem({
    Key? key,
    required this.indicateur,
    required this.controller,
  }) : super(key: key);

  @override
  _DynamicIndicatorItemState createState() => _DynamicIndicatorItemState();
}

class _DynamicIndicatorItemState extends State<DynamicIndicatorItem> {
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
        final firstOption = widget.indicateur.valeursPossibles.isNotEmpty
            ? widget.indicateur.valeursPossibles.first.nomValeur
            : null;
        return DropdownFormField(
          label: widget.indicateur.nomIndicateur,
          selectedOption: firstOption,
          onChanged: (String? value) {
            // Handle dropdown value change here
          },
          valeursPossibles: widget.indicateur.valeursPossibles,
          isRequired: widget.indicateur.obligatoire,
        );
      case 'Radio':
        final firstOption = widget.indicateur.valeursPossibles.isNotEmpty
            ? widget.indicateur.valeursPossibles.first.nomValeur
            : null;
        return RadioFormField(
          label: widget.indicateur.nomIndicateur,
          selectedOption: firstOption,
          onChanged: (String? value) {
          },
          valeursPossibles: widget.indicateur.valeursPossibles,
          isRequired: widget.indicateur.obligatoire,
        );
      case 'Date':
        return DateFormField(
          label: widget.indicateur.nomIndicateur,
          controller: widget.controller,
          isRequired: widget.indicateur.obligatoire,
        );
      case 'Multiselection':
        return MultiSelectionFormField(
          label: widget.indicateur.nomIndicateur,
          selectedOptions: [], // Provide initial selected options here
          onChanged: (List<String> value) {
            // Handle multi-selection value change here
          },
          valeursPossibles: widget.indicateur.valeursPossibles,
          isRequired: widget.indicateur.obligatoire,
        );
      case 'TextArea':
        return TextAreaFormField(
          label: widget.indicateur.nomIndicateur,
          controller: widget.controller,
          isRequired: widget.indicateur.obligatoire, // Use the obligatoire field
        );

      default:
        return Container(); // Placeholder for unsupported types
    }
  }
}
