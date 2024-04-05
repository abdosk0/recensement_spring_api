import 'package:flutter/material.dart';

class VilleDropdown extends StatefulWidget {
  
  final List<Map<String, dynamic>> citiesData;
  final String selectedCity;
  final ValueChanged<String?>? onChanged;

  const VilleDropdown({
    Key? key,
    required this.citiesData,
    required this.selectedCity,
    this.onChanged,
  }) : super(key: key);

  @override
  _CityDropdownState createState() => _CityDropdownState();
}

class _CityDropdownState extends State<VilleDropdown> {
  @override
  Widget build(BuildContext context) {
    List<String> cityNames =
        widget.citiesData.map((city) => city['city'].toString()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ville',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white), // Text color
        ),
        const SizedBox(height: 8),
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xFF008A90), // Dropdown background color
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white), // Text color
          ),
          child: DropdownButtonFormField<String>(
            value: widget.selectedCity,
            onChanged: widget.onChanged, // Pass the onChanged callback here
            items: cityNames.map<DropdownMenuItem<String>>((String cityName) {
              return DropdownMenuItem<String>(
                value: cityName,
                child: Text(cityName),
              );
            }).toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF008A90), // Background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),
            ),
          ),
        ),
      ],
    );
  }
}
