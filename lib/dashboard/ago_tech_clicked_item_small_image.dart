import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AgoTechClickedItemSmallImage extends StatelessWidget {
  final dynamic imageUrl;
  const AgoTechClickedItemSmallImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
            imageUrl:
                imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.fill,
          
      ),
    );
  }
}
