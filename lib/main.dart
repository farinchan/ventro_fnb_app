import 'package:ventro_fnb_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventro_fnb_app/core/routes/app_router.dart';
import 'package:ventro_fnb_app/core/styles/theme/app_theme.dart';
import 'package:ventro_fnb_app/presentation/bloc/login/login_bloc.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Localapak Merchant App',
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
