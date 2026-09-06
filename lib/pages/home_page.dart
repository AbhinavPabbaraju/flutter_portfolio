import 'package:flutter/material.dart';

import '../core/layout.dart';
import '../core/routes.dart';
import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../theme/palette.dart';
import '../widgets/seigaiha.dart';
import '../widgets/site_scaffold.dart';
import '../widgets/ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteScaffold(
      currentRoute: Routes.home,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Hero(width: w),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: gutter(w).horizontal / 2,
                ),
                child: const Hairline(),
              ),
              _Now(width: w),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _Hero extends StatelessWidget {
  const _Hero({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final wide = width >= kTwoColumn;
    final headlineSize = width >= 900 ? 58.0 : (width >= 700 ? 46.0 : 34.0);

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Profile.headline,
          style: mincho(
            size: headlineSize,
            weight: FontWeight.w500,
            color: Palette.washi,
            height: 1.18,
          ),
        ),
        const SizedBox(height: 26),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kProseWidth),
          child: Text(
            Profile.intro,
            style: gothic(size: 16, color: Palette.mist, height: 1.85),
          ),
        ),
        const SizedBox(height: 34),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            BrassButton(
              label: 'See the work',
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(Routes.work),
            ),
            GhostButton(
              label: 'Read the background',
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(Routes.about),
            ),
          ],
        ),
        const SizedBox(height: 40),
        const _Facts(),
      ],
    );

    final portrait = Portrait(size: wide ? 250 : 172);

    return Stack(
      children: [
        Positioned.fill(
          child: SeigaihaBackdrop(radius: wide ? 92 : 62, opacity: 0.05),
        ),
        Padding(
          padding: gutter(width),
          child: wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: text),
                    const SizedBox(width: 56),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: portrait,
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    portrait,
                    const SizedBox(height: 40),
                    text,
                  ],
                ),
        ),
      ],
    );
  }
}

/// Three plain facts, separated by hairlines rather than punctuation.
class _Facts extends StatelessWidget {
  const _Facts();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (int i = 0; i < Profile.facts.length; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (i > 0)
                Container(
                  width: 1,
                  height: 13,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: Palette.hairline,
                ),
              Text(
                Profile.facts[i],
                style: mono(size: 11.5, color: Palette.mist, spacing: 0.4),
              ),
            ],
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------

class _Now extends StatelessWidget {
  const _Now({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final pad = gutter(width);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: pad.horizontal / 2,
        vertical: 56,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading('What I am building now', glyph: '今'),
          const SizedBox(height: 30),
          for (int i = 0; i < Profile.now.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(height: 20),
              const Hairline(),
              const SizedBox(height: 20),
            ],
            _NowRow(item: Profile.now[i], width: width),
          ],
        ],
      ),
    );
  }
}

class _NowRow extends StatelessWidget {
  const _NowRow({required this.item, required this.width});

  final ({String title, String detail}) item;
  final double width;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      item.title,
      style: mincho(size: 18, weight: FontWeight.w500, color: Palette.washi),
    );
    final detail = Text(
      item.detail,
      style: gothic(size: 14.5, color: Palette.mist, height: 1.7),
    );

    if (width < 700) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [title, const SizedBox(height: 6), detail],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 240, child: title),
        const SizedBox(width: 32),
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kProseWidth),
            child: detail,
          ),
        ),
      ],
    );
  }
}
