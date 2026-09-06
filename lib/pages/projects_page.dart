import 'package:flutter/material.dart';

import '../core/layout.dart';
import '../core/routes.dart';
import '../data/projects.dart';
import '../theme/app_theme.dart';
import '../theme/palette.dart';
import '../widgets/site_scaffold.dart';
import '../widgets/ui.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteScaffold(
      currentRoute: Routes.work,
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
                const SectionHeading('Work', glyph: '仕事'),
                const SizedBox(height: 26),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: kProseWidth),
                  child: Text(
                    'Six things I have built and can defend line by line. Each '
                    'one carries a seal naming what it actually does.',
                    style: gothic(size: 16, color: Palette.mist, height: 1.85),
                  ),
                ),
                const SizedBox(height: 44),
                for (int i = 0; i < kProjects.length; i++) ...[
                  if (i > 0) const Hairline(),
                  _ProjectRow(project: kProjects[i], width: w),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProjectRow extends StatefulWidget {
  const _ProjectRow({required this.project, required this.width});

  final Project project;
  final double width;

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _hot = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final stacked = widget.width < 700;

    final seal = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hanko(p.glyph, size: stacked ? 46 : 56),
        const SizedBox(height: 9),
        SizedBox(
          width: stacked ? 46 : 56,
          child: Text(
            p.reading,
            textAlign: TextAlign.center,
            style: mono(size: 9.5, color: Palette.mist, height: 1.4),
          ),
        ),
      ],
    );

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          p.name,
          style: mincho(
            size: stacked ? 22 : 27,
            weight: FontWeight.w500,
            color: Palette.washi,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kProseWidth),
          child: Text(
            p.summary,
            style: gothic(size: 14.5, color: Palette.mist, height: 1.8),
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [for (final s in p.stack) StackChip(s)],
        ),
        if (p.repoUrl != null || p.live != null) ...[
          const SizedBox(height: 16),
          Wrap(
            spacing: 24,
            runSpacing: 4,
            children: [
              if (p.repoUrl != null)
                TextLink(label: 'Repository', url: p.repoUrl!, size: 13.5),
              if (p.live != null)
                TextLink(label: 'Open the live site', url: p.live!, size: 13.5),
            ],
          ),
        ],
      ],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hot = true),
      onExit: (_) => setState(() => _hot = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 32),
        decoration: BoxDecoration(
          color: _hot ? Palette.konSoft.withOpacity(0.35) : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: _hot ? Palette.kincha : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(left: _hot ? 20 : 0),
          child: stacked
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    seal,
                    const SizedBox(height: 20),
                    body,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    seal,
                    const SizedBox(width: 32),
                    Expanded(child: body),
                  ],
                ),
        ),
      ),
    );
  }
}
