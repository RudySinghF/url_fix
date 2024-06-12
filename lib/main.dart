import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('TabBar Demo'),
                bottom: TabBar(
                  tabs: const [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                  ],
                  onTap: (index) {
                    if (index == 0) {
                      GoRouter.of(context).go('/tab1');
                    } else if (index == 1) {
                      GoRouter.of(context).go('/tab2');
                    }
                  },
                ),
              ),
              body: TabBarView(
                children: [
                  // Content of Tab 1
                  tab1(),
                  // Content of Tab 2
                  tab2()
                ],
              ),
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) {
              return const MainApp();
            },
          ),
          GoRoute(
            path: '/tab1',
            builder: (context, state) {
              return tab1();
            },
          ),
          GoRoute(
            path: '/tab2',
            builder: (context, state) {
              return tab2();
            },
          )
        ])
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TabBar Demo',
      routerConfig: _router,
    );
  }
}

Widget tab1({
  BuildContext? context,
}) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Tab 1'),
    ),
    body: const Center(
      child: Text(
        'This is Tab 1',
      ),
    ),
  );
}

Widget tab2({
  BuildContext? context,
}) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Tab 2'),
    ),
    body: const Center(
      child: Text(
        'This is Tab 2',
      ),
    ),
  );
}
