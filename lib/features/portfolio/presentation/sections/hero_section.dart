import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/utils/cv_downloader.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';

// ══════════════════════════════════════════════════════════════════════════════
// HeroSection
// ══════════════════════════════════════════════════════════════════════════════

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, this.onGetInTouch});
  final VoidCallback? onGetInTouch;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  // Intro animation
  late final AnimationController _introController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // Glow pulse for avatar ring
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  // Sweeping gradient for name
  late final AnimationController _gradientController;

  // Role text fade cycling
  int _roleIndex = 0;
  bool _showRole = true;
  Timer? _roleTimer;
  Timer? _roleTransitionTimer;

  static const _roles = [
    'Flutter Mobile Developer',
    'Mobile App Engineer',
    'Clean Architecture Advocate',
    'UI/UX Enthusiast',
  ];

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.22), end: Offset.zero).animate(
          CurvedAnimation(parent: _introController, curve: Curves.easeOutCubic),
        );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _startRoleCycling();
  }

  void _startRoleCycling() {
    _roleTimer = Timer.periodic(const Duration(milliseconds: 3500), (_) {
      if (!mounted) return;
      setState(() => _showRole = false);
      _roleTransitionTimer = Timer(const Duration(milliseconds: 320), () {
        if (!mounted) return;
        setState(() {
          _roleIndex = (_roleIndex + 1) % _roles.length;
          _showRole = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _roleTimer?.cancel();
    _roleTransitionTimer?.cancel();
    _introController.dispose();
    _glowController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 860;
        final viewHeight = MediaQuery.sizeOf(context).height;

        return Container(
          constraints: BoxConstraints(minHeight: viewHeight - 70),
          padding: EdgeInsets.fromLTRB(
            isDesktop ? 48 : 24,
            isDesktop ? 60 : 48,
            isDesktop ? 48 : 24,
            72,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: isDesktop ? _buildDesktop() : _buildMobile(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktop() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 55,
              child: _HeroTextBlock(
                roles: _roles,
                roleIndex: _roleIndex,
                showRole: _showRole,
                gradientController: _gradientController,
                onGetInTouch: widget.onGetInTouch,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            const SizedBox(width: 72),
            Expanded(
              flex: 45,
              child: Center(
                child: _ProfileAvatar(
                  glowAnimation: _glowAnimation,
                  gradientController: _gradientController,
                  size: 320,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 88),
        const _TechStrip(),
      ],
    );
  }

  Widget _buildMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ProfileAvatar(
          glowAnimation: _glowAnimation,
          gradientController: _gradientController,
          size: 210,
        ),
        const SizedBox(height: 44),
        _HeroTextBlock(
          roles: _roles,
          roleIndex: _roleIndex,
          showRole: _showRole,
          gradientController: _gradientController,
          onGetInTouch: widget.onGetInTouch,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        const SizedBox(height: 72),
        const _TechStrip(),
      ],
    );
  }
}

// ── Hero Text Block ───────────────────────────────────────────────────────────

class _HeroTextBlock extends StatelessWidget {
  const _HeroTextBlock({
    required this.roles,
    required this.roleIndex,
    required this.showRole,
    required this.gradientController,
    required this.onGetInTouch,
    required this.crossAxisAlignment,
  });

  final List<String> roles;
  final int roleIndex;
  final bool showRole;
  final AnimationController gradientController;
  final VoidCallback? onGetInTouch;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final isCenter = crossAxisAlignment == CrossAxisAlignment.center;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Availability badge
        _AvailabilityBadge(),
        const SizedBox(height: 28),

        // "Hey I am" line
        Text(
          'Hey, I am',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.muted,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 8),

        // Animated name with sweeping gradient
        AnimatedBuilder(
          animation: gradientController,
          builder: (context, child) {
            return ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment(-1.3 + gradientController.value * 2.6, -1),
                  end: Alignment(-0.3 + gradientController.value * 2.6, 1),
                  colors: const [
                    Color(0xFFFF7A59),
                    Color(0xFFFFF3E8),
                    Color(0xFFE35D9D),
                    AppColors.accent,
                  ],
                  stops: const [0, 0.38, 0.68, 1],
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                );
              },
              child: Text(
                'Ahmad Bilal',
                textAlign: isCenter ? TextAlign.center : TextAlign.start,
                style: Theme.of(context).textTheme.displayLarge
                    ?.copyWith(fontWeight: FontWeight.w900, height: 1.02),
              ),
            );
          },
        ),
        const SizedBox(height: 18),

        // Animated role switcher
        SizedBox(
          height: 32,
          child: AnimatedOpacity(
            opacity: showRole ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            child: AnimatedSlide(
              offset: showRole ? Offset.zero : const Offset(0, 0.3),
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              child: Row(
                mainAxisSize: isCenter ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: isCenter
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    width: 3,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    roles[roleIndex],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.accentCyan,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Description
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isCenter ? 620 : double.infinity,
          ),
          child: Text(
            'BS Computer Science graduate from The Islamia University of Bahawalpur. I build polished Flutter mobile apps with clean architecture, responsive interfaces, and reliable integrations.',
            textAlign: isCenter ? TextAlign.center : TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: AppColors.muted, height: 1.75, fontSize: 15),
          ),
        ),
        const SizedBox(height: 40),

        // CTA Buttons
        _HeroButtons(onGetInTouch: onGetInTouch, isCenter: isCenter),
      ],
    );
  }
}

// ── Availability Badge ─────────────────────────────────────────────────────────

class _AvailabilityBadge extends StatefulWidget {
  @override
  State<_AvailabilityBadge> createState() => _AvailabilityBadgeState();
}

class _AvailabilityBadgeState extends State<_AvailabilityBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accentGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.accentGreen.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) => Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.accentGreen.withValues(
                  alpha: _pulseAnimation.value,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentGreen.withValues(
                      alpha: _pulseAnimation.value * 0.6,
                    ),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Available for new projects',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.accentGreen,
              letterSpacing: 0.2,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero Buttons ──────────────────────────────────────────────────────────────

class _HeroButtons extends StatelessWidget {
  const _HeroButtons({required this.onGetInTouch, required this.isCenter});

  final VoidCallback? onGetInTouch;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
      spacing: 14,
      runSpacing: 12,
      children: [
        _GradientButton(
          label: 'Get In Touch',
          onTap: onGetInTouch ?? () {},
          icon: Icons.arrow_forward_rounded,
        ),
        _OutlineButton(
          label: 'Download CV',
          onTap: downloadCv,
          icon: Icons.download_rounded,
        ),
      ],
    );
  }
}

class _GradientButton extends StatefulWidget {
  const _GradientButton({
    required this.label,
    required this.onTap,
    required this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final IconData icon;

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(
                    alpha: _isHovered ? 0.55 : 0.3,
                  ),
                  blurRadius: _isHovered ? 30 : 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.1,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(width: 8),
                Icon(widget.icon, color: Colors.white, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  const _OutlineButton({
    required this.label,
    required this.onTap,
    required this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final IconData icon;

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.foreground.withValues(alpha: 0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: _isHovered
                    ? AppColors.foreground.withValues(alpha: 0.7)
                    : AppColors.glassBorder,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    color: _isHovered ? AppColors.foreground : AppColors.muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  widget.icon,
                  color: _isHovered ? AppColors.foreground : AppColors.muted,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Profile Avatar ─────────────────────────────────────────────────────────────

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.glowAnimation,
    required this.gradientController,
    this.size = 300,
  });

  final Animation<double> glowAnimation;
  final AnimationController gradientController;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([glowAnimation, gradientController]),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow rings
            Container(
              width: size + 60,
              height: size + 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(
                      alpha: glowAnimation.value * 0.18,
                    ),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Rotating gradient border ring
            Transform.rotate(
              angle: gradientController.value * 2 * math.pi,
              child: Container(
                width: size + 16,
                height: size + 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: const [
                      AppColors.primary,
                      AppColors.accent,
                      AppColors.accentCyan,
                      AppColors.primary,
                    ],
                  ),
                ),
              ),
            ),
            // Inner white ring (separation between photo and gradient)
            Container(
              width: size + 10,
              height: size + 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
              ),
            ),
            // Profile photo
            Container(
              width: size,
              height: size,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(
                'assets/images/profile_placeholder.jpg',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            // Corner tech badge
            Positioned(
              bottom: 16,
              right: 0,
              child: _TechBadge(glowAlpha: glowAnimation.value * 0.5),
            ),
          ],
        );
      },
    );
  }
}

class _TechBadge extends StatelessWidget {
  const _TechBadge({required this.glowAlpha});
  final double glowAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: glowAlpha),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.accentGreen,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentGreen.withValues(alpha: 0.6),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '2+ Years Flutter',
            style: TextStyle(
              color: AppColors.foreground,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tech Strip ─────────────────────────────────────────────────────────────────

class _TechStrip extends StatelessWidget {
  const _TechStrip();

  static const _items = [
    _TechItem(
      name: 'Flutter',
      category: 'UI FRAMEWORK',
      detail: 'Cross-platform iOS, Android, custom UI & animations',
      assetPath: 'assets/images/flutter_transparent.png',
      accent: Color(0xFF47C5FB),
    ),
    _TechItem(
      name: 'Dart',
      category: 'CORE LANGUAGE',
      detail: 'OOP, Async streams, null safety & clean logic',
      assetPath: 'assets/images/dart_transparent.png',
      accent: Color(0xFF0175C2),
    ),
    _TechItem(
      name: 'Firebase',
      category: 'CLOUD & AUTH',
      detail: 'Firestore, Cloud Auth, Analytics & Messaging',
      assetPath: 'assets/images/firebase_transparent.png',
      accent: Color(0xFFFFCA28),
    ),
    _TechItem(
      name: 'REST APIs',
      category: 'NETWORKING',
      detail: 'Dio/HTTP client, JSON models & MVVM patterns',
      assetPath: 'assets/images/restapi_transparent.png',
      accent: Color(0xFF00E5FF),
    ),
    _TechItem(
      name: 'Git & GitHub',
      category: 'COLLABORATION',
      detail: 'Version control, branching, PRs & CI/CD delivery',
      assetPath: 'assets/images/github_white_transparent.png',
      accent: Color(0xFFC084FC),
    ),
    _TechItem(
      name: 'Play Console',
      category: 'DEPLOYMENT',
      detail: 'App Bundles, Release tracks, testing & Vitals',
      assetPath: 'assets/images/playconsole_transparent.png',
      accent: Color(0xFF34D399),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final double cardWidth;
        if (availableWidth >= 1080) {
          cardWidth = (availableWidth - (5 * 14)) / 6;
        } else if (availableWidth >= 720) {
          cardWidth = (availableWidth - (2 * 14)) / 3;
        } else if (availableWidth >= 460) {
          cardWidth = (availableWidth - (1 * 14)) / 2;
        } else {
          cardWidth = availableWidth;
        }

        final clampedWidth = cardWidth.clamp(145.0, 190.0);

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, AppColors.glassBorder],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.accentCyan,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'EXPERIENCE WITH',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.muted,
                              letterSpacing: 2.2,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.glassBorder, Colors.transparent],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (final item in _items)
                  _TechCard(item: item, width: clampedWidth),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TechItem {
  const _TechItem({
    required this.name,
    required this.category,
    required this.detail,
    required this.assetPath,
    required this.accent,
  });

  final String name;
  final String category;
  final String detail;
  final String assetPath;
  final Color accent;
}

class _TechCard extends StatefulWidget {
  const _TechCard({required this.item, required this.width});
  final _TechItem item;
  final double width;

  @override
  State<_TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<_TechCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -5.0 : 0.0, 0.0),
        width: widget.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isHovered
              ? Color.lerp(AppColors.surfaceCard, item.accent, 0.07)
              : AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? item.accent.withValues(alpha: 0.6)
                : AppColors.cardBorder,
            width: _isHovered ? 1.4 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: item.accent.withValues(alpha: _isHovered ? 0.22 : 0.02),
              blurRadius: _isHovered ? 22 : 8,
              offset: Offset(0, _isHovered ? 8 : 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: item.accent.withValues(
                        alpha: _isHovered ? 0.45 : 0.2,
                      ),
                    ),
                  ),
                  child: Image.asset(
                    item.assetPath,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: item.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: item.accent.withValues(alpha: 0.35),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      item.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: item.accent,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              item.name,
              style: const TextStyle(
                color: AppColors.foreground,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 5),
            Text(
              item.detail,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 11,
                height: 1.45,
                fontFamily: 'Inter',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
