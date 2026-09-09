import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/experience_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/footer_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/hero_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/how_i_work_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/projects_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/why_choose_me_section.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final _footerKey = GlobalKey();

  void _scrollToFooter() {
    final footerContext = _footerKey.currentContext;
    if (footerContext == null) {
      return;
    }

    Scrollable.ensureVisible(
      footerContext,
      duration: const Duration(milliseconds: 850),
      curve: Curves.easeInOutCubic,
      alignment: 0.02,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeroSection(onGetInTouch: _scrollToFooter),
              const ExperienceSection(),
              const ProjectsSection(),
              const WhyChooseMeSection(),
              const HowIWorkSection(),
              FooterSection(key: _footerKey),
            ],
          ),
        ),
      ),
    );
  }
}
