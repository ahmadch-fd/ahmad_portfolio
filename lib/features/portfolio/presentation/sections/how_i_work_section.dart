import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';

class HowIWorkSection extends StatefulWidget {
  const HowIWorkSection({super.key});

  @override
  State<HowIWorkSection> createState() => _HowIWorkSectionState();
}

class _HowIWorkSectionState extends State<HowIWorkSection>
    with SingleTickerProviderStateMixin {
  static const _steps = [
    _WorkStep(
      number: '01',
      title: 'Discovery',
      description: 'Deep dive into your business needs, user pain points, and technical requirements.',
      icon: Icons.explore_rounded,
      accent: Color(0xFF06B6D4),
    ),
    _WorkStep(
      number: '02',
      title: 'Architecture',
      description: 'Design scalable systems with clean separation of concerns and a clear growth roadmap.',
      icon: Icons.architecture_rounded,
      accent: Color(0xFF8B5CF6),
    ),
    _WorkStep(
      number: '03',
      title: 'Development',
      description: 'Rapid iteration with daily demos, feedback loops, and flexible improvements.',
      icon: Icons.code_rounded,
      accent: Color(0xFFFF6B6B),
    ),
    _WorkStep(
      number: '04',
      title: 'Launch & Scale',
      description: 'Performance optimization, monitoring, analytics, and stable release support.',
      icon: Icons.rocket_launch_rounded,
      accent: Color(0xFF10B981),
    ),
  ];

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
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
              // Section header
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      'PROCESS',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 2.5,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'How I Work',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final columnCount = width >= 980
                      ? 4
                      : width >= 640
                      ? 2
                      : 1;
                  final spacing = 22.0;
                  final cardWidth =
                      (width - spacing * (columnCount - 1)) / columnCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (var i = 0; i < _steps.length; i++)
                        _AnimatedStepCard(
                          animation: _controller,
                          index: i,
                          width: cardWidth,
                          step: _steps[i],
                          showConnector:
                              columnCount == 4 && i < _steps.length - 1,
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 72),
              Divider(color: AppColors.glassBorder, height: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkStep {
  const _WorkStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.accent,
  });

  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Color accent;
}

class _AnimatedStepCard extends StatelessWidget {
  const _AnimatedStepCard({
    required this.animation,
    required this.index,
    required this.width,
    required this.step,
    required this.showConnector,
  });

  final Animation<double> animation;
  final int index;
  final double width;
  final _WorkStep step;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    final stepAnimation = CurvedAnimation(
      parent: animation,
      curve: Interval(index * 0.12, 1, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: stepAnimation,
      builder: (context, child) {
        final v = stepAnimation.value;
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, (1 - v) * 32),
            child: child,
          ),
        );
      },
      child: _StepCard(width: width, step: step, showConnector: showConnector),
    );
  }
}

class _StepCard extends StatefulWidget {
  const _StepCard({
    required this.width,
    required this.step,
    required this.showConnector,
  });

  final double width;
  final _WorkStep step;
  final bool showConnector;

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final step = widget.step;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedScale(
            scale: _isHovered ? 1.03 : 1.0,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            child: SizedBox(
              width: widget.width,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? Color.lerp(AppColors.surfaceCard, step.accent, 0.07)
                      : AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? step.accent.withValues(alpha: 0.65)
                        : AppColors.cardBorder,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: step.accent.withValues(
                        alpha: _isHovered ? 0.22 : 0,
                      ),
                      blurRadius: 32,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Gradient number badge
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                step.accent,
                                step.accent.withValues(alpha: 0.5),
                              ],
                            ).createShader(bounds),
                            child: Text(
                              step.number,
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w900,
                                    height: 1,
                                  ),
                            ),
                          ),
                          const Spacer(),
                          // Icon
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 260),
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: step.accent.withValues(
                                alpha: _isHovered ? 0.2 : 0.1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: step.accent.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Icon(
                              step.icon,
                              color: step.accent,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text(
                        step.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.foreground,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        step.description,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: AppColors.muted, height: 1.65),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Arrow connector between cards (desktop 4-col)
          if (widget.showConnector)
            Positioned(
              right: -22,
              top: 40,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: _isHovered ? step.accent : AppColors.subtle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
