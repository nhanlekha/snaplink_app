import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:snaplink_app/main.dart';

import '../../components/theme/colors.dart';
import '../../components/widget_custom/profile_page_button.dart';
import '../../components/widget_custom/row_item.dart';
import '../../components/widget_custom/score_container.dart';
import '../../components/widget_custom/sliver_app_delegate.dart';
import '../../components/widget_custom/tab_grid.dart';
import '../../components/widget_custom/tab_grid_item.dart';
import 'followers.dart';
import 'following.dart';

List<String> dance = [
  'assets/thumbnails/dance/Layer 951.png',
  'assets/thumbnails/dance/Layer 952.png',
  'assets/thumbnails/dance/Layer 953.png',
  'assets/thumbnails/dance/Layer 954.png',
  'assets/thumbnails/dance/Layer 951.png',
  'assets/thumbnails/dance/Layer 952.png',
  'assets/thumbnails/dance/Layer 953.png',
  'assets/thumbnails/dance/Layer 954.png',
];
List<String> lol = [
  'assets/thumbnails/lol/Layer 978.png',
  'assets/thumbnails/lol/Layer 979.png',
  'assets/thumbnails/lol/Layer 980.png',
  'assets/thumbnails/lol/Layer 981.png',
];
List<String> food = [
  'assets/thumbnails/food/Layer 783.png',
  'assets/thumbnails/food/Layer 784.png',
  'assets/thumbnails/food/Layer 785.png',
  'assets/thumbnails/food/Layer 786.png',
  'assets/thumbnails/food/Layer 787.png',
  'assets/thumbnails/food/Layer 788.png',
];

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyProfileBody();
  }
}

class MyProfileBody extends StatefulWidget {
  const MyProfileBody({super.key});

  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: Stack(
        children: [
          DefaultTabController(
            length: 3,
            child: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 380.0,
                      floating: false,
                      actions: <Widget>[
                        Theme(
                          data: Theme.of(context).copyWith(
                            cardColor: backgroundColor,
                          ),
                          child: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: secondaryColor,
                            ),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none),
                            onSelected: (dynamic value) {
                              switch (value) {
                                case "Change Language":
                                  // Navigator.pushNamed(context, PageRoutes.languagePage);
                                  break;
                                case "Help":
                                  print("help");
                                  // Navigator.pushNamed(context, PageRoutes.helpPage);
                                  break;
                                case "Terms of Use":
                                  // Navigator.pushNamed(context, PageRoutes.tncPage);
                                  break;
                                case "Logout":
                                  break;
                                case "Redeem Coins":
                                  // Navigator.pushNamed(context, PageRoutes.redeemCoins);
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: Text('Change Language'),
                                  value: 'Change Language',
                                  textStyle: TextStyle(color: secondaryColor),
                                ),
                                PopupMenuItem(
                                  child: Text('Help'),
                                  value: 'Help',
                                  textStyle: TextStyle(color: secondaryColor),
                                ),
                                PopupMenuItem(
                                  child: Text("Redeem Coins"),
                                  value: "Redeem Coins",
                                  textStyle: TextStyle(color: secondaryColor),
                                ),
                                PopupMenuItem(
                                  child: Text('Terms of Use'),
                                  value: 'Terms of Use',
                                  textStyle: TextStyle(color: secondaryColor),
                                ),
                                PopupMenuItem(
                                  child: Text('Logout'),
                                  value: 'Logout',
                                  textStyle: TextStyle(color: secondaryColor),
                                )
                              ];
                            },
                          ),
                        )
                      ],
                      flexibleSpace: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFBDC3C7), // Màu đầu tiên
                              Color(0xFF2C3E50), // Màu thứ hai
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 50),
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.webp'),
                            ),
                            Text(
                              'BlackFox',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '@blackfox',
                              style: TextStyle(
                                  fontSize: 10, color: disabledTextColor),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(
                                  AssetImage("assets/icons/ic_fb.png"),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                                SizedBox(width: 16),
                                ImageIcon(
                                  AssetImage("assets/icons/ic_twt.png"),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                                SizedBox(width: 16),
                                ImageIcon(
                                  AssetImage("assets/icons/ic_insta.png"),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RowItem(
                                    '1.2m',
                                    'liked'.tr(),
                                    Scaffold(
                                      appBar: AppBar(
                                        title: Text('Liked'),
                                      ),
                                      body: Container(),
                                    )),
                                RowItem(
                                    '12.8k', 'followers'.tr(), FollowersPage()),
                                RowItem(
                                    '1.9k', 'following'.tr(), FollowingPage()),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ProfilePageButton(
                                  text: 'message',
                                  onTap: () {},
                                ),
                                SizedBox(width: 16),
                                isFollowed
                                    ? ProfilePageButton(
                                        text: 'following',
                                        onTap: () {
                                          setState(() {
                                            isFollowed = false;
                                          });
                                        })
                                    : ProfilePageButton(
                                        text: 'follow',
                                        onTap: () {
                                          setState(() {
                                            isFollowed = true;
                                          });
                                        },
                                        color: mainColor,
                                        textColor: secondaryColor,
                                      ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              'comment7'.tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: SliverAppBarDelegate(
                        TabBar(
                          labelColor: mainColor,
                          unselectedLabelColor: lightTextColor,
                          indicatorColor: transparentColor,
                          tabs: [
                            Tab(icon: Icon(Icons.dashboard)),
                            Tab(icon: Icon(Icons.favorite_border)),
                            Tab(icon: Icon(Icons.bookmark_border)),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    FadedSlideAnimation(
                      beginOffset: Offset(0, 0.3),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                      child: TabGridView(
                        food,
                        viewIcon: Icons.remove_red_eye,
                        onTap: () => {},
                      ),
                    ),
                    FadedSlideAnimation(
                      beginOffset: Offset(0, 0.3),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                      child: TabGridView(
                        dance,
                        icon: Icons.favorite,
                        onTap: () => {},
                      ),
                    ),
                    FadedSlideAnimation(
                      beginOffset: Offset(0, 0.3),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                      child: TabGridView(
                        lol,
                        icon: Icons.bookmark,
                        onTap: () => {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
