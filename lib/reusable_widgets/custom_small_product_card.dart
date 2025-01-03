import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/reusable_widgets/constants.dart';
import 'package:campus_sell/reusable_widgets/custom_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'custom_fullscreen_image.dart';

class SmallProductCard extends StatefulWidget {
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
  _SmallProductCardState createState() => _SmallProductCardState();
}

class _SmallProductCardState extends State<SmallProductCard> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.imageUrl), // unique key to track visibility
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0 && !isVisible) {
          setState(() => isVisible = true); // Trigger animation when visible
        }
      },
      child: Animate(
        effects: [
          FadeEffect(duration: 500.ms, curve: Curves.easeIn),
          SlideEffect(begin: const Offset(0, 0.2), end: const Offset(0, 0), duration: 90.ms),
          RotateEffect(begin: -0.1, end: 0.0, duration: 400.ms, curve: Curves.easeOut), // RotateEffect now uses double values
       ],
        child: GestureDetector(
          onLongPress: () {
            // Handle long press event
            FullScreenImage.show(context, widget.imageUrl);
          },
          child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.5,
            duration: 100.ms,
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
                            imageUrl: widget.imageUrl,
                            placeholder: (context, url) => const CustomImageLoader(imagePath: "assets/img/campus-sell-favicon-color.png"),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
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
                              widget.price,
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
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                Text(
                                  widget.totalLikes,
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
          ),
        ),
      ),
    );
  }
}
