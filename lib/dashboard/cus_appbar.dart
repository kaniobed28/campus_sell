import 'package:flutter/material.dart';

class CusAppBar extends StatelessWidget {
  const CusAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // foregroundColor: Colors.amber,
      expandedHeight: 200,
      floating: true,
      // pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
            left: 2, top: 30, right: 2, bottom: 10),
        centerTitle: true,
        // title: TitleSingleScrollView(),
        expandedTitleScale: 2,
        background: Container(
          decoration: const BoxDecoration(
              // color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(0))),
          margin: const EdgeInsets.all(0),
          child: const Image(
              image: AssetImage(
                  "assets/img/campus-sell-logo-transparent.png")),
        ),
      ),
    );
  }
}

