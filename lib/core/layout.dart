import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Two breakpoints, three layouts.
///
///   < 760   phone    stacked, top bar
///   < 1120  tablet   stacked, top bar, wider gutters
///   >= 1120 desktop  persistent vertical nav rail on the left
class Breakpoints {
  const Breakpoints._();
  static const double tablet = 760;
  static const double desktop = 1120;
}

bool isPhone(double w) => w < Breakpoints.tablet;
bool isDesktop(double w) => w >= Breakpoints.desktop;

/// Pick a value for the current width. Keeps responsive code on one line
/// instead of scattering ternaries through the widget tree.
T pick<T>(double w, {required T sm, required T md, required T lg}) =>
    w >= Breakpoints.desktop ? lg : (w >= Breakpoints.tablet ? md : sm);

/// Page gutters, measured against the *content* width rather than the window,
/// since the desktop rail and the max-width cap both eat into it.
EdgeInsets gutter(double w) => EdgeInsets.symmetric(
      horizontal: w >= 900 ? 72 : (w >= 700 ? 48 : 22),
      vertical: w >= 900 ? 76 : (w >= 700 ? 60 : 44),
    );

/// Above this content width a section can afford two columns side by side.
const double kTwoColumn = 820;

/// Widest a column of prose is allowed to get. Roughly 68 characters at our
/// body size, which is inside the comfortable reading range.
const double kProseWidth = 640;

/// Widest the page content gets on very large monitors.
const double kContentWidth = 1080;

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// True when the reader has asked the OS to reduce motion.
bool prefersReducedMotion(BuildContext context) =>
    MediaQuery.maybeOf(context)?.disableAnimations ?? false;
