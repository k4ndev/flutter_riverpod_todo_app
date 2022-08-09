import 'dart:convert';

class CatFactModel {
  final String fact;
  final int lenght;
  CatFactModel({
    required this.fact,
    required this.lenght,
  });

  CatFactModel copyWith({
    String? fact,
    int? lenght,
  }) {
    return CatFactModel(
      fact: fact ?? this.fact,
      lenght: lenght ?? this.lenght,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fact': fact,
      'lenght': lenght,
    };
  }

  factory CatFactModel.fromMap(Map<String, dynamic> map) {
    return CatFactModel(
      fact: map['fact'] ?? '',
      lenght: map['lenght']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatFactModel.fromJson(String source) => CatFactModel.fromMap(json.decode(source));

  @override
  String toString() => 'CatFactModel(fact: $fact, lenght: $lenght)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CatFactModel &&
      other.fact == fact &&
      other.lenght == lenght;
  }

  @override
  int get hashCode => fact.hashCode ^ lenght.hashCode;
}
