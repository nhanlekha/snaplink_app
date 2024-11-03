import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snaplink_app/bloc/login/login_cubit.dart';
import 'package:snaplink_app/domans/auth_repo/auth_repo.dart';

import '../../../routers/app_route_constants.dart';
import '../../widgets/form_container_widget.dart';
import '../../widgets/toast_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const AppBarTitle(),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            final authRepo = context.read<AuthRepo>();
            return LoginCubit(authRepo: authRepo);
          },
          child: const LoginPage(),
        ),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _AppTitleText("Snap", Colors.blue),
        _AppTitleText("Link", Colors.green),
        _AppTitleText(" Project", Colors.amber),
      ],
    );
  }
}

class _AppTitleText extends StatelessWidget {
  final String text;
  final Color color;

  const _AppTitleText(this.text, this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSigning = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Đăng Nhập",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            FormContainerWidget(
              controller: _emailController,
              hintText: "Email",
              isPasswordField: false,
            ),
            const SizedBox(height: 10),
            FormContainerWidget(
              controller: _passwordController,
              hintText: "Mật Khẩu",
              isPasswordField: true,
            ),
            const SizedBox(height: 30),
            _buildSignInButton(),
            const SizedBox(height: 10),
            _buildGoogleSignInButton(),
            const SizedBox(height: 20),
            _buildSignUpLink(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: _isSigning ? null : _signIn,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: _isSigning
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  "Đăng Nhập",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return GestureDetector(
      onTap: _signInWithGoogle,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.ac_unit, color: Colors.white),
              SizedBox(width: 5),
              Text(
                "Đăng Nhập Bằng Google",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Bạn không có tài khoản?"),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pushNamed(RouteConstants.signUpRoute);
          },
          child: const Text(
            "Đăng ký",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.login(email, password);

    return;

    setState(() => _isSigning = true);

    if (!validateEmail(email)) {
      showToast(message: 'Email không hợp lệ');
      setState(() => _isSigning = false);
      return;
    }

    if (!validatePassword(password)) {
      showToast(message: 'Mật khẩu phải có ít nhất 6 ký tự');
      setState(() => _isSigning = false);
      return;
    }

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      showToast(message: 'Đăng nhập thành công');
    } catch (e) {
      showToast(message: 'Lỗi: $e');
    } finally {
      setState(() => _isSigning = false);
    }
  }

  bool validateEmail(String email) {
    final regex = RegExp(
        r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
    return regex.hasMatch(email);
  }

  bool validatePassword(String password) => password.length >= 6;

  Future<void> _signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      showToast(message: 'Lỗi: $e');
    }
  }
}
