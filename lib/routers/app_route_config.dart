import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snaplink_app/main.dart';
import 'package:snaplink_app/view/screens/camera/camera_screens.dart';
import 'package:snaplink_app/view/screens/main/main_screens.dart';
import 'package:snaplink_app/view/screens/post/up_post_screens.dart';
import 'package:snaplink_app/view/screens/register/register_screen.dart';
import 'package:snaplink_app/view/screens/login/login_screen.dart';

import 'app_route_constants.dart';

class AppRouter {
  static GoRouter? _router;

  static GoRouter returnRouter() {
    _router ??= GoRouter(
      routes: [
        GoRoute(
          name: RouteConstants.mainRouteName,
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: SnapLinkMainApp());
          },
        ),
        GoRoute(
          name: RouteConstants.cameraRoute,
          path: '/camera',
          pageBuilder: (context, state) {
            return const MaterialPage(child: CameraScreens());
          },
        ),
        GoRoute(
          name: RouteConstants.upPostRoute,
          path: '/up_post',
          pageBuilder: (context, state) {
            // Lấy List<File>? từ tham số `extra`
            final imagesList = state.extra as List<File>?;
            return MaterialPage(
              child: UpPostScreens(imagesList: imagesList),
            );
          },
        ),
        GoRoute(
          name: RouteConstants.signUpRoute,
          path: '/sign-up',
          pageBuilder: (context, state) {
            return const MaterialPage(child: RegisterScreen());
          },
        ),
        GoRoute(
          name: RouteConstants.loginRoute,
          path: '/login',
          pageBuilder: (context, state) {
            return const MaterialPage(child: LoginScreen());
          },
        ),
        GoRoute(
          name: RouteConstants.homeRouteName,
          path: '/home',
          pageBuilder: (context, state) {
            return const MaterialPage(child: MainScreens());
          },
        ),
        GoRoute(
          name: RouteConstants.upSearchRoute,
          path: '/search',
          pageBuilder: (context, state) {
            return const MaterialPage(child: MainScreens());
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(child: Container());
      },
    );

    return _router!;
  }
}
