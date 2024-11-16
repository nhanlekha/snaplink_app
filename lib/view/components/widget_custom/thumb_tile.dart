import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';

class ThumbTile extends StatelessWidget {
  final String mediaListData;

  const ThumbTile(this.mediaListData, {super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: FadedScaleAnimation(
        child: Container(
          margin: const EdgeInsets.only(left: 8.0),
          height: screenWidth / 3,
          width: screenWidth / 4.25,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(mediaListData), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
