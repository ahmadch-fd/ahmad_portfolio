import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

abstract final class _FooterLinks {
  static final Uri whatsApp = Uri.parse('https://wa.me/923087154021');
  static final Uri email = Uri.parse('mailto:ahmadbilal01142@gmail.com');
  static final Uri github = Uri.parse('https://github.com/ahmadch-fd');
}

Future<void> _openLink(Uri uri) async {
  await launchUrl(uri, webOnlyWindowName: '_blank');
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.background, const Color(0xFF03060F)],
        ),
        border: Border(top: BorderSide(color: AppColors.glassBorder)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 80, 24, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxWidth < 760;

                    if (isCompact) {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FooterIdentity(),
                          SizedBox(height: 48),
                          _FooterNavigation(),
                          SizedBox(height: 48),
                          _FooterContact(),
                        ],
                      );
                    }

                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: _FooterIdentity()),
                        SizedBox(width: 64),
                        Expanded(flex: 3, child: _FooterNavigation()),
                        SizedBox(width: 64),
                        Expanded(flex: 5, child: _FooterContact()),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 72),
                Divider(color: AppColors.glassBorder, height: 1),
                const SizedBox(height: 28),
                const _FooterBottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Identity ──────────────────────────────────────────────────────────────────

class _FooterIdentity extends StatelessWidget {
  const _FooterIdentity();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo mark
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'AB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) =>
                      AppColors.heroTextGradient.createShader(bounds),
                  child: const Text(
                    'Ahmad Bilal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.4,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                const Text(
                  'Flutter Developer',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Crafting high-performance Flutter mobile apps where design meets engineering.',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: AppColors.muted, height: 1.75),
        ),
        const SizedBox(height: 28),
        // Availability badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.accentGreen.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: AppColors.accentGreen.withValues(alpha: 0.45),
            ),
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
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 9),
              Text(
                'AVAILABLE FOR NEW PROJECTS',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.accentGreen,
                  letterSpacing: 1.0,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Navigation ─────────────────────────────────────────────────────────────────

class _FooterNavigation extends StatelessWidget {
  const _FooterNavigation();

  static const _items = ['Home', 'Experience', 'Projects', 'Contact'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterLabel('NAVIGATION'),
        const SizedBox(height: 22),
        for (final item in _items) ...[
          _FooterNavItem(label: item),
          if (item != _items.last) const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class _FooterNavItem extends StatefulWidget {
  const _FooterNavItem({required this.label});
  final String label;

  @override
  State<_FooterNavItem> createState() => _FooterNavItemState();
}

class _FooterNavItemState extends State<_FooterNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedSlide(
        offset: _isHovered ? const Offset(0.03, 0) : Offset.zero,
        duration: const Duration(milliseconds: 200),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: 14,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w400,
            color: _isHovered ? AppColors.foreground : AppColors.muted,
            fontFamily: 'Inter',
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

// ── Contact ────────────────────────────────────────────────────────────────────

class _FooterContact extends StatelessWidget {
  const _FooterContact();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterLabel('GET IN TOUCH'),
        const SizedBox(height: 22),
        Row(
          children: [
            _SocialIconButton(
              icon: Icons.code_rounded,
              label: 'GitHub',
              uri: _FooterLinks.github,
              color: AppColors.foreground,
            ),
            const SizedBox(width: 10),
            _SocialIconButton(
              icon: Icons.email_rounded,
              label: 'Email',
              uri: _FooterLinks.email,
              color: AppColors.primary,
            ),
            const SizedBox(width: 10),
            _SocialIconButton(
              icon: Icons.phone_in_talk_rounded,
              label: 'WhatsApp',
              uri: _FooterLinks.whatsApp,
              color: AppColors.accentGreen,
            ),
          ],
        ),
        const SizedBox(height: 28),
        _ContactCard(
          icon: Icons.phone_in_talk_rounded,
          label: 'WHATSAPP',
          value: '+92 308 715 4021',
          uri: _FooterLinks.whatsApp,
          accent: AppColors.accentGreen,
        ),
        const SizedBox(height: 12),
        _ContactCard(
          icon: Icons.email_rounded,
          label: 'EMAIL',
          value: 'ahmadbilal01142@gmail.com',
          uri: _FooterLinks.email,
          accent: AppColors.primary,
        ),
        const SizedBox(height: 12),
        _ContactCard(
          icon: Icons.hub_rounded,
          label: 'GITHUB',
          value: 'github.com/ahmadch-fd',
          uri: _FooterLinks.github,
          accent: AppColors.accentCyan,
        ),
      ],
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  const _SocialIconButton({
    required this.icon,
    required this.label,
    required this.uri,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Uri uri;
  final Color color;

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _openLink(widget.uri),
        child: AnimatedScale(
          scale: _isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.15)
                  : AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered
                    ? widget.color.withValues(alpha: 0.6)
                    : AppColors.cardBorder,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withValues(alpha: _isHovered ? 0.25 : 0),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Tooltip(
              message: widget.label,
              child: Icon(
                widget.icon,
                color: _isHovered ? widget.color : AppColors.muted,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.uri,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final String value;
  final Uri uri;
  final Color accent;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _openLink(widget.uri),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.accent.withValues(alpha: 0.06)
                : AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? widget.accent.withValues(alpha: 0.5)
                  : AppColors.cardBorder,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: widget.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: widget.accent.withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(widget.icon, color: widget.accent, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.subtle,
                        fontSize: 10,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.foreground,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: widget.accent,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Shared ─────────────────────────────────────────────────────────────────────

class _FooterLabel extends StatelessWidget {
  const _FooterLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: AppColors.foreground,
        letterSpacing: 2.5,
        fontSize: 11,
      ),
    );
  }
}

class _FooterBottomBar extends StatelessWidget {
  const _FooterBottomBar();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 24,
      runSpacing: 10,
      children: [
        Text(
          '© 2026 Ahmad Bilal · Built with Flutter',
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: AppColors.subtle),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_rounded, size: 13, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              'Crafted with passion',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: AppColors.subtle),
            ),
          ],
        ),
      ],
    );
  }
}
