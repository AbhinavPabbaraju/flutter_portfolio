import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

/// Three type roles, each with a job:
///
///   mincho  Shippori Mincho      — display. A Japanese serif; carries the
///                                  personality of every heading.
///   gothic  Zen Kaku Gothic New  — body copy. Open counters, reads long.
///   mono    JetBrains Mono       — machine data only. Repo slugs, stacks,
///                                  line counts. Never used as decoration.
///
/// `GoogleFonts.getFont` is used instead of the generated per-family helpers so
/// the code compiles against any recent google_fonts version.

TextStyle mincho({
  double? size,
  FontWeight? weight,
  Color? color,
  double? height,
  double? spacing,
}) =>
    GoogleFonts.getFont(
      'Shippori Mincho',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: spacing,
    );

TextStyle gothic({
  double? size,
  FontWeight? weight,
  Color? color,
  double? height,
  double? spacing,
}) =>
    GoogleFonts.getFont(
      'Zen Kaku Gothic New',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: spacing,
    );

TextStyle mono({
  double? size,
  FontWeight? weight,
  Color? color,
  double? height,
  double? spacing,
}) =>
    GoogleFonts.getFont(
      'JetBrains Mono',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: spacing,
    );

class AppTheme {
  const AppTheme._();

  static ThemeData build() {
    final base = ThemeData(brightness: Brightness.dark, useMaterial3: true);
    final text = base.textTheme
        .apply(bodyColor: Palette.washi, displayColor: Palette.washi);

    return base.copyWith(
      scaffoldBackgroundColor: Palette.kon,
      canvasColor: Palette.kon,
      dividerColor: Palette.hairline,
      colorScheme: base.colorScheme.copyWith(
        primary: Palette.kincha,
        onPrimary: Palette.konDeep,
        secondary: Palette.asagi,
        onSecondary: Palette.konDeep,
        surface: Palette.kon,
        onSurface: Palette.washi,
      ),
      textTheme: text.copyWith(
        bodyLarge: gothic(size: 16, height: 1.75, color: Palette.washi),
        bodyMedium: gothic(size: 15, height: 1.75, color: Palette.washi),
        bodySmall: gothic(size: 13, height: 1.6, color: Palette.mist),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Palette.hairlineBrass,
      ),
      focusColor: Palette.kincha,
      splashColor: Palette.hairlineBrass,
      highlightColor: Colors.transparent,
    );
  }
}
