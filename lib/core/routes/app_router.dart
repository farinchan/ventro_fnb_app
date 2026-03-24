import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventro_fnb_app/data/datasources/local_datasource.dart';
import 'package:ventro_fnb_app/presentation/pages/auth/login_page.dart';
import 'package:ventro_fnb_app/presentation/pages/auth/select_outlet_page.dart';
import 'package:ventro_fnb_app/presentation/pages/common/placeholder_content_page.dart';
import 'package:ventro_fnb_app/presentation/pages/main_page.dart';
import 'package:ventro_fnb_app/presentation/pages/pos/cashier_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static const String loginPath = '/login';
  static const String selectOutletPath = '/select-outlet';
  static const String cashierPath = '/cashier';
  static const String searchPath = '/search';
  static const String peoplePath = '/people';
  static const String flutterPath = '/flutter';

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: loginPath,
    redirect: ((context, state) async {
      final token = await LocalDatasource().getToken();
      final outletId = await LocalDatasource().getOutletId();

      final isLoggingIn = state.matchedLocation == loginPath;
      final isSelectingOutlet = state.matchedLocation == selectOutletPath;

      if (token == null) {
        return isLoggingIn ? null : loginPath;
      }

      if (outletId == null) {
        return isSelectingOutlet ? null : selectOutletPath;
      }

      if (isLoggingIn || isSelectingOutlet) {
        return cashierPath;
      }

      return null;
    }),
    routes: [
      GoRoute(
        path: loginPath,
        name: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: selectOutletPath,
        name: SelectOutletPage.routeName,
        builder: (context, state) => const SelectOutletPage(),
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: cashierPath,
            name: CashierPage.routeName,
            builder: (context, state) => CashierPage(),
          ),
          GoRoute(
            path: searchPath,
            name: 'search',
            builder: (context, state) =>
                const PlaceholderContentPage(title: 'Search Page'),
          ),
          GoRoute(
            path: peoplePath,
            name: 'people',
            builder: (context, state) =>
                const PlaceholderContentPage(title: 'People Page'),
          ),
          GoRoute(
            path: flutterPath,
            name: 'flutter',
            builder: (context, state) =>
                const PlaceholderContentPage(title: 'Flutter Page'),
          ),
        ],
      ),
    ],
  );
}
