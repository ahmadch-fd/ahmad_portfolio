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
      badge: '30% faster development',
      description: 'MVP-ready Flutter apps with clean architecture, responsive UI, and practical delivery speed.',
      icon: Icons.rocket_launch_rounded,
      accent: Color(0xFF19A7FF),
    ),
    _Reason(
      title: 'Production Ready',
      badge: 'Built to scale',
      description: 'Apps structured for real users with Firebase, API integrations, caching, and stable releases.',
      icon: Icons.shield_rounded,
      accent: Color(0xFFE24DD8),
    ),
    _Reason(
      title: 'Quality First',
      badge: 'Maintainable by anyone',
      description: 'Reusable widgets, readable code, focused debugging, and patterns that keep projects easy to grow.',
      icon: Icons.local_fire_department_rounded,
      accent: Color(0xFFFF6A2A),
    ),
    _Reason(
      title: 'Full-Stack Thinking',
      badge: 'No delays',
      description: 'I understand frontend, backend, Firebase, REST APIs, Play Console flow, and complete app delivery.',
      icon: Icons.check_circle_rounded,
      accent: Color(0xFF16D486),
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
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 112),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            children: [
              Text(
                'WHY CHOOSE ME',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFF29B6F6),
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.2,
                ),
              ),
              const SizedBox(height: 16),
              const _Headline(),
              const SizedBox(height: 58),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final columnCount = width >= 760 ? 2 : 1;
                  final spacing = columnCount == 1 ? 18.0 : 28.0;
                  final cardWidth =
                      (width - spacing * (columnCount - 1)) / columnCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 28,
                    children: [
                      for (var index = 0; index < _reasons.length; index++)
                        _StaggeredReasonCard(
                          animation: _controller,
                          index: index,
                          width: cardWidth,
                          reason: _reasons[index],
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

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.displayLarge?.copyWith(
      fontSize: 38,
      fontWeight: FontWeight.w900,
      height: 1.22,
      letterSpacing: 0,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: style,
        children: const [
          TextSpan(text: "I'm not just a "),
          TextSpan(
            text: 'developer.',
            style: TextStyle(color: Color(0xFF29B6F6)),
          ),
          TextSpan(text: " I'm your "),
          TextSpan(
            text: 'technical partner.',
            style: TextStyle(color: Color(0xFF29B6F6)),
          ),
        ],
      ),
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
    final start = index * 0.1;
    final cardAnimation = CurvedAnimation(
      parent: animation,
      curve: Interval(start, 1, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (context, child) {
        final value = cardAnimation.value;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 34),
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
    final hoverSurface = Color.lerp(
      const Color(0xFF151B2E),
      reason.accent,
      0.12,
    )!;

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
              color: _isHovered ? hoverSurface : const Color(0xFF151B2E),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isHovered
                    ? reason.accent
                    : const Color(0xFF1A6B90).withValues(alpha: 0.58),
              ),
              boxShadow: [
                BoxShadow(
                  color: reason.accent.withValues(alpha: _isHovered ? 0.22 : 0),
                  blurRadius: _isHovered ? 34 : 0,
                  spreadRadius: _isHovered ? 1 : 0,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 160),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    width: 42,
                    height: 42,
                    duration: const Duration(milliseconds: 260),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isHovered
                            ? [reason.accent, AppColors.primary]
                            : [
                                reason.accent,
                                reason.accent.withValues(alpha: 0.82),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(reason.icon, color: Colors.white, size: 22),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    reason.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.foreground,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: reason.accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(
                        reason.badge,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: reason.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    reason.description,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: const Color(0xFFE5E7EB), height: 1.6),
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
