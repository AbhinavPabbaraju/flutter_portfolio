import 'package:flutter/material.dart';

import '../core/layout.dart';
import '../theme/app_theme.dart';
import '../theme/palette.dart';

/// A one-pixel rule. Structure on this site is carried by rules and spacing
/// rather than by boxing everything into cards.
class Hairline extends StatelessWidget {
  const Hairline({super.key, this.color = Palette.hairline, this.width});

  final Color color;
  final double? width;

  @override
  Widget build(BuildContext context) =>
      Container(height: 1, width: width, color: color);
}

/// Section heading: mincho title with a short brass rule set underneath it.
/// No eyebrow label — the title says what the section is.
class SectionHeading extends StatelessWidget {
  const SectionHeading(this.title, {super.key, this.glyph});

  final String title;

  /// Optional kanji set to the right at low contrast, echoing the project
  /// seals. Decorative but consistent, so it reads as part of the system.
  final String? glyph;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              title,
              style: mincho(
                size: 30,
                weight: FontWeight.w500,
                color: Palette.washi,
                height: 1.2,
              ),
            ),
            if (glyph != null) ...[
              const SizedBox(width: 14),
              Text(
                glyph!,
                style: mincho(
                  size: 20,
                  color: Palette.washi.withOpacity(0.22),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 14),
        const Hairline(color: Palette.kincha, width: 44),
      ],
    );
  }
}

/// A stack or tool name. Monospace because it is machine data — a package
/// name, a language, a protocol — and outlined rather than filled so a long
/// list of them stays quiet.
class StackChip extends StatelessWidget {
  const StackChip(this.label, {super.key, this.accent = false});

  final String label;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final colour = accent ? Palette.asagi : Palette.mist;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: colour.withOpacity(0.32)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: mono(size: 11.5, color: colour, height: 1.2),
      ),
    );
  }
}

/// Filled brass button. Used once per screen, for the single most useful next
/// action. Labels say what happens, in sentence case.
class BrassButton extends StatelessWidget {
  const BrassButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.kincha,
      borderRadius: BorderRadius.circular(2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(2),
        hoverColor: Palette.washi.withOpacity(0.14),
        focusColor: Palette.washi.withOpacity(0.22),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Text(
            label,
            style: gothic(
              size: 14.5,
              weight: FontWeight.w600,
              color: Palette.konDeep,
            ),
          ),
        ),
      ),
    );
  }
}

/// Outlined counterpart to [BrassButton].
class GhostButton extends StatelessWidget {
  const GhostButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(2),
        hoverColor: Palette.washi.withOpacity(0.06),
        focusColor: Palette.washi.withOpacity(0.12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Palette.washi.withOpacity(0.34)),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            label,
            style: gothic(
              size: 14.5,
              weight: FontWeight.w500,
              color: Palette.washi,
            ),
          ),
        ),
      ),
    );
  }
}

/// An inline text link. Underlined on hover and on keyboard focus, so it is
/// discoverable without a mouse.
class TextLink extends StatefulWidget {
  const TextLink({
    super.key,
    required this.label,
    required this.url,
    this.size = 14,
    this.monospace = false,
  });

  final String label;
  final String url;
  final double size;
  final bool monospace;

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final style = widget.monospace
        ? mono(size: widget.size, color: Palette.asagi)
        : gothic(size: widget.size, color: Palette.asagi);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => openUrl(widget.url),
        onHover: (v) => setState(() => _active = v),
        onFocusChange: (v) => setState(() => _active = v),
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            widget.label,
            style: style.copyWith(
              decoration:
                  _active ? TextDecoration.underline : TextDecoration.none,
              decorationColor: Palette.asagi,
            ),
          ),
        ),
      ),
    );
  }
}

/// 判子 — a hanko, the carved personal seal stamped on Japanese documents.
/// Each project gets one, with a kanji that names what the project actually
/// does. It replaces the numbered 01/02/03 markers a project list does not
/// need, since the work is not a sequence.
class Hanko extends StatelessWidget {
  const Hanko(this.glyph, {super.key, this.size = 54});

  final String glyph;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Palette.shu.withOpacity(0.85), width: 1.6),
        borderRadius: BorderRadius.circular(3),
        color: Palette.shu.withOpacity(0.10),
      ),
      child: Text(
        glyph,
        textAlign: TextAlign.center,
        style: mincho(
          size: size * 0.36,
          weight: FontWeight.w600,
          color: Palette.shu.withOpacity(0.95),
          height: 1.1,
        ),
      ),
    );
  }
}

/// Portrait in a hanging-scroll frame: a brass hairline around the photo, with
/// an indigo panel offset behind it. Falls back to a painted monogram if the
/// image asset has not been dropped in yet, so the site always renders.
class Portrait extends StatelessWidget {
  const Portrait({super.key, required this.size, this.asset = 'assets/images/avatar.jpg'});

  final double size;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 20,
      height: size * 1.22 + 20,
      child: Stack(
        children: [
          // Offset panel behind, giving the frame depth without a drop shadow.
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size,
              height: size * 1.22,
              decoration: BoxDecoration(
                color: Palette.konSoft,
                border: Border.all(color: Palette.hairlineBrass),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: size,
              height: size * 1.22,
              decoration: BoxDecoration(
                border: Border.all(color: Palette.kincha.withOpacity(0.7)),
                color: Palette.konDeep,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Image.asset(
                  asset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const _Monogram(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Monogram extends StatelessWidget {
  const _Monogram();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.konSoft,
      alignment: Alignment.center,
      child: Text(
        'AP',
        style: mincho(
          size: 56,
          weight: FontWeight.w500,
          color: Palette.kincha.withOpacity(0.75),
          spacing: 4,
        ),
      ),
    );
  }
}
