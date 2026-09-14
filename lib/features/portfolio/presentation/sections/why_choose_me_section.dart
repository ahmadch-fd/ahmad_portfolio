import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';

class WhyChooseMeSection extends StatefulWidget {
  const WhyChooseMeSection({super.key});

  @override
  State<WhyChooseMeSection> createState() => _WhyChooseMeSectionState();
}

class _WhyChooseMeSectionState extends State<WhyChooseMeSection>
    with SingleTickerProviderStateMixin {
  static const _reasons = [
    _Reason(
      title: 'Startup Speed',
      badge: '30% faster delivery',
      description: 'MVP-ready Flutter apps with clean architecture, responsive UI, and practical delivery speed.',
      icon: Icons.rocket_launch_rounded,
      accent: Color(0xFF06B6D4),
    ),
    _Reason(
      title: 'Production Ready',
      badge: 'Built to scale',
      description: 'Apps structured for real users with Firebase, API integrations, caching, and stable releases.',
      icon: Icons.shield_rounded,
      accent: Color(0xFF8B5CF6),
    ),
    _Reason(
      title: 'Quality First',
      badge: 'Maintainable code',
      description: 'Reusable widgets, readable code, focused debugging, and patterns that keep projects easy to grow.',
      icon: Icons.local_fire_department_rounded,
      accent: Color(0xFFFF6B6B),
    ),
    _Reason(
      title: 'Full-Stack Thinking',
      badge: 'End-to-end delivery',
      description: 'I understand frontend, backend, Firebase, REST APIs, Play Console flow, and complete app delivery.',
      icon: Icons.check_circle_rounded,
      accent: Color(0xFF10B981),
    ),
  ];

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
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
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            children: [
              _WhyChooseHeader(),
              const SizedBox(height: 60),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final columnCount = width >= 760 ? 2 : 1;
                  final spacing = 24.0;
                  final cardWidth =
                      (width - spacing * (columnCount - 1)) / columnCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (var i = 0; i < _reasons.length; i++)
                        _StaggeredReasonCard(
                          animation: _controller,
                          index: i,
                          width: cardWidth,
                          reason: _reasons[i],
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhyChooseHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
          ),
          child: Text(
            'WHY CHOOSE ME',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.accent,
              letterSpacing: 2.5,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(height: 18),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.2,
              letterSpacing: -0.5,
            ),
            children: const [
              TextSpan(text: "I'm not just a "),
              TextSpan(
                text: 'developer.',
                style: TextStyle(color: AppColors.accentCyan),
              ),
              TextSpan(text: "\nI'm your "),
              TextSpan(
                text: 'technical partner.',
                style: TextStyle(color: AppColors.accentCyan),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Reason {
  const _Reason({
    required this.title,
    required this.badge,
    required this.description,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String badge;
  final String description;
  final IconData icon;
  final Color accent;
}

class _StaggeredReasonCard extends StatelessWidget {
  const _StaggeredReasonCard({
    required this.animation,
    required this.index,
    required this.width,
    required this.reason,
  });

  final Animation<double> animation;
  final int index;
  final double width;
  final _Reason reason;

  @override
  Widget build(BuildContext context) {
    final start = index * 0.12;
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
            offset: Offset(0, (1 - v) * 34),
            child: child,
          ),
        );
      },
      child: _ReasonCard(width: width, reason: reason),
    );
  }
}

class _ReasonCard extends StatefulWidget {
  const _ReasonCard({required this.width, required this.reason});
  final double width;
  final _Reason reason;

  @override
  State<_ReasonCard> createState() => _ReasonCardState();
}

class _ReasonCardState extends State<_ReasonCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final reason = widget.reason;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.025 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: SizedBox(
          width: widget.width,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: _isHovered
                  ? Color.lerp(AppColors.surfaceCard, reason.accent, 0.08)
                  : AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? reason.accent.withValues(alpha: 0.7)
                    : AppColors.cardBorder,
              ),
              boxShadow: [
                BoxShadow(
                  color: reason.accent.withValues(alpha: _isHovered ? 0.22 : 0),
                  blurRadius: 34,
                  spreadRadius: 1,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon container with gradient
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _isHovered
                            ? [reason.accent, AppColors.accent]
                            : [
                                reason.accent.withValues(alpha: 0.9),
                                reason.accent.withValues(alpha: 0.6),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: reason.accent.withValues(
                            alpha: _isHovered ? 0.4 : 0.15,
                          ),
                          blurRadius: _isHovered ? 20 : 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(reason.icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    reason.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.foreground,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: reason.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: reason.accent.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      reason.badge,
                      style: Theme.of(context).textTheme.labelMedium
                          ?.copyWith(color: reason.accent, fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    reason.description,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: AppColors.muted, height: 1.65),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
