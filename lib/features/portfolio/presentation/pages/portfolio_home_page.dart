import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/experience_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/footer_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/hero_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/how_i_work_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/projects_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/sections/why_choose_me_section.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/widgets/site_header.dart';
import 'package:portfolio_ahmad/features/portfolio/presentation/widgets/whatsapp_fab.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final _scrollController = ScrollController();
  final _heroKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _footerKey = GlobalKey();

  String _activeSection = 'Home';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    final key = switch (section) {
      'Home' => _heroKey,
      'Experience' => _experienceKey,
      'Projects' => _projectsKey,
      'Contact' => _footerKey,
      _ => _heroKey,
    };

    final ctx = key.currentContext;
    if (ctx == null) return;

    setState(() => _activeSection = section);

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
      alignment: section == 'Home' ? 0.0 : 0.04,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const WhatsAppFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          // Scrollable content (top padding = nav height)
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 70), // nav bar height
                  HeroSection(
                    key: _heroKey,
                    onGetInTouch: () => _scrollToSection('Contact'),
                  ),
                  ExperienceSection(key: _experienceKey),
                  ProjectsSection(key: _projectsKey),
                  const WhyChooseMeSection(),
                  const HowIWorkSection(),
                  FooterSection(key: _footerKey),
                ],
              ),
            ),
          ),

          // Sticky glass nav pinned to top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SiteHeader(
              onSectionTap: _scrollToSection,
              activeSection: _activeSection,
            ),
          ),
        ],
      ),
    );
  }
}
