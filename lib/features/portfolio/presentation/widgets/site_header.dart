import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';

class SiteHeader extends StatefulWidget {
  const SiteHeader({
    super.key,
    required this.onSectionTap,
    this.activeSection = 'Home',
  });

  final void Function(String section) onSectionTap;
  final String activeSection;

  @override
  State<SiteHeader> createState() => _SiteHeaderState();
}

class _SiteHeaderState extends State<SiteHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  static const _navItems = ['Home', 'Experience', 'Projects', 'Contact'];

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.background.withValues(alpha: 0.72),
                border: Border(
                  bottom: BorderSide(color: AppColors.glassBorder, width: 1),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxWidth < 820;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth < 950 ? 18 : 40,
                      ),
                      child: Row(
                        children: [
                          _NavLogo(onTap: () => widget.onSectionTap('Home')),
                          const Spacer(),
                          if (!isCompact) ...[
                            for (final item in _navItems)
                              _NavLink(
                                label: item,
                                isActive: widget.activeSection == item,
                                onTap: () => widget.onSectionTap(item),
                              ),
                            const SizedBox(width: 16),
                          ],
                          _HireMeButton(
                            onTap: () => widget.onSectionTap('Contact'),
                          ),
                          if (isCompact) ...[
                            const SizedBox(width: 12),
                            _MobileMenuButton(
                              navItems: _navItems,
                              activeSection: widget.activeSection,
                              onTap: widget.onSectionTap,
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Logo ─────────────────────────────────────────────────────────────────────

class _NavLogo extends StatefulWidget {
  const _NavLogo({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_NavLogo> createState() => _NavLogoState();
}

class _NavLogoState extends State<_NavLogo> {
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'AB',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) =>
                    AppColors.heroTextGradient.createShader(bounds),
                child: const Text(
                  'Ahmad Bilal',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Nav Link ──────────────────────────────────────────────────────────────────

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = widget.isActive || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isHighlighted ? AppColors.foreground : AppColors.muted,
                  letterSpacing: -0.1,
                  fontFamily: 'Inter',
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                height: 2,
                width: isHighlighted ? 24 : 0,
                decoration: BoxDecoration(
                  gradient: isHighlighted ? AppColors.primaryGradient : null,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Hire Me Button ────────────────────────────────────────────────────────────

class _HireMeButton extends StatefulWidget {
  const _HireMeButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<_HireMeButton> {
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
          scale: _isHovered ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(
                    alpha: _isHovered ? 0.5 : 0.3,
                  ),
                  blurRadius: _isHovered ? 24 : 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Text(
              'Hire Me',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Mobile Menu ───────────────────────────────────────────────────────────────

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({
    required this.navItems,
    required this.activeSection,
    required this.onTap,
  });

  final List<String> navItems;
  final String activeSection;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.glassBorder),
      ),
      icon: const Icon(Icons.menu_rounded, color: AppColors.foreground),
      onSelected: onTap,
      itemBuilder: (context) => [
        for (final item in navItems)
          PopupMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: activeSection == item
                    ? AppColors.primary
                    : AppColors.foreground,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ),
      ],
    );
  }
}
