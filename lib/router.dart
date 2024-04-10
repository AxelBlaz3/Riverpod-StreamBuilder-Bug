import 'package:go_router/go_router.dart';
import 'package:riverpod_streambuilder_bug/features/accounts/pages/accounts_page.dart';
import 'package:riverpod_streambuilder_bug/features/home/pages/home_page.dart';

final router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    routes: <RouteBase>[
      GoRoute(
        path: 'accounts',
        builder: (context, state) => const AccountsPage(),
      )
    ],
    builder: (context, state) => const HomePage(),
  )
]);
