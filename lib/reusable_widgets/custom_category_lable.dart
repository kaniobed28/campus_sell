import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCategoryLabel extends StatelessWidget {
  final String textLabel;
  final Color backgroundColor;
  final Color textColor;
  final double padding;
  final double borderRadius;

  const CustomCategoryLabel({
    super.key,
    required this.textLabel,
    this.backgroundColor = Colors.white,  // Default to amber as it's part of your color theme
    this.textColor = Colors.white,        // Default white text on amber background
    this.padding = 8.0,                   // Default padding
    this.borderRadius = 12.0,             // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,         // Customizable background color
          borderRadius: BorderRadius.circular(borderRadius),  // Rounded corners
        ),
        child: Text(
          textLabel,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: textColor,          // Customizable text color
                  fontWeight: FontWeight.w600,  // Adding font weight for better readability
                ),
          ),
        ),
      ),
    );
  }
}
