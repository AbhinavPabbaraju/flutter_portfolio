import 'package:flutter/material.dart';

import '../core/layout.dart';
import '../core/routes.dart';
import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../theme/palette.dart';
import '../widgets/site_scaffold.dart';
import '../widgets/ui.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteScaffold(
      currentRoute: Routes.about,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final pad = gutter(w);

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: pad.horizontal / 2,
              vertical: pad.vertical / 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeading('About', glyph: '経歴'),
                const SizedBox(height: 34),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: kProseWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < Profile.about.length; i++) ...[
                        if (i > 0) const SizedBox(height: 20),
                        Text(
                          Profile.about[i],
                          style: gothic(
                            size: 16,
                            color: i == 0 ? Palette.washi : Palette.mist,
                            height: 1.9,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 64),
                const SectionHeading('What I work with', glyph: '技'),
                const SizedBox(height: 30),
                _Skills(width: w),
                const SizedBox(height: 64),
                const SectionHeading('How I got here', glyph: '道'),
                const SizedBox(height: 30),
                const _Timeline(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Skills extends StatelessWidget {
  const _Skills({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final stacked = width < 700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < Profile.skills.length; i++) ...[
          if (i > 0) ...[
            const SizedBox(height: 22),
            const Hairline(),
            const SizedBox(height: 22),
          ],
          Builder(
            builder: (context) {
              final group = Profile.skills[i];
              final label = Text(
                group.group,
                style: mincho(
                  size: 17,
                  weight: FontWeight.w500,
                  color: Palette.washi,
                ),
              );
              final chips = Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final item in group.items) StackChip(item),
                ],
              );

              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [label, const SizedBox(height: 12), chips],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 230, child: label),
                  const SizedBox(width: 28),
                  Expanded(child: chips),
                ],
              );
            },
          ),
        ],
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < Profile.timeline.length; i++)
          _TimelineEntry(
            entry: Profile.timeline[i],
            isLast: i == Profile.timeline.length - 1,
          ),
      ],
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({required this.entry, required this.isLast});

  final ({String when, String what, String where}) entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 26,
            child: Stack(
              children: [
                // The spine. It stops at the final marker rather than
                // trailing off into empty space.
                if (isLast)
                  Positioned(
                    left: 3.5,
                    top: 0,
                    child: Container(width: 1, height: 8, color: Palette.hairline),
                  )
                else
                  const Positioned(
                    left: 3.5,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                      width: 1,
                      child: ColoredBox(color: Palette.hairline),
                    ),
                  ),
                Positioned(
                  left: 0,
                  top: 6,
                  child: Container(width: 8, height: 8, color: Palette.kincha),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 6, bottom: isLast ? 0 : 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.when,
                    style: mono(size: 11.5, color: Palette.asagi, spacing: 0.6),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    entry.what,
                    style: mincho(
                      size: 18,
                      weight: FontWeight.w500,
                      color: Palette.washi,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.where,
                    style: gothic(size: 14, color: Palette.mist),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
