import 'package:flutter/material.dart';

class CustomImageLoader extends StatelessWidget {
  final String imagePath;  // Path to the image

  const CustomImageLoader({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              imagePath, // Image path passed in as a parameter
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
            Positioned.fill(
              child: Transform.rotate(
                angle: 1.0,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
