import 'package:flutter/material.dart';

class AgoTechAssetImageCard extends StatelessWidget {
  final String imagePath;
  const AgoTechAssetImageCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(imagePath,fit: BoxFit.fill,),
    );
  }
}
