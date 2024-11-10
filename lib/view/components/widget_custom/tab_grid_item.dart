import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class TabGridView extends StatelessWidget {
  final IconData? icon;
  final List<String>? list; // Danh sách kiểu List<String>
  final Function? onTap;
  final IconData? viewIcon;

  TabGridView(this.list, {this.icon, this.onTap, this.viewIcon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: list?.length ?? 0, // Kiểm tra nếu list có phần tử
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 2.5,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      itemBuilder: (context, index) {
        final item = list![index]; // Truy cập vào phần tử của list (chuỗi đường dẫn hình ảnh)

        return GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap!(); // Gọi hàm onTap nếu có
            }
          },
          child: FadedScaleAnimation(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item), // Sử dụng đường dẫn hình ảnh từ item
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (viewIcon != null) // Kiểm tra nếu có viewIcon
                    Icon(
                      viewIcon,
                      color: secondaryColor,
                      size: 15,
                    ),
                  SizedBox(width: 4), // Khoảng cách giữa các phần tử
                  // Text hoặc thông tin khác nếu cần
                  Spacer(),
                  if (icon != null) // Kiểm tra nếu có icon
                    Icon(
                      icon,
                      color: mainColor,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
