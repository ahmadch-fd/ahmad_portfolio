import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, this.onGetInTouch});

  final VoidCallback? onGetInTouch;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _headlineController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    )..forward();
    _headlineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();
    _fadeAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOutCubic,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.16), end: Offset.zero).animate(
          CurvedAnimation(parent: _introController, curve: Curves.easeOutCubic),
        );
  }

  @override
  void dispose() {
    _introController.dispose();
    _headlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 620;
        final titleSize = isCompact ? 42.0 : 72.0;
        final viewportHeight = MediaQuery.sizeOf(context).height;

        return Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              isCompact ? 24 : 40,
              28,
              isCompact ? 24 : 40,
              64,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 980,
                minHeight: viewportHeight - 92,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _AvatarMark(),
                  const SizedBox(height: 28),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: AnimatedBuilder(
                        animation: _headlineController,
                        builder: (context, child) {
                          return Column(
                            children: [
                              _IntroHeroContent(
                                titleSize: titleSize,
                                headlineProgress: _headlineController.value,
                              ),
                              const SizedBox(height: 34),
                              _HeroActions(onGetInTouch: widget.onGetInTouch),
                              const SizedBox(height: 72),
                              const _ExperienceStrip(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _IntroHeroContent extends StatelessWidget {
  const _IntroHeroContent({
    required this.titleSize,
    required this.headlineProgress,
  });

  final double titleSize;
  final double headlineProgress;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.displayLarge?.copyWith(
      fontSize: titleSize,
      fontWeight: FontWeight.w900,
      letterSpacing: 0,
    );

    return Column(
      children: [
        _AnimatedIntroHeadline(
          titleStyle: titleStyle,
          progress: headlineProgress,
        ),
        const SizedBox(height: 18),
        Text(
          'Flutter Mobile Application Developer',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: titleSize * 0.38,
            fontWeight: FontWeight.w800,
            color: AppColors.foreground,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            'I am Ahmad Bilal, a BS Computer Science graduate from The Islamia University of Bahawalpur. I build polished Flutter mobile applications with clean architecture, responsive interfaces, and reliable integrations that turn ideas into practical digital products.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.muted,
              height: 1.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedIntroHeadline extends StatelessWidget {
  const _AnimatedIntroHeadline({
    required this.titleStyle,
    required this.progress,
  });

  final TextStyle? titleStyle;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 4,
      children: [
        _FloatingWord(
          progress: progress,
          phase: 0,
          child: Text(
            'Hey I am',
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
        ),
        _FloatingWord(
          progress: progress,
          phase: 0.34,
          child: _GradientText(
            'Ahmad Bilal',
            style: titleStyle,
            progress: progress,
          ),
        ),
      ],
    );
  }
}

class _FloatingWord extends StatelessWidget {
  const _FloatingWord({
    required this.progress,
    required this.phase,
    required this.child,
  });

  final double progress;
  final double phase;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final wave = math.sin((progress + phase) * math.pi * 2);

    return Transform.translate(
      offset: Offset(0, wave * 3),
      child: Transform.scale(scale: 1 + wave * 0.012, child: child),
    );
  }
}

class _GradientText extends StatelessWidget {
  const _GradientText(this.text, {required this.style, this.progress = 0});

  final String text;
  final TextStyle? style;
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
            Color(0xFFFF7A59),
            Color(0xFFFFF3E8),
            Color(0xFFE35D9D),
            AppColors.accent,
          ],
          stops: const [0, 0.42, 0.68, 1],
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(text, textAlign: TextAlign.center, style: style),
    );
  }
}

class _AvatarMark extends StatelessWidget {
  const _AvatarMark();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logopotf.png',
      width: 132,
      height: 132,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}

class _HeroActions extends StatelessWidget {
  const _HeroActions({required this.onGetInTouch});

  final VoidCallback? onGetInTouch;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 14,
      runSpacing: 12,
      children: [
        FilledButton(
          onPressed: onGetInTouch,
          style: FilledButton.styleFrom(
            fixedSize: const Size(136, 46),
            backgroundColor: AppColors.foreground,
            foregroundColor: AppColors.buttonForeground,
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
            shape: const StadiumBorder(),
          ),
          child: const Text('Get In Touch'),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(136, 46),
            foregroundColor: AppColors.foreground,
            side: const BorderSide(color: AppColors.foreground, width: 1.4),
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
            shape: const StadiumBorder(),
          ),
          child: const Text('Download CV'),
        ),
      ],
    );
  }
}

class _ExperienceStrip extends StatelessWidget {
  const _ExperienceStrip();

  static const _items = [
    _TechItem(
      label: 'Dart',
      assetPath: 'assets/images/dart_transparent.png',
      size: 78,
    ),
    _TechItem(
      label: 'Flutter',
      assetPath: 'assets/images/flutter_transparent.png',
    ),
    _TechItem(
      label: 'Firebase',
      assetPath: 'assets/images/firebase_transparent.png',
    ),
    _TechItem(
      label: 'REST APIs',
      assetPath: 'assets/images/restapi_transparent.png',
    ),
    _TechItem(
      label: 'GitHub',
      assetPath: 'assets/images/github_white_transparent.png',
    ),
    _TechItem(
      label: 'Play Console',
      assetPath: 'assets/images/playconsole_transparent.png',
      size: 78,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'EXPERIENCE WITH',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.muted,
            fontWeight: FontWeight.w800,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 26),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 34,
          runSpacing: 24,
          children: [for (final item in _items) _TechLogo(item: item)],
        ),
      ],
    );
  }
}

class _TechItem {
  const _TechItem({
    required this.label,
    required this.assetPath,
    this.size = 64,
  });

  final String label;
  final String assetPath;
  final double size;
}

class _TechLogo extends StatelessWidget {
  const _TechLogo({required this.item});

  final _TechItem item;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: item.label,
      image: true,
      child: SizedBox(
        width: item.size,
        height: item.size,
        child: Image.asset(
          item.assetPath,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
