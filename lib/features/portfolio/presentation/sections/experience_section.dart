import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
    with SingleTickerProviderStateMixin {
  static const _experiences = [
    _WorkExperience(
      company: 'Codes Thinker',
      role: 'Flutter Mobile Application Developer',
      duration: '6 months',
      period: 'Mar 2026 – Aug 2026',
      logoPath: 'assets/images/codethinkers.png',
      description: 'Worked on Flutter mobile application features, polished responsive UI flows, integrated REST APIs, and collaborated on production-ready app improvements. Focused on clean screens, reusable widgets, and practical fixes that improved the overall mobile experience.',
      accent: AppColors.accentCyan,
    ),
    _WorkExperience(
      company: 'Innovista',
      role: 'Flutter Developer Intern',
      duration: '4 months',
      period: 'Sep 2025 – Feb 2026',
      logoPath: 'assets/images/innovista.png',
      description: 'Gained hands-on internship experience building Flutter interfaces, learning project structure, debugging UI issues, and supporting app development tasks. Strengthened understanding of mobile development workflows, API handling, and team collaboration.',
      accent: AppColors.accent,
    ),
  ];

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionHeader(
                label: 'EXPERIENCE',
                title: 'Work Experience',
                accent: AppColors.accentCyan,
              ),
              const SizedBox(height: 52),
              for (var i = 0; i < _experiences.length; i++) ...[
                _StaggeredExperienceTile(
                  animation: _controller,
                  index: i,
                  experience: _experiences[i],
                  isLast: i == _experiences.length - 1,
                ),
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
    required this.accent,
  });

  final String company;
  final String role;
  final String duration;
  final String period;
  final String logoPath;
  final String description;
  final Color accent;
}

class _StaggeredExperienceTile extends StatelessWidget {
  const _StaggeredExperienceTile({
    required this.animation,
    required this.index,
    required this.experience,
    required this.isLast,
  });

  final Animation<double> animation;
  final int index;
  final _WorkExperience experience;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final start = (index * 0.22).clamp(0.0, 0.6);
    final cardAnimation = CurvedAnimation(
      parent: animation,
      curve: Interval(start, 1, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (context, child) {
        final v = cardAnimation.value;
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, (1 - v) * 40),
            child: child,
          ),
        );
      },
      child: Stack(
        children: [
          if (!isLast)
            Positioned(
              left: 19,
              top: 36,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      experience.accent.withValues(alpha: 0.5),
                      AppColors.glassBorder,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                child: Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Center(
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: experience.accent.withValues(alpha: 0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 36),
                  child: _ExperienceCard(experience: experience),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard({required this.experience});
  final _WorkExperience experience;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: _isHovered
              ? Color.lerp(AppColors.surfaceCard, exp.accent, 0.06)
              : AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isHovered
                ? exp.accent.withValues(alpha: 0.6)
                : AppColors.cardBorder,
          ),
          boxShadow: [
            BoxShadow(
              color: exp.accent.withValues(alpha: _isHovered ? 0.18 : 0),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 560;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isCompact)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ExperienceHeader(experience: exp),
                      const SizedBox(height: 10),
                      _PeriodChip(experience: exp),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _ExperienceHeader(experience: exp)),
                      const SizedBox(width: 16),
                      _PeriodChip(experience: exp),
                    ],
                  ),
                const SizedBox(height: 18),
                Text(
                  exp.description,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: AppColors.muted, height: 1.7),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ExperienceHeader extends StatelessWidget {
  const _ExperienceHeader({required this.experience});
  final _WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Image.asset(
            experience.logoPath,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                experience.role,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.foreground,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                experience.company,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: experience.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PeriodChip extends StatelessWidget {
  const _PeriodChip({required this.experience});
  final _WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: experience.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: experience.accent.withValues(alpha: 0.3)),
      ),
      child: Text(
        '${experience.period}  ·  ${experience.duration}',
        style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: experience.accent, fontSize: 11),
      ),
    );
  }
}

// ── Shared Section Header ─────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.label,
    required this.title,
    required this.accent,
  });

  final String label;
  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: accent.withValues(alpha: 0.4)),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(color: accent, letterSpacing: 2.5, fontSize: 11),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
      ],
    );
  }
}
