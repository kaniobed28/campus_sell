import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

TextFormField nameFormWidget(
  TextEditingController nameOfFormController,
  RegExp regExp, {
  bool obscureText = false,
  String nameOfLabel = '',
  IconData? prefixIcon,
}) {
  return TextFormField(
    controller: nameOfFormController,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: nameOfLabel,
      border: const OutlineInputBorder(),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    ),
    validator: (value) {
      if (value != null && value.isNotEmpty && !regExp.hasMatch(value)) {
        return 'Invalid input';
      }
      return null; // Allows empty values
    },
  );
}

class SellInfoWidgets {
  static Widget buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    String pattern,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty && !RegExp(pattern).hasMatch(value)) {
          return 'Invalid input';
        }
        return null; // Allows empty values
      },
    );
  }

  static Widget buildCountryDropdown(
    BuildContext context,
    TextEditingController countryController,
    List<String> countryList,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: countryController.text.isNotEmpty ? countryController.text : null,
      items: countryList.map((String country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Text(country, style: Theme.of(context).textTheme.labelSmall),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: "Country",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.flag),
      ),
      validator: (value) {
        return null; // No validation required for empty or unselected values
      },
    );
  }

  static Widget buildCityDropdown(
    BuildContext context,
    TextEditingController cityController,
    List<String> cityList,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: cityController.text.isNotEmpty ? cityController.text : null,
      items: cityList.map((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city, style: Theme.of(context).textTheme.labelSmall),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: "City Name",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.location_city),
      ),
      validator: (value) {
        return null; // No validation required for empty or unselected values
      },
    );
  }

  static Widget buildUniversityDropdown(
    BuildContext context,
    TextEditingController universityController,
    List<String> universityList,
    bool isGhanaSelected,
  ) {
    return DropdownButtonFormField<String>(
      value: universityController.text.isNotEmpty
          ? universityController.text
          : null,
      items: universityList.map((String university) {
        return DropdownMenuItem<String>(
          value: university,
          child: Text(university, style: Theme.of(context).textTheme.labelSmall),
        );
      }).toList(),
      onChanged: isGhanaSelected
          ? (val) {
              universityController.text = val!;
            }
          : null,
      decoration: const InputDecoration(
        labelText: "University Name (Ghana only)",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.school),
      ),
      validator: (value) {
        return null; // No validation required
      },
      disabledHint: const Text("Not applicable", overflow: TextOverflow.ellipsis),
    );
  }

  static Widget buildSubmitButton(RxBool updateInfo, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Obx(
        () => ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.person_4_rounded, color: Color(0xFF383636)),
          label: updateInfo.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF383636)),
                  strokeWidth: 4.0,
                )
              : Text(
                  'Update',
                  style: GoogleFonts.average(color: const Color(0xFF383636)),
                ),
        ),
      ),
    );
  }
}
