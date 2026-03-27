import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ventro_fnb_app/core/routes/app_router.dart';
import 'package:ventro_fnb_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:ventro_fnb_app/presentation/pages/pos/cashier_page.dart';

class MainPage extends StatefulWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.message ?? 'Error')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: widget.child,
          appBar: AppBar(
            title: Row(
              children: [
                Icon(Icons.store, size: 40),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state is ProfileLoaded
                        ? Text(
                            state.outlet?.name ?? '-',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Text('No Outlet'),
                    Row(
                      children: [
                        state is ProfileLoaded
                            ? Text(
                                state.user?.name ?? '-',
                                style: TextStyle(fontSize: 12),
                              )
                            : Text('No User'),
                        Text(' | '),
                        state is ProfileLoaded
                            ? Text(
                                state.user?.role ?? '-',
                                style: TextStyle(fontSize: 12),
                              )
                            : Text('No Role'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 12),
                  Text(
                    DateFormat(
                      'EEEE, dd MMM yyyy',
                      'id_ID',
                    ).format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(width: 12),
                ],
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          state is ProfileLoaded
                              ? state.outlet?.business?.logo ?? ''
                              : '',
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        state is ProfileLoaded ? state.outlet?.name ?? '' : '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        state is ProfileLoaded
                            ? state.outlet?.business?.name ?? ''
                            : '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            state is ProfileLoaded
                                ? state.user?.name ?? ''
                                : '',
                          ),
                          subtitle: Text(
                            state is ProfileLoaded
                                ? state.user?.role ?? ''
                                : '',
                          ),
                          titleTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          subtitleTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              state is ProfileLoaded
                                  ? state.user?.photo ?? ''
                                  : '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: ListView(
                      children: [
                        ListTile(
                          selected: _selectedIndex == 0,
                          selectedTileColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.3),
                          title: const Text('Cashier'),
                          onTap: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                            context.goNamed(CashierPage.routeName);
                          },
                          leading: Icon(Icons.point_of_sale),
                          trailing: Icon(Icons.arrow_forward_ios, size: 12),
                        ),
                        ListTile(
                          title: const Text('Riwayat penjualan'),
                          selected: _selectedIndex == 1,
                          selectedTileColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.3),
                          onTap: () {
                            setState(() {
                              _selectedIndex = 1;
                            });
                            context.goNamed('search');
                          },
                        ),
                        ListTile(
                          title: const Text('Pembukuan'),
                          selected: _selectedIndex == 2,
                          selectedTileColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.3),
                          onTap: () {
                            setState(() {
                              _selectedIndex = 2;
                            });
                            context.goNamed('people');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
