import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/pages/portfolio_home_page.dart';

abstract final class AppRouter {
  static const String home = '/';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => const PortfolioHomePage(),
    );
  }
}
