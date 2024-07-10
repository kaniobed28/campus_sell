import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormLable extends StatelessWidget {
  final String textLable;
  const CustomFormLable({super.key, required this.textLable});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.topLeft,
      child: Text(textLable,style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.labelSmall,
        
      )),
    );
  }
}