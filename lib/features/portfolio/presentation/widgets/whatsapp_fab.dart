import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppFab extends StatefulWidget {
  const WhatsAppFab({super.key});

  static const String whatsAppNumber = '923087154021';
  static final Uri whatsAppUri = Uri.parse('https://wa.me/$whatsAppNumber');

  @override
  State<WhatsAppFab> createState() => _WhatsAppFabState();
}

class _WhatsAppFabState extends State<WhatsAppFab>
    with TickerProviderStateMixin {
  // Ripple / Sonar pulse animation
  late final AnimationController _rippleController;
  late final Animation<double> _rippleScale;
  late final Animation<double> _rippleOpacity;

  // Icon attention bounce & tilt animation
  late final AnimationController _iconController;
  late final Animation<double> _iconRotation;
  late final Animation<double> _iconScale;

  bool _isHovered = false;
  bool _isPressed = false;

  static const _whatsAppGreen = Color(0xFF25D366);
  static const _whatsAppDarkGreen = Color(0xFF1EBE5D);

  static const _whatsAppSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="28" height="28" fill="#FFFFFF">
  <path d="M12.04 2C6.58 2 2.13 6.45 2.13 11.91C2.13 13.66 2.59 15.36 3.45 16.86L2.05 22L7.3 20.62C8.75 21.41 10.38 21.83 12.04 21.83C17.5 21.83 21.95 17.38 21.95 11.92C21.95 9.27 20.92 6.78 19.05 4.91C17.18 3.03 14.69 2 12.04 2ZM12.05 3.67C14.25 3.67 16.31 4.53 17.87 6.09C19.42 7.65 20.28 9.72 20.28 11.92C20.28 16.46 16.58 20.15 12.04 20.15C10.56 20.15 9.11 19.76 7.85 19.01L7.55 18.83L4.43 19.65L5.26 16.61L5.06 16.29C4.24 14.99 3.8 13.47 3.8 11.91C3.81 7.37 7.5 3.67 12.05 3.67ZM8.53 7.33C8.37 7.33 8.1 7.39 7.87 7.64C7.65 7.89 7.02 8.48 7.02 9.68C7.02 10.88 7.89 12.04 8.01 12.2C8.13 12.37 9.71 14.81 12.13 15.86C12.71 16.11 13.16 16.26 13.51 16.37C14.09 16.56 14.62 16.53 15.04 16.47C15.51 16.4 16.48 15.88 16.68 15.31C16.89 14.74 16.89 14.25 16.82 14.15C16.76 14.04 16.6 13.98 16.36 13.86C16.12 13.74 14.95 13.16 14.73 13.08C14.51 13 14.35 12.96 14.19 13.2C14.03 13.45 13.57 13.98 13.43 14.15C13.29 14.31 13.15 14.33 12.91 14.21C12.67 14.09 11.89 13.83 10.97 13.01C10.25 12.37 9.77 11.58 9.63 11.34C9.49 11.1 9.61 10.96 9.73 10.84C9.84 10.73 9.98 10.55 10.1 10.41C10.22 10.27 10.26 10.17 10.34 10.01C10.42 9.85 10.38 9.71 10.32 9.59C10.26 9.47 9.78 8.29 9.58 7.8C9.38 7.32 9.18 7.39 9.03 7.38C8.89 7.38 8.73 7.33 8.53 7.33Z"/>
</svg>
''';

  @override
  void initState() {
    super.initState();

    // Subtle sonar wave expanding from the button
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    _rippleScale = Tween<double>(begin: 1.0, end: 1.55).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOutQuad),
    );

    _rippleOpacity = Tween<double>(begin: 0.45, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOutQuad),
    );

    // Icon wiggle & pulse loop
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();

    // Wiggles in the first 28% of the cycle, then rests
    _iconRotation =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(
              begin: 0.0,
              end: -0.16,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 20,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: -0.16,
              end: 0.16,
            ).chain(CurveTween(curve: Curves.easeInOut)),
            weight: 30,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 0.16,
              end: -0.08,
            ).chain(CurveTween(curve: Curves.easeInOut)),
            weight: 25,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: -0.08,
              end: 0.0,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 25,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _iconController,
            curve: const Interval(0.0, 0.28, curve: Curves.linear),
          ),
        );

    _iconScale =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(
              begin: 1.0,
              end: 1.18,
            ).chain(CurveTween(curve: Curves.easeOutCubic)),
            weight: 45,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 1.18,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.easeInCubic)),
            weight: 55,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _iconController,
            curve: const Interval(0.0, 0.28, curve: Curves.linear),
          ),
        );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  Future<void> _launchWhatsApp() async {
    try {
      final launched = await launchUrl(
        WhatsAppFab.whatsAppUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        await launchUrl(WhatsAppFab.whatsAppUri);
      }
    } catch (_) {
      await launchUrl(WhatsAppFab.whatsAppUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: _launchWhatsApp,
        child: AnimatedScale(
          scale: _isPressed ? 0.94 : (_isHovered ? 1.05 : 1.0),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: Stack(
            alignment: Alignment.centerRight,
            clipBehavior: Clip.none,
            children: [
              // Expanding ripple wave
              AnimatedBuilder(
                animation: _rippleController,
                builder: (context, child) {
                  return Positioned(
                    right: 0,
                    child: Transform.scale(
                      scale: _rippleScale.value,
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _whatsAppGreen.withValues(
                            alpha: _rippleOpacity.value,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Main button container (expands smoothly when hovered on desktop)
              AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                height: 58,
                padding: EdgeInsets.symmetric(horizontal: _isHovered ? 18 : 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2EE074), _whatsAppDarkGreen],
                  ),
                  borderRadius: BorderRadius.circular(36),
                  boxShadow: [
                    BoxShadow(
                      color: _whatsAppGreen.withValues(
                        alpha: _isHovered ? 0.65 : 0.4,
                      ),
                      blurRadius: _isHovered ? 26 : 16,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Expandable label on hover
                    ClipRect(
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 240),
                        curve: Curves.easeOutCubic,
                        child: _isHovered
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Chat on WhatsApp',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.2,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),

                    // Animated WhatsApp icon
                    AnimatedBuilder(
                      animation: _iconController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _iconRotation.value,
                          child: Transform.scale(
                            scale: _iconScale.value,
                            child: child,
                          ),
                        );
                      },
                      child: SvgPicture.string(
                        _whatsAppSvg,
                        width: 28,
                        height: 28,
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
