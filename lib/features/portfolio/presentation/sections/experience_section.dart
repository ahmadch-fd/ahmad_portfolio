import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const _experiences = [
    _WorkExperience(
      company: 'Code Thinker',
      role: 'Flutter Mobile Application Developer',
      duration: '6 months',
      period: 'Mar 2026 - Aug 2026',
      logoPath: 'assets/images/codethinkers.png',
      description: 'Worked on Flutter mobile application features, polished responsive UI flows, integrated REST APIs, and collaborated on production-ready app improvements. I focused on clean screens, reusable widgets, and practical fixes that improved the overall mobile experience.',
    ),
    _WorkExperience(
      company: 'Innovista',
      role: 'Flutter Developer Intern',
      duration: '4 months',
      period: 'Sep 2025 - Feb 2026',
      logoPath: 'assets/images/innovista.png',
      description: 'Gained hands-on internship experience building Flutter interfaces, learning project structure, debugging UI issues, and supporting app development tasks. I strengthened my understanding of mobile development workflows, API handling, and team collaboration.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 96),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'EXPERIENCE',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 46),
              for (final experience in _experiences) ...[
                _ExperienceTile(experience: experience),
                if (experience != _experiences.last) const SizedBox(height: 40),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkExperience {
  const _WorkExperience({
    required this.company,
    required this.role,
    required this.duration,
    required this.period,
    required this.logoPath,
    required this.description,
  });

  final String company;
  final String role;
  final String duration;
  final String period;
  final String logoPath;
  final String description;
}

class _ExperienceTile extends StatelessWidget {
  const _ExperienceTile({required this.experience});

  final _WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 650;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isCompact)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ExperienceTitle(experience: experience),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 62),
                    child: _ExperiencePeriod(experience: experience),
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _ExperienceTitle(experience: experience)),
                  const SizedBox(width: 24),
                  _ExperiencePeriod(experience: experience),
                ],
              ),
            const SizedBox(height: 18),
            Padding(
              padding: EdgeInsets.only(left: isCompact ? 0 : 62),
              child: Text(
                experience.description,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.muted,
                  height: 1.65,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ExperienceTitle extends StatelessWidget {
  const _ExperienceTitle({required this.experience});

  final _WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CompanyLogo(path: experience.logoPath),
        const SizedBox(width: 18),
        Expanded(
          child: Text(
            '${experience.role} at ${experience.company}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.foreground,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _ExperiencePeriod extends StatelessWidget {
  const _ExperiencePeriod({required this.experience});

  final _WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${experience.period} | ${experience.duration}',
      style: Theme.of(context).textTheme.bodyMedium
          ?.copyWith(color: AppColors.muted, fontWeight: FontWeight.w500),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
