import 'package:flutter/material.dart';
import 'package:portfolio_ahmad/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

abstract final class _FooterLinks {
  static final Uri whatsApp = Uri.parse('https://wa.me/923087154021');
  static final Uri email = Uri.parse('mailto:ahmadbilal01142@gmail.com');
  static final Uri github = Uri.parse('https://github.com/ahmadch-fd');
}

Future<void> _openFooterLink(Uri uri) async {
  await launchUrl(uri, webOnlyWindowName: '_blank');
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFF070B18)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 72, 24, 34),
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
                          SizedBox(height: 42),
                          _FooterNavigation(),
                          SizedBox(height: 42),
                          _FooterContact(),
                        ],
                      );
                    }

                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: _FooterIdentity()),
                        SizedBox(width: 80),
                        Expanded(flex: 3, child: _FooterNavigation()),
                        SizedBox(width: 80),
                        Expanded(flex: 5, child: _FooterContact()),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 72),
                const Divider(color: Color(0xFF18243A), height: 1),
                const SizedBox(height: 24),
                const _FooterBottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterIdentity extends StatelessWidget {
  const _FooterIdentity();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logopotf.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              'Ahmad Bilal',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.foreground,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Text(
          'Crafting high performance Flutter mobile applications where design meets engineering.',
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: const Color(0xFFD6DEEA), height: 1.65),
        ),
        const SizedBox(height: 26),
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF021D18),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFF00D68F)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00D68F),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'AVAILABLE FOR NEW PROJECTS',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF00D68F),
                    fontSize: 11,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterNavigation extends StatelessWidget {
  const _FooterNavigation();

  static const _items = ['Home', 'Experience', 'Projects', 'Contact'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterTitle('NAVIGATION'),
        const SizedBox(height: 22),
        for (final item in _items) ...[
          Text(
            item,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: const Color(0xFFD6DEEA)),
          ),
          if (item != _items.last) const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _FooterContact extends StatelessWidget {
  const _FooterContact();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterTitle('SOCIAL PULSE'),
        const SizedBox(height: 22),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _SocialButton(
              icon: Icons.code,
              label: 'GitHub',
              uri: _FooterLinks.github,
            ),
            _SocialButton(
              icon: Icons.email_outlined,
              label: 'Email',
              uri: _FooterLinks.email,
            ),
            _SocialButton(
              icon: Icons.phone_in_talk_outlined,
              label: 'WhatsApp',
              uri: _FooterLinks.whatsApp,
            ),
          ],
        ),
        const SizedBox(height: 26),
        _ContactCard(
          icon: Icons.phone_in_talk_rounded,
          label: 'QUICK CHAT',
          value: '+92 3087154021',
          uri: _FooterLinks.whatsApp,
        ),
        const SizedBox(height: 14),
        _ContactCard(
          icon: Icons.email_rounded,
          label: 'EMAIL',
          value: 'ahmadbilal01142@gmail.com',
          uri: _FooterLinks.email,
        ),
        const SizedBox(height: 14),
        _ContactCard(
          icon: Icons.hub_rounded,
          label: 'GITHUB',
          value: 'github.com/ahmadch-fd',
          uri: _FooterLinks.github,
        ),
      ],
    );
  }
}

class _FooterTitle extends StatelessWidget {
  const _FooterTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: AppColors.foreground,
        fontSize: 12,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.5,
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.uri,
  });

  final IconData icon;
  final String label;
  final Uri uri;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _openFooterLink(widget.uri),
        child: AnimatedContainer(
          width: 44,
          height: 44,
          duration: const Duration(milliseconds: 220),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFF17233A)
                : const Color(0xFF111827),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered ? AppColors.primary : const Color(0xFF2A344A),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: _isHovered ? 0.2 : 0,
                ),
                blurRadius: _isHovered ? 22 : 0,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Tooltip(
            message: widget.label,
            child: Icon(widget.icon, color: const Color(0xFFD6DEEA), size: 20),
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.uri,
  });

  final IconData icon;
  final String label;
  final String value;
  final Uri uri;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openFooterLink(uri),
      borderRadius: BorderRadius.circular(12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF0B1020),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF263149)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF00D68F), size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF8792A8),
                        fontSize: 10,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.foreground,
                        fontWeight: FontWeight.w700,
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

class _FooterBottomBar extends StatelessWidget {
  const _FooterBottomBar();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 24,
      runSpacing: 14,
      children: [
        Text(
          '(c) 2026 Ahmad Bilal. Built with passion & Flutter.',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: const Color(0xFF8792A8)),
        ),
        Text(
          'github.com/ahmadch-fd',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: const Color(0xFF8792A8), letterSpacing: 0.8),
        ),
      ],
    );
  }
}
