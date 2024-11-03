import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snaplink_app/view/screens/chat/page_chat/chat_screens.dart';
import 'package:snaplink_app/view/screens/post/up_post_screens.dart';

import '../../../routers/app_route_constants.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  List<Widget> _pages = [];
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      Container(color: Colors.amberAccent),
      ChatScreens(),
      Container(color: Colors.green),
      UpPostScreens(),
      Container(color: Colors.amberAccent),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (index) {
          if (index != 2) {
            setState(() {
              _currentPage = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home.png',
              width: 24,
              height: 24,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/instagram-live.png',
              width: 24,
              height: 24,
            ),
            label: "Live",
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/notification.png',
              width: 24,
              height: 24,
            ),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/user.png',
              width: 24,
              height: 24,
            ),
            label: "Cá Nhân",
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.orangeAccent,
              Colors.yellowAccent
            ],
            // Màu bắt đầu và kết thúc của gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: IconButton(
          onPressed: () {
            GoRouter.of(context).pushNamed(RouteConstants.cameraRoute);
          },
          icon: Image.asset(
            'assets/images/camera.png',
            width: 24,
            height: 24,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
