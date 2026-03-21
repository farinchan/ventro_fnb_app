import 'package:go_router/go_router.dart';
import 'package:ventro_fnb_app/presentation/pages/auth/login_page.dart';

class AppRouter {
  static const String loginPath = '/login';

  static final GoRouter router = GoRouter(
    // navigatorKey: _rootNavigatorKey,
    initialLocation: loginPath,
    // redirect: ((context, state) async {
      // var token = await LocalDataSource().getToken();
      // final isLoginPage = state.matchedLocation == LoginPage.routeName;
      // if (isLoginPage && token.isNotEmpty) {
      //   return HomePage.routeName;
      // } else if (!isLoginPage && token.isEmpty) {
      //   return LoginPage.routeName;
      // } else {
      //   return null;
      // }
    // }),
    routes: [
      GoRoute(
        path: loginPath,
        name: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}
