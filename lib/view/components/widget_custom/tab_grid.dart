import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class Grid {
  Grid(this.imgUrl, this.views);
  final String imgUrl;
  final String views;
}

class TabGrid extends StatelessWidget {
  final IconData? icon;
  final List? list;
  final Function? onTap;
  final IconData? viewIcon;

  TabGrid(this.list, {this.icon, this.onTap, this.viewIcon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: list?.length ?? 0, // Use null-aware operator
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 2.5,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      itemBuilder: (context, index) {
        final item = list![index]; // Get the item from the list

        return GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap!(); // Call the onTap function if provided
            }
          },
          child: FadedScaleAnimation(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item.imgUrl), // Use the image URL from the Grid object
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    viewIcon,
                    color: secondaryColor,
                    size: 15,
                  ),
                  SizedBox(width: 4), // Add spacing for better readability
                  Text(item.views), // Display the views from the Grid object
                  Spacer(),
                  Icon(
                    icon,
                    color: mainColor,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
