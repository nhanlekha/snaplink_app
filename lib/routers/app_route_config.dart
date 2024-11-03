import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snaplink_app/main.dart';
import 'package:snaplink_app/view/screens/camera/camera_screens.dart';
import 'package:snaplink_app/view/screens/login/login_screen.dart';
import 'package:snaplink_app/view/screens/main/main_screens.dart';
import 'package:snaplink_app/view/screens/post/up_post_screens.dart';
import 'package:snaplink_app/view/screens/register/register_screen.dart';
import 'package:snaplink_app/view/screens/splash/splash_screen.dart';

import 'app_route_constants.dart';

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: RouteConstants.mainRouteName,
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(child: SnapLinkMainApp());
          },
        ),
        GoRoute(
          name: RouteConstants.cameraRoute,
          path: '/camera',
          pageBuilder: (context, state) {
            return MaterialPage(child: CameraScreens());
          },
        ),

        GoRoute(
          name: RouteConstants.upPostRoute,
          path: '/up_post',
          pageBuilder: (context, state) {
            // Retrieve the `List<File>?` from the `extra` parameter
            final imagesList = state.extra as List<File>?;
            return MaterialPage(
              child: UpPostScreens(imagesList: imagesList),
            );
          },
        ),

        GoRoute(
          name: RouteConstants.signUpRoute,
          path: '/signup',
          pageBuilder: (context, state) {
            return MaterialPage(child: RegisterScreen());
          },
        ),
        GoRoute(
          name: RouteConstants.loginRoute,
          path: '/login',
          pageBuilder: (context, state) {
            return MaterialPage(child: LoginScreen());
          },
        ),
        GoRoute(
          name: RouteConstants.homeRouteName,
          path: '/home',
          pageBuilder: (context, state) {
            return MaterialPage(child: MainScreens());
          },
        ),
        // GoRoute(
        //   name: RouteConstants.profileRouteName,
        //   path: '/profile/:username/:userid',
        //   pageBuilder: (context, state) {
        //     return MaterialPage(
        //         child: Profile(
        //       userid: state.pathParameters['userid']!,
        //       username: state.pathParameters['username']!,
        //     ));
        //   },
        // ),
      ],
      errorPageBuilder: (context, state) {
        //page error
        return MaterialPage(child: Container());
      },
      // redirect: (context, state) {
      //   bool isAuth = true;
      //   if (!isAuth &&
      //       state.uri.toString()
      //           .startsWith('/${RouteConstants.profileRouteName}')) {
      //     return context.namedLocation(RouteConstants.contactUsRouteName);
      //   } else {
      //     return null;
      //   }
      // },
    );
    return router;
  }
}
