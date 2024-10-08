import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/reusable_widgets/constants.dart';
import 'package:campus_sell/reusable_widgets/custom_image_loader.dart';
import 'package:flutter/material.dart';

import 'custom_fullscreen_image.dart';

class SmallProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String totalLikes;

  const SmallProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.totalLikes,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
                    // Handle long press event
                    FullScreenImage.show(context, imageUrl);
                  },
      child: Container(
        width: 154.43,
        height: 210.5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 148.35,
                  width: 154.43,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: CachedNetworkImage(
                      memCacheHeight: imageHeightForDashBoard,
                      memCacheWidth: imageWidthForDashBoard,
                      imageUrl: imageUrl,
                      placeholder: (context, url) => const CustomImageLoader(imagePath: "assets/img/campus-sell-favicon-color.png"),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   left: 8.0,
                //   top: 8.0,
                //   child: GestureDetector(
                    
                //     onTap: () {
                //       FullScreenImage.show(context, imageUrl);
                //     },
                //     child: const CircleAvatar(
                //       backgroundColor:
                //           Colors.transparent, // Makes the background transparent
                //       radius: 12.0,
                //       child: Icon(Icons.remove_red_eye),
                //     ),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color:Theme.of(context).colorScheme.onSurface,
                          ),
                          Text(
                            totalLikes,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
