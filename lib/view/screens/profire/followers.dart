import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:snaplink_app/main.dart';

import '../../components/theme/colors.dart';
import '../../components/widget_custom/profile_page_button.dart';

class User {
  User(this.name, this.username, this.isFollowing, this.image);

  final String name;
  final String username;
  final String image;
  bool isFollowing;
}

class FollowersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FollowersBody();
  }
}

class FollowersBody extends StatefulWidget {
  @override
  _FollowersBodyState createState() => _FollowersBodyState();
}

class _FollowersBodyState extends State<FollowersBody> {
  List<User> users = [
    User("George Smith", "@georgesmith", true, 'assets/user/user1.png'),
    User("Emili Wiliamson", "@emiliwilliamson", true, 'assets/user/user2.png'),
    User("Kesha Taylor", "@iamkesha007", false, 'assets/user/user3.png'),
    User("Linda Johnson", "@lindahere", true, 'assets/user/user2.png'),
    User("Opus Labs", "@opuslabs", true, 'assets/user/user4.png'),
    User("Ling Tong", "@lingtong", false, 'assets/user/user3.png'),
    User("Tosh Williamson", "@mr.williamson", true, 'assets/user/user1.png'),
    User("Uzuz Smith", "@imuzuz", true, 'assets/user/user4.png'),
    User("Rohan Patel", "@roahnindian", true, 'assets/user/user2.png'),
    User("Opus Labs", "@opuslabs", true, 'assets/user/user4.png'),
    User("Ling Tong", "@lingtong", false, 'assets/user/user3.png'),
    User("Tosh Williamson", "@mr.williamson", true, 'assets/user/user1.png'),
    User("Uzuz Smith", "@imuzuz", true, 'assets/user/user4.png'),
    User("Rohan Patel", "@roahnindian", true, 'assets/user/user2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkColor,
        appBar: AppBar(
          title: Text('followers'.tr()),
          centerTitle: true,
        ),
        body: FadedSlideAnimation(
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(users[index].image),
                  ),
                  title: Text(
                    users[index].name,
                    style: TextStyle(color: secondaryColor),
                  ),
                  subtitle: Text(
                    users[index].username,
                    style: TextStyle(),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: users[index].isFollowing
                        ? ProfilePageButton(
                            text: 'following'.tr(),
                            onTap: () {
                              setState(() {
                                users[index].isFollowing =
                                    !users[index].isFollowing;
                              });
                            },
                          )
                        : ProfilePageButton(
                            text: 'follow'.tr(),
                            onTap: () {
                              setState(() {
                                users[index].isFollowing =
                                    !users[index].isFollowing;
                              });
                            },
                            color: mainColor,
                            textColor: secondaryColor,
                          ),
                  ),
                );
              }),
        ));
  }
}
