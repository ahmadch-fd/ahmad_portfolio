import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with TickerProviderStateMixin {
  static const _projects = [
    _ProjectPreview(
      title: 'TaskFlow',
      category: 'PRODUCTIVITY',
      description: 'A clean mobile app concept for planning work, tracking goals, and keeping daily tasks organized.',
      detail: 'TaskFlow is designed as a focused productivity app where users can create task lists, track daily progress, set reminders, and manage personal goals with a smooth mobile-first experience.',
      features: [
        'Daily task planning with priority states',
        'Goal progress dashboard and activity history',
        'Firebase-ready user data structure',
        'Clean Flutter UI prepared for Android and iOS',
      ],
      tags: ['Flutter', 'Firebase'],
      colors: [Color(0xFF1D8CFF), Color(0xFF83E0FF)],
      accent: Color(0xFF38BDF8),
    ),
    _ProjectPreview(
      title: 'ShopMate',
      category: 'ECOMMERCE APP',
      description: 'A smooth shopping experience with product browsing, cart flows, checkout, and order tracking.',
      detail: 'ShopMate shows a complete ecommerce mobile flow from product discovery to checkout. It is structured for REST APIs, cart persistence, user profiles, and clean order tracking screens.',
      features: [
        'Product listing and detail screens',
        'Cart, checkout, and order status flow',
        'REST API friendly architecture',
        'Reusable widgets for store pages',
      ],
      tags: ['Android', 'REST API'],
      colors: [Color(0xFF5B2EFF), Color(0xFFFF7C6B)],
      accent: Color(0xFFFF7C6B),
    ),
    _ProjectPreview(
      title: 'FitPulse',
      category: 'HEALTH APP',
      description: 'A fitness dashboard concept with workout plans, progress charts, and habit tracking.',
      detail: 'FitPulse is a fitness app concept built around habit consistency. It includes workout summaries, weekly progress visuals, health reminders, and a simple dashboard for tracking routines.',
      features: [
        'Workout plans and progress summaries',
        'Habit streaks and reminder-ready screens',
        'Lightweight dashboard components',
        'Responsive mobile layouts',
      ],
      tags: ['iOS', 'Android'],
      colors: [Color(0xFF02C39A), Color(0xFFFFD166)],
      accent: Color(0xFF02C39A),
    ),
    _ProjectPreview(
      title: 'RideWave',
      category: 'RIDE BOOKING',
      description: 'A ride-booking app concept with live route previews, driver status, and trip history.',
      detail: 'RideWave presents the core screens of a modern ride booking app: location selection, driver matching, live trip status, fare preview, and past rides.',
      features: [
        'Booking and route preview flow',
        'Driver matching UI states',
        'Trip history and fare summary cards',
        'Map-focused mobile experience',
      ],
      tags: ['Web', 'Case Study'],
      colors: [Color(0xFF111827), Color(0xFF29B6F6)],
      accent: Color(0xFF29B6F6),
    ),
    _ProjectPreview(
      title: 'PayNest',
      category: 'FINTECH',
      description: 'A modern wallet and rewards concept focused on secure payments and clean account insights.',
      detail: 'PayNest is a fintech concept that keeps payments, cards, rewards, and account insights in one polished Flutter interface. The dummy flow is ready to be replaced with real APIs later.',
      features: [
        'Wallet balance and card overview',
        'Transaction list and reward status',
        'Secure payment flow concept',
        'Scalable screen structure for finance apps',
      ],
      tags: ['Flutter', 'Launching soon'],
      colors: [Color(0xFFF59E0B), Color(0xFF0EA5E9)],
      accent: Color(0xFFF59E0B),
    ),
    _ProjectPreview(
      title: 'Learnly',
      category: 'EDTECH',
      description: 'A learning app concept with courses, quizzes, progress tracking, and student dashboards.',
      detail: 'Learnly is an education app concept for course browsing, lessons, quiz attempts, and progress tracking. It is prepared for student and instructor style screens.',
      features: [
        'Course browsing and lesson detail screens',
        'Quiz and score summary concepts',
        'Progress dashboard for students',
        'Firebase-ready learning data model',
      ],
      tags: ['Firebase', 'Case Study'],
      colors: [Color(0xFFA855F7), Color(0xFF22C55E)],
      accent: Color(0xFFA855F7),
    ),
  ];

  late final AnimationController _entranceController;
  late final AnimationController _shineController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  void _openProjectDetails(_ProjectPreview project) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close project details',
      barrierColor: Colors.black.withValues(alpha: 0.72),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _ProjectDetailsDialog(project: project);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 112),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _shineController,
                builder: (context, child) {
                  return _AnimatedProjectsTitle(
                    progress: _shineController.value,
                  );
                },
              ),
              const SizedBox(height: 44),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final columnCount = width >= 980
                      ? 3
                      : width >= 660
                      ? 2
                      : 1;
                  final spacing = columnCount == 1 ? 20.0 : 24.0;
                  final cardWidth =
                      (width - spacing * (columnCount - 1)) / columnCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 24,
                    children: [
                      for (var index = 0; index < _projects.length; index++)
                        _StaggeredProjectCard(
                          animation: _entranceController,
                          index: index,
                          width: cardWidth,
                          project: _projects[index],
                          onTap: () => _openProjectDetails(_projects[index]),
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

class _ProjectPreview {
  const _ProjectPreview({
    required this.title,
    required this.category,
    required this.description,
    required this.detail,
    required this.features,
    required this.tags,
    required this.colors,
    required this.accent,
  });

  final String title;
  final String category;
  final String description;
  final String detail;
  final List<String> features;
  final List<String> tags;
  final List<Color> colors;
  final Color accent;
}

class _AnimatedProjectsTitle extends StatelessWidget {
  const _AnimatedProjectsTitle({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment(-1.2 + progress * 2.4, -1),
          end: Alignment(-0.2 + progress * 2.4, 1),
          colors: const [
            AppColors.primary,
            Color(0xFFFFF3E8),
            Color(0xFFE35D9D),
            AppColors.accent,
          ],
          stops: const [0, 0.42, 0.68, 1],
        ).createShader(bounds);
      },
      child: Text(
        'PROJECTS',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          fontSize: 54,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
          height: 1,
        ),
      ),
    );
  }
}

class _StaggeredProjectCard extends StatelessWidget {
  const _StaggeredProjectCard({
    required this.animation,
    required this.index,
    required this.width,
    required this.project,
    required this.onTap,
  });

  final Animation<double> animation;
  final int index;
  final double width;
  final _ProjectPreview project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final start = (index * 0.08).clamp(0.0, 0.55);
    final interval = CurvedAnimation(
      parent: animation,
      curve: Interval(start, 1, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: interval,
      builder: (context, child) {
        final value = interval.value;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 42),
            child: Transform.scale(scale: 0.96 + value * 0.04, child: child),
          ),
        );
      },
      child: _ProjectCard(width: width, project: project, onTap: onTap),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.width,
    required this.project,
    required this.onTap,
  });

  final double width;
  final _ProjectPreview project;
  final VoidCallback onTap;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.035 : 1,
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            width: widget.width,
            decoration: BoxDecoration(
              color: _isHovered
                  ? Color.lerp(const Color(0xFF111827), project.accent, 0.12)
                  : const Color(0xFF111827),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isHovered
                    ? project.accent.withValues(alpha: 0.78)
                    : const Color(0xFF16425D),
              ),
              boxShadow: [
                BoxShadow(
                  color: project.accent.withValues(
                    alpha: _isHovered ? 0.24 : 0,
                  ),
                  blurRadius: _isHovered ? 34 : 0,
                  spreadRadius: _isHovered ? 1 : 0,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'project-poster-${project.title}',
                    child: _ProjectPoster(
                      project: project,
                      isHovered: _isHovered,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: const Color(0xFFE5E7EB),
                                height: 1.6,
                              ),
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final tag in project.tags)
                              _ProjectTag(label: tag, color: project.accent),
                          ],
                        ),
                      ],
                    ),
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

class _ProjectDetailsDialog extends StatelessWidget {
  const _ProjectDetailsDialog({required this.project});

  final _ProjectPreview project;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final compact = size.width < 760;

    return SafeArea(
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 920),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: project.accent.withValues(alpha: 0.72),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: project.accent.withValues(alpha: 0.24),
                      blurRadius: 42,
                      offset: const Offset(0, 24),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: 'project-poster-${project.title}',
                              child: _ProjectPoster(
                                project: project,
                                isHovered: false,
                                large: !compact,
                              ),
                            ),
                            Positioned(
                              right: 12,
                              top: 12,
                              child: IconButton(
                                tooltip: 'Close project details',
                                onPressed: () => Navigator.of(context).pop(),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.black.withValues(
                                    alpha: 0.42,
                                  ),
                                  foregroundColor: Colors.white,
                                ),
                                icon: const Icon(Icons.close_rounded),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            compact ? 20 : 34,
                            26,
                            compact ? 20 : 34,
                            34,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.category,
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      color: project.accent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.4,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                project.title,
                                style: Theme.of(context).textTheme.displayLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: compact ? 38 : 54,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0,
                                      height: 1,
                                    ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                project.detail,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: const Color(0xFFE5E7EB),
                                      height: 1.65,
                                    ),
                              ),
                              const SizedBox(height: 26),
                              Text(
                                'Project Details',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              const SizedBox(height: 14),
                              Wrap(
                                runSpacing: 12,
                                spacing: 12,
                                children: [
                                  for (final feature in project.features)
                                    _DetailFeature(
                                      text: feature,
                                      color: project.accent,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  for (final tag in project.tags)
                                    _ProjectTag(
                                      label: tag,
                                      color: project.accent,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailFeature extends StatelessWidget {
  const _DetailFeature({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 220, maxWidth: 390),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: color.withValues(alpha: 0.62)),
            ),
            child: Icon(Icons.check_rounded, size: 15, color: color),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: const Color(0xFFE5E7EB), height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectPoster extends StatelessWidget {
  const _ProjectPoster({
    required this.project,
    required this.isHovered,
    this.large = false,
  });

  final _ProjectPreview project;
  final bool isHovered;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: large ? 2.35 : 1.6,
      child: AnimatedScale(
        scale: isHovered ? 1.07 : 1,
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: project.colors,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _PosterPatternPainter(
                    color: Colors.white.withValues(alpha: 0.14),
                  ),
                ),
              ),
              Positioned(
                right: large ? 56 : 24,
                top: large ? 36 : 28,
                child: AnimatedRotation(
                  turns: isHovered ? 0.035 : 0,
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOutCubic,
                  child: _PhoneMockup(large: large),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.46),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: large ? 34 : 18,
                bottom: large ? 34 : 24,
                right: large ? 220 : 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.category,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: project.accent,
                        fontSize: large ? 13 : 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontSize: large ? 46 : 27,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0,
                            height: 1,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  const _PhoneMockup({this.large = false});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final width = large ? 112.0 : 82.0;
    final height = large ? 198.0 : 146.0;

    return Transform.rotate(
      angle: -math.pi / 18,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(large ? 9 : 7),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(large ? 24 : 18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.42)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 16,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(large ? 18 : 13),
          ),
          child: Column(
            children: [
              SizedBox(height: large ? 18 : 12),
              Container(
                width: large ? 42 : 32,
                height: large ? 5 : 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF94A3B8),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: large ? 22 : 16),
              for (var index = 0; index < 4; index++) ...[
                Container(
                  width: large ? 66 : 48,
                  height: large ? 13 : 10,
                  decoration: BoxDecoration(
                    color: Color.lerp(
                      const Color(0xFF38BDF8),
                      const Color(0xFFA855F7),
                      index / 3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: large ? 11 : 8),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectTag extends StatelessWidget {
  const _ProjectTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.72)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class _PosterPatternPainter extends CustomPainter {
  const _PosterPatternPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 5; i++) {
      final radius = 42.0 + i * 30;
      canvas.drawCircle(
        Offset(size.width * 0.78, size.height * 0.2),
        radius,
        paint,
      );
    }

    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..strokeWidth = 1;

    for (var x = -size.height; x < size.width; x += 32) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PosterPatternPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
