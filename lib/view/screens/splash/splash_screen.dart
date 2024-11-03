import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snaplink_app/app/app_cubit.dart';
import 'package:snaplink_app/app/app_state.dart';

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
    // Đợi 5 giây
    await Future.delayed(const Duration(seconds: 1));

    final state = context.read<AppCubit>().state;

    // Kiểm tra trạng thái xác thực và điều hướng tương ứng
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
      backgroundColor: Colors.blue, // Màu nền
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo của ứng dụng
            Image.asset(
              'assets/images/home.png', // Đường dẫn đến logo
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            // Tên ứng dụng
            const Text(
              'Social App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(
              color: Colors.white,
            ), // Vòng tròn loading
          ],
        ),
      ),
    );
  }
}
