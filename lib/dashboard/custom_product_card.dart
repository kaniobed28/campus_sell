import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/reusable_widgets/custom_fullscreen_image.dart';
import 'package:campus_sell/reusable_widgets/custom_image_loader.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final String price;
  final int likes;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.itemName,
    required this.price,
    required this.likes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: GestureDetector(
                onLongPress: () {
                  FullScreenImage(imageUrl: imageUrl,);
                  FullScreenImage.show(context, imageUrl);
                },
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CustomImageLoader(imagePath: "assets/img/campus-sell-favicon-color.png",),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  memCacheHeight: 120, // Set according to your needs
                  memCacheWidth: 120, // Set according to your needs
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style:  TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                     SizedBox(height: 5),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 16.0,
                        color:Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.favorite_border, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          likes.toString(),
                          style:  TextStyle(fontSize: 14.0,color: Theme.of(context).colorScheme.onSurface,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
