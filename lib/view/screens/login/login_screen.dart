import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_cubit.dart';
import '../../../bloc/login/login_cubit.dart';
import '../../../domans/auth_repo/auth_repo.dart';
import '../../../routers/app_route_constants.dart';
import '../../../ultils/enums/auth_status.dart';
import '../../components/theme/colors.dart';
import '../../components/widget_custom/continue_button.dart';
import '../../components/widget_custom/entry_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) {
          final authRepo = context.read<AuthRepo>();
          return LoginCubit(authRepo: authRepo);
        },
        child: const LoginBody(),
      )),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: transparentColor),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(16.0),
      child: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "youWillNeed".tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: secondaryColor),
            ),
            const Spacer(),
            EntryField(
              controller: _emailController,
              label: "enterPhone".tr(),
            ),
            EntryField(
              controller: _passwordController,
              label: "password".tr(),
            ),
            CustomButton(
                onPressed: () => {
                      // _login()
                      context.go('/test')
                    }),
            const Spacer(flex: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Add your click event code here
                    context.go('/sign-up');
                  },
                  child: Text(
                    "signUpNow".tr(),
                    style: const TextStyle(color: Colors.indigoAccent),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  style: const TextStyle(color: Colors.white),
                  " ${"orContinueWith".tr()}",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              icon: Image.asset(
                'assets/icons/ic_fb.png',
                height: 20,
              ),
              text: 'facebookAccount'.tr(),
              color: fbColor,
              onPressed: () => {},
            ),
            CustomButton(
              icon: Image.asset(
                'assets/icons/ic_ggl.png',
                height: 20,
              ),
              text: 'googleAccount'.tr(),
              color: secondaryColor,
              textColor: darkColor,
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.login(email, password);

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
}
