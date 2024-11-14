import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snaplink_app/app/app_cubit.dart';
import 'package:snaplink_app/app/app_state.dart';
import 'package:snaplink_app/routers/app_route_config.dart';
import 'package:snaplink_app/routers/app_route_constants.dart';
import 'package:snaplink_app/ultils/enums/auth_status.dart';
import 'package:snaplink_app/view/screens/camera/camera_screens.dart';
import 'package:snaplink_app/view/screens/login/login_screen.dart';
import 'package:snaplink_app/view/screens/main/main_screens.dart';
import 'package:snaplink_app/view/screens/register/register_screen.dart';
import 'package:snaplink_app/view/screens/splash/splash_screen.dart';
import 'domans/auth_repo/auth_repo.dart';
import 'domans/auth_repo/impl/auth_repo_impl.dart';
import 'domans/data_source/impl/firebase_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("vi"), Locale("en")],
      path: "assets/translations",
      child: const SnapLinkApp(),
    ),
  );
}

class SnapLinkApp extends StatefulWidget {
  const SnapLinkApp({super.key});

  @override
  State<SnapLinkApp> createState() => _SnapLinkAppState();
}

class _SnapLinkAppState extends State<SnapLinkApp> {
  late final AuthRepo _authRepo;
  late final FirebaseAuthService _firebaseAuthService;

  @override
  void initState() {
    super.initState();
    // Initializing
    _firebaseAuthService = FirebaseAuthService();
    _authRepo = AuthRepoImpl(firebaseAuthService: _firebaseAuthService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(authRepo: _authRepo),
        )
      ],
      child: const SnapLinkRouter(),
    );
  }
}

class SnapLinkRouter extends StatelessWidget {
  const SnapLinkRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.returnRouter(),
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
    );
  }
}

class SnapLinkMainApp extends StatelessWidget {
  const SnapLinkMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        switch (state.authStatus) {
          case AuthStatus.unknown:
          case AuthStatus.unauthenticated:
            GoRouter.of(context).pushNamed(RouteConstants.loginRoute);
            break;
          case AuthStatus.authenticated:
            GoRouter.of(context).pushNamed(RouteConstants.homeRouteName);
            break;
        }
      },
      child: const SplashScreen(),
    );
  }
}
