import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/register/register_cubit.dart';
import '../../../domans/auth_repo/auth_repo.dart';
import '../../../model/user_model.dart';
import '../../components/theme/colors.dart';
import '../../components/widget_custom/continue_button.dart';
import '../../components/widget_custom/entry_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) {
          final authRepo = context.read<AuthRepo>();
          return RegisterCubit(authRepo: authRepo);
        },
        child: RegisterBody(),
      )),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  _RegisterBodyBodyState createState() => _RegisterBodyBodyState();
}

class _RegisterBodyBodyState extends State<RegisterBody> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
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
            Spacer(),
            EntryField(
              controller: _nameController,
              label: "fullName".tr(),
            ),
            EntryField(
              controller: _emailController,
              label: "enterPhone".tr(),
            ),
            EntryField(
              controller: _passwordController,
              label: "password".tr(),
            ),
            CustomButton(onPressed: () => {_signIn()}),
            const Spacer(flex: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Add your click event code here
                    context.go('/login');
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

  Future<void> _signIn() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    UserModel userModel =
        UserModel(id: "", name: name, email: email, avatar: "", pass: password);
    registerCubit.register(userModel);

    context.go('/login');
  }
}
