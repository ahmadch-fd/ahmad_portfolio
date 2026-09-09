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
    ),
    _WorkStep(
      number: '02',
      title: 'Architecture',
      description: 'Design scalable systems with clean separation of concerns and a clear growth roadmap.',
    ),
    _WorkStep(
      number: '03',
      title: 'Development',
      description: 'Rapid iteration with daily demos, feedback loops, and flexible improvements.',
    ),
    _WorkStep(
      number: '04',
      title: 'Launch & Scale',
      description: 'Performance optimization, monitoring, analytics, and stable release support.',
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
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 108),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            children: [
              Text(
                'How I Work',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.foreground,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 56),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final columnCount = width >= 980
                      ? 4
                      : width >= 700
                      ? 2
                      : 1;
                  final spacing = columnCount == 1 ? 20.0 : 28.0;
                  final cardWidth =
                      (width - spacing * (columnCount - 1)) / columnCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 28,
                    children: [
                      for (var index = 0; index < _steps.length; index++)
                        _AnimatedStepCard(
                          animation: _controller,
                          index: index,
                          width: cardWidth,
                          showConnector:
                              columnCount == 4 && index < _steps.length - 1,
                          step: _steps[index],
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 70),
              const Divider(color: Color(0xFF193C55), height: 1),
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
  });

  final String number;
  final String title;
  final String description;
}

class _AnimatedStepCard extends StatelessWidget {
  const _AnimatedStepCard({
    required this.animation,
    required this.index,
    required this.width,
    required this.showConnector,
    required this.step,
  });

  final Animation<double> animation;
  final int index;
  final double width;
  final bool showConnector;
  final _WorkStep step;

  @override
  Widget build(BuildContext context) {
    final stepAnimation = CurvedAnimation(
      parent: animation,
      curve: Interval(index * 0.12, 1, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: stepAnimation,
      builder: (context, child) {
        final value = stepAnimation.value;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 32),
            child: child,
          ),
        );
      },
      child: _WorkStepCard(
        width: width,
        showConnector: showConnector,
        step: step,
      ),
    );
  }
}

class _WorkStepCard extends StatefulWidget {
  const _WorkStepCard({
    required this.width,
    required this.showConnector,
    required this.step,
  });

  final double width;
  final bool showConnector;
  final _WorkStep step;

  @override
  State<_WorkStepCard> createState() => _WorkStepCardState();
}

class _WorkStepCardState extends State<_WorkStepCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedScale(
            scale: _isHovered ? 1.035 : 1,
            duration: const Duration(milliseconds: 230),
            curve: Curves.easeOutCubic,
            child: SizedBox(
              width: widget.width,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? const Color(0xFF19233A)
                      : const Color(0xFF151B2E),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _isHovered
                        ? const Color(0xFF29B6F6)
                        : const Color(0xFF1A6B90).withValues(alpha: 0.58),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF29B6F6)
                          .withValues(alpha: _isHovered ? 0.20 : 0),
                      blurRadius: _isHovered ? 32 : 0,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 130),
                  child: Column(
                    children: [
                      Text(
                        widget.step.number,
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              color: const Color(0xFF1C5E89),
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              height: 1,
                            ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        widget.step.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.foreground,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.step.description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFE5E7EB),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.showConnector)
            Positioned(
              right: -28,
              top: 86,
              child: AnimatedContainer(
                width: 28,
                height: 2,
                duration: const Duration(milliseconds: 260),
                color: _isHovered
                    ? const Color(0xFF29B6F6)
                    : const Color(0xFF1C5E89),
              ),
            ),
          if (widget.showConnector)
            Positioned(
              right: -17,
              top: 84,
              child: AnimatedContainer(
                width: _isHovered ? 6 : 4,
                height: _isHovered ? 6 : 4,
                duration: const Duration(milliseconds: 260),
                decoration: const BoxDecoration(
                  color: Color(0xFF29B6F6),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
