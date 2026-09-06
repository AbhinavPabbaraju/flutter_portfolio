/// All copy and personal data in one file, so the site can be re-pointed at a
/// different person by editing here and nothing else.
class Profile {
  const Profile._();

  static const String name = 'Abhinav Pabbaraju';
  static const String shortName = 'Abhinav';
  static const String location = 'Hyderabad, India';
  static const String email = 'pabhinav2006@gmail.com';
  static const String github = 'AbhinavPabbaraju';
  static const String linkedin = 'abhinav-pabbaraju';
  static const String website = 'https://abhinavpabbaraju.com';

  /// Home page.
  static const String headline = 'I build the layers\nmost people never see.';

  static const String intro =
      'Computer science undergraduate in Hyderabad, working close to the '
      'metal. Consensus protocols, compilers, storage engines — the parts of a '
      'system where correctness is hard to fake and the only way through is to '
      'understand the machine underneath.';

  static const List<String> facts = [
    'Hyderabad, India',
    'B.Tech CSE, 2024 to 2028',
    'Systems engineering',
  ];

  /// Three short lines under the hero. Present tense, no headings.
  static const List<({String title, String detail})> now = [
    (
      title: 'Raft, from scratch',
      detail:
          'Extending Phalanx with snapshot compaction and a chaos-testing rig.',
    ),
    (
      title: 'Optimising ricc',
      detail:
          'A sixth pass over the intermediate representation, then better '
          'register pressure heuristics.',
    ),
    (
      title: 'Flutter interfaces',
      detail:
          'Learning to carry a visual identity across layouts, this site '
          'included.',
    ),
  ];

  /// About page.
  static const List<String> about = [
    'I started out chasing the question of what actually happens when a '
        'program runs, and never really stopped. That led me to compilers, '
        'then to distributed systems, then to the uncomfortable discovery '
        'that most of my early code was wrong in ways the tests never caught.',
    'So I write differently now. I reach for property tests and '
        'linearizability checkers before I reach for a feature, I keep notes '
        'on every real bug I have caused, and I would rather ship one '
        'subsystem I can defend line by line than five I cannot. The projects '
        'below are all built that way.',
    'Outside the terminal I follow Formula One closely and take a lot of my '
        'design cues from Japanese craft — this site is indigo, brass and '
        'paper for that reason.',
  ];

  static const List<({String group, List<String> items})> skills = [
    (
      group: 'Languages',
      items: ['Go', 'C++23', 'Python', 'Dart', 'TypeScript', 'SQL'],
    ),
    (
      group: 'Distributed systems',
      items: [
        'Raft consensus',
        'Write-ahead logs',
        'MVCC',
        'Snapshots',
        'Linearizability testing',
        'Chaos testing',
      ],
    ),
    (
      group: 'Compilers and low-level',
      items: [
        'Lexing and parsing',
        'Semantic analysis',
        'Three-address code IR',
        'Optimisation passes',
        'Register allocation',
        'x86-64',
      ],
    ),
    (
      group: 'Interfaces',
      items: [
        'Flutter',
        'Next.js',
        'React Three Fiber',
        'WebGL',
        'Responsive layout',
      ],
    ),
    (
      group: 'Infrastructure',
      items: [
        'Kubernetes',
        'Prometheus',
        'PostgreSQL',
        'Socket.io',
        'Git',
      ],
    ),
  ];

  /// A genuine sequence, so it earns the vertical timeline treatment.
  static const List<({String when, String what, String where})> timeline = [
    (
      when: '2024 to 2028',
      what: 'B.Tech, Computer Science and Engineering',
      where: 'C.R. Rao AIMSCS, Hyderabad',
    ),
    (
      when: 'Internship',
      what: 'Python backend developer',
      where: 'Cognifyz Technologies, remote',
    ),
    (
      when: 'Certified',
      what: 'Deep Learning Institute',
      where: 'NVIDIA',
    ),
    (
      when: 'Certified',
      what: 'CS50: Introduction to Computer Science',
      where: 'Harvard University',
    ),
    (
      when: 'Certified',
      what: 'AI Fluency',
      where: 'Anthropic',
    ),
  ];
}
