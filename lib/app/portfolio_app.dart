import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/constants/app_strings.dart';
import 'package:portfolio_ahmad/core/routing/app_router.dart';
import 'package:portfolio_ahmad/core/theme/app_theme.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
