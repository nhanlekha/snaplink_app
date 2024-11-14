import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:snaplink_app/app/app_cubit.dart';

import '../../../routers/app_route_constants.dart';
import '../../../ultils/enums/auth_status.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    final state = context.read<AppCubit>().state;
    switch (state.authStatus) {
      case AuthStatus.unknown:
        GoRouter.of(context).pushNamed(RouteConstants.loginRoute);
        break;
      case AuthStatus.unauthenticated:
        GoRouter.of(context).pushNamed(RouteConstants.loginRoute);
        break;
      case AuthStatus.authenticated:
        GoRouter.of(context).pushNamed(RouteConstants.homeRouteName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF69A7FF), // Màu đầu tiên
                Color(0xFF3A7BD5), // Màu thứ hai
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0], // Điều chỉnh độ lan tỏa của gradient
            ),
          ),
          child: AnimatedSplashScreen(
            splash: Column(
              children: [
                Center(
                  child: LottieBuilder.asset(
                    "assets/lottie/Animation - 1731243996054.json",
                  ),
                ),
              ],
            ),
            duration: 1000,
            splashIconSize: 550,
            nextScreen: Container(),
          ),
        ),
      ),
    );
  }
}
