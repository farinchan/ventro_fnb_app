import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventro_fnb_app/data/datasources/local_datasource.dart';
import 'package:ventro_fnb_app/domain/entities/category_entity.dart';
import 'package:ventro_fnb_app/domain/entities/coupon_entity.dart';
import 'package:ventro_fnb_app/domain/entities/product_entity.dart';
import 'package:ventro_fnb_app/domain/entities/sale_mode_entity.dart';
import 'package:ventro_fnb_app/domain/entities/tax_entity.dart';
import 'package:ventro_fnb_app/domain/entities/user_entity.dart';
import 'package:ventro_fnb_app/presentation/bloc/cashier/cashier_bloc.dart';
import 'package:ventro_fnb_app/presentation/pages/auth/login_page.dart';
import 'package:ventro_fnb_app/presentation/pages/auth/select_outlet_page.dart';
import 'package:ventro_fnb_app/presentation/pages/common/placeholder_content_page.dart';
import 'package:ventro_fnb_app/presentation/pages/main_page.dart';
import 'package:ventro_fnb_app/presentation/pages/pos/cashier_page.dart';
import 'package:ventro_fnb_app/presentation/pages/pos/process_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    redirect: ((context, state) async {
      final token = await LocalDatasource().getToken();
      final outletId = await LocalDatasource().getOutletId();
      final staffOutletId = await LocalDatasource().getStaffOutletId();

      final isLoggingIn = state.matchedLocation == '/login';
      final isSelectingOutlet = state.matchedLocation == '/select-outlet';

      if (token == null) {
        return isLoggingIn ? null : '/login';
      }

      if (outletId == null) {
        return isSelectingOutlet ? null : '/login';
      }

      if (isLoggingIn || isSelectingOutlet) {
        return '/cashier';
      }

      return null;
    }),
    routes: [
      GoRoute(
        path: '/login',
        name: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/select-outlet',
        name: SelectOutletPage.routeName,
        builder: (context, state) {
          final user = state.extra as UserEntity;
          return SelectOutletPage(user: user);
        },
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: '/cashier',
            name: CashierPage.routeName,
            builder: (context, state) {
              return CashierPage();
            },
            routes: [
              GoRoute(
                path: '/process',
                name: ProcessPage.routeName,
                builder: (context, state) {
                  final cashierState = state.extra as CashierState;
                  return ProcessPage(cashierState: cashierState);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/search',
            name: 'search',
            builder: (context, state) =>
                const PlaceholderContentPage(title: 'Search Page'),
          ),
          GoRoute(
            path: '/people',
            name: 'people',
            builder: (context, state) =>
                const PlaceholderContentPage(title: 'People Page'),
          ),
          GoRoute(
            path: '/flutter',
            name: 'flutter',
            builder: (context, state) =>
                const PlaceholderContentPage(title: 'Flutter Page'),
          ),
        ],
      ),
    ],
  );
}
