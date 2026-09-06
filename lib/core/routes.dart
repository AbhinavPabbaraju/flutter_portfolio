/// Named routes. Kept in one place so the nav, the router and the buttons all
/// refer to the same strings.
class Routes {
  const Routes._();

  static const String home = '/';
  static const String about = '/about';
  static const String work = '/work';

  static const List<({String path, String label})> nav = [
    (path: home, label: 'Home'),
    (path: about, label: 'About'),
    (path: work, label: 'Work'),
  ];
}
