class Spell {
  final int index;
  final String name;
  final String use;

  Spell({
    required this.index,
    required this.name,
    required this.use,
  });

  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      index: json['index'] != null ? int.parse(json['index'].toString()) : 0,
      // Memetakan key 'spell' dari API ke variabel 'name' biar lebih masuk akal
      name: json['spell'] ?? 'Unknown Spell', 
      use: json['use'] ?? 'No description available',
    );
  }
}