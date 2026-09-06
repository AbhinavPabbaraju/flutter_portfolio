import 'package:flutter/material.dart';

import 'core/layout.dart';
import 'core/routes.dart';
import 'data/profile.dart';
import 'pages/about_page.dart';
import 'pages/home_page.dart';
import 'pages/projects_page.dart';
import 'theme/app_theme.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Profile.name,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      initialRoute: Routes.home,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  /// Every page is a named route, so the nav, the buttons and the browser
  /// address bar all agree on where you are.
  static Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final Widget page = switch (settings.name) {
      Routes.about => const AboutPage(),
      Routes.work => const ProjectsPage(),
      _ => const HomePage(),
    };

    return PageRouteBuilder<void>(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, _, child) {
        // One quiet crossfade with a few pixels of travel. Anyone who has
        // asked their system to reduce motion gets neither.
        if (prefersReducedMotion(context)) return child;

        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.015),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
