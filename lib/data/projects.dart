import 'profile.dart';

class Project {
  const Project({
    required this.name,
    required this.glyph,
    required this.reading,
    required this.summary,
    required this.stack,
    this.repoSlug,
    this.live,
  });

  final String name;

  /// The kanji stamped in the project's hanko — what the project does, not
  /// what it is called.
  final String glyph;

  /// Plain-language gloss of [glyph], shown under the seal.
  final String reading;

  final String summary;
  final List<String> stack;

  /// Repository name under the GitHub account. Check these against your
  /// actual repo names before you submit — they are the one thing here that
  /// has to match reality exactly.
  final String? repoSlug;

  final String? live;

  String? get repoUrl =>
      repoSlug == null ? null : 'https://github.com/${Profile.github}/$repoSlug';
}

const List<Project> kProjects = [
  Project(
    name: 'Phalanx',
    glyph: '合意',
    reading: 'consensus',
    summary:
        'A distributed key–value store with Raft written from scratch in Go. '
        'Around 8,000 lines behind 115 tests and 9 benchmarks: a '
        'segment-based write-ahead log, an MVCC state machine, a snapshot '
        'system, a linearizability checker, a chaos-testing harness, '
        'Prometheus metrics and Kubernetes manifests. Every real bug I hit '
        'while building it is written up in the repository.',
    stack: ['Go', 'Raft', 'MVCC', 'Prometheus', 'Kubernetes'],
    repoSlug: 'phalanx',
  ),
  Project(
    name: 'ricc',
    glyph: '翻訳',
    reading: 'translation',
    summary:
        'An optimising compiler for a Rust-inspired language, targeting '
        'x86-64 Linux. Roughly 6,200 lines of C++23 covering a hand-written '
        'lexer and parser, a two-phase semantic analyser, a three-address '
        'code intermediate representation, five optimisation passes and a '
        'linear-scan register allocator. No parser generator, no LLVM.',
    stack: ['C++23', 'x86-64', 'TAC IR', 'CMake'],
    repoSlug: 'ricc',
  ),
  Project(
    name: 'Argus',
    glyph: '審査',
    reading: 'review',
    summary:
        'An AI pull-request reviewer built the way a staff engineer would '
        'scope it: architecture decision records first, then Pydantic v2 '
        'domain contracts, Protocol interfaces, PostgreSQL with HNSW vector '
        'indexing and a 54-test contract suite. The metric that matters is '
        'comment precision at or above 0.80, measured by its own evaluation '
        'harness rather than by vibes.',
    stack: ['Python', 'Pydantic v2', 'PostgreSQL', 'HNSW'],
    repoSlug: 'argus',
  ),
  Project(
    name: 'Astrophysics Visualization Engine',
    glyph: '星図',
    reading: 'star chart',
    summary:
        'Nine subsystems rendering galaxies on the GPU in the browser, on top '
        'of an N-body physics core verified against known solutions before '
        'anything was drawn. Built with Next.js and React Three Fiber.',
    stack: ['Next.js', 'React Three Fiber', 'WebGL', 'TypeScript'],
    repoSlug: 'ave',
  ),
  Project(
    name: 'Penumbra',
    glyph: '協働',
    reading: 'working together',
    summary:
        'A real-time collaborative task platform on Node, Express and '
        'Socket.io. Task dependencies are a live graph with breadth-first '
        'traversal and cycle detection, rendered through a d3-force engine, '
        'alongside an automation engine, GitHub and iCal integrations, '
        'role-based access control and virtual scrolling. Nothing shipped '
        'without a real user problem behind it.',
    stack: ['Node.js', 'Express', 'Socket.io', 'd3-force'],
    repoSlug: 'penumbra',
  ),
  Project(
    name: 'F1 2026 Dashboard',
    glyph: '速度',
    reading: 'speed',
    summary:
        'Race analytics driven entirely by live data — Jolpica, OpenF1 and '
        'Open-Meteo — with a Monte Carlo race simulator running in a web '
        'worker so the interface never blocks. Twenty-four circuit paths are '
        'baked as SVG, and onboarding hands you a paddock pass over an '
        'interactive globe.',
    stack: ['JavaScript', 'Web Workers', 'Monte Carlo', 'SVG'],
    repoSlug: 'f1-dashboard',
    live: 'https://f1-dashboard-mu.vercel.app',
  ),
];
