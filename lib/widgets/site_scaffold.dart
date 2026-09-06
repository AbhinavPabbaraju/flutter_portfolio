import 'package:flutter/material.dart';

import '../core/layout.dart';
import '../core/routes.dart';
import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../theme/palette.dart';
import 'ui.dart';

/// The frame every page sits inside.
///
/// Wide windows get a permanent vertical rail on the left with the name set
/// sideways, the way a name runs down the edge of a hanging scroll. Narrower
/// windows collapse that into a top bar. Either way the same three routes are
/// one tap away, and the page itself only has to supply its content.
class SiteScaffold extends StatelessWidget {
  const SiteScaffold({
    super.key,
    required this.currentRoute,
    required this.child,
  });

  final String currentRoute;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.kon,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          if (isDesktop(width)) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _NavRail(currentRoute: currentRoute),
                Expanded(child: _Scroller(child: child)),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBar(currentRoute: currentRoute, width: width),
              Expanded(child: _Scroller(child: child)),
            ],
          );
        },
      ),
    );
  }
}

class _Scroller extends StatelessWidget {
  const _Scroller({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: kContentWidth),
              child: child,
            ),
          ),
          const SiteFooter(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Desktop rail
// ---------------------------------------------------------------------------

class _NavRail extends StatelessWidget {
  const _NavRail({required this.currentRoute});

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 138,
      decoration: const BoxDecoration(
        color: Palette.konDeep,
        border: Border(right: BorderSide(color: Palette.hairlineBrass)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          Center(
            child: Container(width: 9, height: 9, color: Palette.kincha),
          ),
          const SizedBox(height: 28),
          Flexible(
            flex: 3,
            child: ClipRect(
              child: Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    Profile.name,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: mincho(
                      size: 17,
                      weight: FontWeight.w500,
                      color: Palette.washi,
                      spacing: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          for (final item in Routes.nav)
            _NavLink(
              label: item.label,
              route: item.path,
              active: item.path == currentRoute,
            ),
          const Spacer(flex: 2),
          ClipRect(
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  Profile.location,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: mono(size: 10.5, color: Palette.mist, spacing: 1.6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

/// One entry in the rail. The active route is marked by a short brass rule
/// that draws itself in — the same rule used under section headings, so the
/// language of the page is consistent.
class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.route,
    required this.active,
  });

  final String label;
  final String route;
  final bool active;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hot = false;

  void _go() {
    if (widget.active) return;
    Navigator.of(context).pushReplacementNamed(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    final lit = widget.active || _hot;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _go,
        onHover: (v) => setState(() => _hot = v),
        onFocusChange: (v) => setState(() => _hot = v),
        hoverColor: Colors.transparent,
        focusColor: Palette.washi.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  height: 1.5,
                  width: lit ? 14 : 0,
                  color: widget.active ? Palette.kincha : Palette.asagi,
                ),
              ),
              Text(
                widget.label,
                style: gothic(
                  size: 14,
                  weight: widget.active ? FontWeight.w600 : FontWeight.w400,
                  color: lit ? Palette.washi : Palette.mist,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tablet and phone bar
// ---------------------------------------------------------------------------

class _TopBar extends StatelessWidget {
  const _TopBar({required this.currentRoute, required this.width});

  final String currentRoute;
  final double width;

  @override
  Widget build(BuildContext context) {
    final phone = isPhone(width);

    return Container(
      decoration: const BoxDecoration(
        color: Palette.konDeep,
        border: Border(bottom: BorderSide(color: Palette.hairlineBrass)),
      ),
      padding: EdgeInsets.symmetric(horizontal: phone ? 18 : 32, vertical: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Container(width: 8, height: 8, color: Palette.kincha),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                phone ? Profile.shortName : Profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: mincho(
                  size: phone ? 16 : 19,
                  weight: FontWeight.w500,
                  color: Palette.washi,
                  spacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            for (final item in Routes.nav)
              _BarLink(
                label: item.label,
                route: item.path,
                active: item.path == currentRoute,
                compact: phone,
              ),
          ],
        ),
      ),
    );
  }
}

class _BarLink extends StatefulWidget {
  const _BarLink({
    required this.label,
    required this.route,
    required this.active,
    required this.compact,
  });

  final String label;
  final String route;
  final bool active;
  final bool compact;

  @override
  State<_BarLink> createState() => _BarLinkState();
}

class _BarLinkState extends State<_BarLink> {
  bool _hot = false;

  @override
  Widget build(BuildContext context) {
    final lit = widget.active || _hot;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.active
            ? null
            : () => Navigator.of(context).pushReplacementNamed(widget.route),
        onHover: (v) => setState(() => _hot = v),
        onFocusChange: (v) => setState(() => _hot = v),
        hoverColor: Colors.transparent,
        focusColor: Palette.washi.withOpacity(0.05),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 8 : 14,
            vertical: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: gothic(
                  size: widget.compact ? 13 : 14,
                  weight: widget.active ? FontWeight.w600 : FontWeight.w400,
                  color: lit ? Palette.washi : Palette.mist,
                ),
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                height: 1.5,
                width: lit ? 18 : 0,
                color: widget.active ? Palette.kincha : Palette.asagi,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Container(
          color: Palette.konDeep,
          padding: EdgeInsets.symmetric(
            horizontal: pick(width, sm: 24.0, md: 56.0, lg: 88.0),
            vertical: 34,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: kContentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Hairline(color: Palette.hairlineBrass, width: 44),
                  const SizedBox(height: 22),
                  Wrap(
                    spacing: 26,
                    runSpacing: 6,
                    children: [
                      TextLink(
                        label: Profile.email,
                        url: 'mailto:${Profile.email}',
                        monospace: true,
                        size: 13,
                      ),
                      TextLink(
                        label: 'github.com/${Profile.github}',
                        url: 'https://github.com/${Profile.github}',
                        monospace: true,
                        size: 13,
                      ),
                      TextLink(
                        label: 'linkedin.com/in/${Profile.linkedin}',
                        url: 'https://linkedin.com/in/${Profile.linkedin}',
                        monospace: true,
                        size: 13,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Built in Flutter. Type is Shippori Mincho and Zen Kaku '
                    'Gothic New; the wave pattern is drawn on a canvas.',
                    style: gothic(size: 12.5, color: Palette.mist, height: 1.6),
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
