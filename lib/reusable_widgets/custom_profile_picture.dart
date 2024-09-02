import 'package:flutter/material.dart';

// ProfilePicture Widget
class ProfilePicture extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfilePicture({
    super.key,
    required this.imageUrl,
    this.radius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: radius,
    );
  }
}
