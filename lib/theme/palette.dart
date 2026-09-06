import 'package:flutter/material.dart';

/// Colours are named after the Japanese dyes they come from, so the palette
/// stays coherent instead of drifting into a generic dark theme.
///
///   kon      紺   deep indigo of aizome-dyed cloth — the ground of the site
///   konDeep       recessed surfaces: nav rail, footer
///   konSoft       raised panels behind the portrait and project rows
///   washi    和紙  unbleached paper — primary text
///   mist          muted text on indigo
///   kincha   金茶  brass — the one loud accent, spent sparingly
///   asagi    浅葱  pale teal — links and interactive states
///   shu      朱   seal red — used only inside the hanko marks
class Palette {
  const Palette._();

  static const Color kon = Color(0xFF16273F);
  static const Color konDeep = Color(0xFF0E1A2B);
  static const Color konSoft = Color(0xFF1E3454);
  static const Color washi = Color(0xFFE9E3D3);
  static const Color mist = Color(0xFF9BADC4);
  static const Color kincha = Color(0xFFC9A227);
  static const Color asagi = Color(0xFF6FB3AE);
  static const Color shu = Color(0xFFB7472A);

  static const Color hairline = Color(0x22E9E3D3);
  static const Color hairlineBrass = Color(0x55C9A227);
}
