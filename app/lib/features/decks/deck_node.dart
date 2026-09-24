class DeckNode {
  const DeckNode({
    required this.id,
    required this.name,
    required this.newCount,
    required this.learnCount,
    required this.reviewCount,
    required this.filtered,
    required this.children,
  });

  final int id;
  final String name;
  final int newCount;
  final int learnCount;
  final int reviewCount;
  final bool filtered;
  final List<DeckNode> children;
}
