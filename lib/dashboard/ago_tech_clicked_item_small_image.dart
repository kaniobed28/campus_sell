import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/reusable_widgets/custom_fullscreen_image.dart';
import 'package:flutter/material.dart';

class AgoTechClickedItemSmallImage extends StatelessWidget {
  final String imageUrl;

  const AgoTechClickedItemSmallImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FullScreenImage.show(context, imageUrl);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
