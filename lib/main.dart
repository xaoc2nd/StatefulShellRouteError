import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goroutertest/Search/Search.dart';
import 'package:goroutertest/model/user_model.dart';
import 'package:url_strategy/url_strategy.dart';

import 'Home/Home.dart';
import 'NavBars/BottomNavBar.dart';
import 'NavBars/NavRail.dart';
import 'Conversations/Conv.dart';
import 'Search/Search.dart';
import 'Profile/SearchProfileDetailsScreen.dart';
import 'Profile/SearchProfileTeamDetailsScreen.dart';

//private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorConvKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellConv');
final _shellNavigatorSearchKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
final _shellNavigatorAddKey = GlobalKey<NavigatorState>(debugLabel: 'shellAdd');

final goRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(
                    label: 'Home',
                    detailsPath: '/home/details',
                    convPath: '/home/conversations'),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                      const DetailsScreen(label: 'Home'),
                ),
                GoRoute(
                  //parentNavigatorKey: _rootNavigatorKey,
                  path: 'conversations',
                  pageBuilder: (context, state) => const NoTransitionPage(
                      child: ConvScreen(
                    label: 'Conversations',
                    detailsPath: 'conversations/details',
                  )),
                  routes: [
                    GoRoute(
                      path: 'details',
                      builder: (context, state) =>
                          const DetailsScreen(label: 'Conversations'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSearchKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/search',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SearchScreen(
                    label: 'Search',
                    profilePath: '/search/profile',
                    profileTeamPath: '/search/profileteampath'),
              ),
              routes: [
                GoRoute(
                  path: 'Profile',
                  builder: (context, state) =>
                      const SearchProfileDetailsScreen(label: 'Profile'),
                ),
                GoRoute(
                  path: 'ProfileTeam',
                  builder: (context, state) =>
                      const SearchProfileTeamDetailsScreen(
                          label: 'ProfileTeam'),
                )
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(
                    label: 'Profile', detailsPath: '/profile/details'),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                      const DetailsScreen(label: 'Profile'),
                ),
              ],
            ),
          ],
        ),
/*         StatefulShellBranch(
          navigatorKey: _shellNavigatorConvKey,
          routes: [
            // Shopping Cart
            GoRoute(
              //parentNavigatorKey: _rootNavigatorKey,
              path: '/conversations',
              pageBuilder: (context, state) => const NoTransitionPage(
                  child: ConvScreen(
                label: 'Conversations',
                detailsPath: '/conversations/details',
              )),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                      const DetailsScreen(label: 'Conversations'),
                ),
              ],
            ),
          ],
        ), */
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAddKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/publish',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(
                    label: 'Publish', detailsPath: '/publish/details'),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                      const DetailsScreen(label: 'Publish'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

void main() {
  // turn off the # in the URLs on the web

  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      print(navigationShell.currentIndex);
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }
    });
  }
}

//A definir dans d'autres fichiers

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Details for ${widget.label} - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/home');
                // setState(() {
                //   _counter++;
                // });
              },
              child: const Text('Back Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('$label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () => context.go(detailsPath),
              child: const Text('View details'),
            ),
          ],
        ),
      ),
    );
  }
}
