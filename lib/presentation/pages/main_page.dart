import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:ventro_fnb_app/core/routes/app_router.dart';

class MainPage extends StatefulWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final SidebarXController _controller =
      SidebarXController(selectedIndex: 0, extended: true);
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static const List<String> _paths = [
    AppRouter.cashierPath,
    AppRouter.searchPath,
    AppRouter.peoplePath,
    AppRouter.flutterPath,
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _indexFromLocation(String location) {
    for (var i = 0; i < _paths.length; i++) {
      if (location.startsWith(_paths[i])) {
        return i;
      }
    }
    return 0;
  }

  void _goTo(BuildContext context, int index, {bool closeDrawer = false}) {
    context.go(_paths[index]);
    if (closeDrawer && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = _indexFromLocation(location);

    if (_controller.selectedIndex != selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.selectIndex(selectedIndex);
        }
      });
    }

    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          key: _key,
          appBar: isSmallScreen
              ? AppBar(
                  title: const Text('Ventro FNB App'),
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      _key.currentState?.openDrawer();
                    },
                  ),
                )
              : null,
          drawer: _AppSidebar(
            controller: _controller,
            onNavigate: (index) => _goTo(context, index, closeDrawer: true),
          ),
          body: Row(
            children: [
              if (!isSmallScreen)
                _AppSidebar(
                  controller: _controller,
                  onNavigate: (index) => _goTo(context, index),
                ),
              Expanded(child: widget.child),
            ],
          ),
        );
      },
    );
  }
}

class _AppSidebar extends StatelessWidget {
  const _AppSidebar({
    required SidebarXController controller,
    required this.onNavigate,
  }) : _controller = controller;

  final SidebarXController _controller;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network('https://picsum.photos/200'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.point_of_sale,
          label: 'Cashier',
          onTap: () => onNavigate(0),
        ),
        SidebarXItem(
          icon: Icons.search,
          label: 'Search',
          onTap: () => onNavigate(1),
        ),
        SidebarXItem(
          icon: Icons.people,
          label: 'People',
          onTap: () => onNavigate(2),
        ),
        SidebarXItem(
          icon: Icons.favorite,
          label: 'Favorites',
          selectable: false,
        ),
        SidebarXItem(
          iconWidget: FlutterLogo(size: 20),
          label: 'Flutter',
          onTap: () => onNavigate(3),
        ),
      ],
    );
  }

}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);