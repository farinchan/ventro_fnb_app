import 'package:ventro_fnb_app/injection.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventro_fnb_app/core/routes/app_router.dart';
import 'package:ventro_fnb_app/core/styles/theme/app_theme.dart';
import 'package:ventro_fnb_app/presentation/bloc/bloc/table_list_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/cashier/cashier_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/category/category_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/login/login_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/outlet_list/outlet_list_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/sale_mode_list/sale_mode_list_bloc.dart';

void main() async {
  init();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginBloc>()),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>()..add(FetchProfile()),
        ),
        BlocProvider(create: (context) => getIt<OutletListBloc>()),
        BlocProvider(
          create: (context) => getIt<CategoryBloc>()..add(FetchCategories()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CashierBloc>()..add(const CashierLoadProducts()),
        ),
        BlocProvider(create: (context) => getIt<SaleModeListBloc>()),
        BlocProvider(create: (context) => getIt<TableListBloc>()),
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
