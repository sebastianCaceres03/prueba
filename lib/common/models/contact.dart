
class Contacts {
  final String? id;
  final String? name;
  final String? dni;

  Contacts({
    this.id,
    this.name,
    this.dni,
  });

  Contacts copyWith({
    String? id,
    String? name,
    String? dni,
  }) {
    return Contacts(
      id: id ?? this.id,
      name: name ?? this.name,
      dni: dni ?? this.dni,
    );
  }

  Contacts.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      name = json['name'] as String?,
      dni = json['dni'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'dni' : dni
  };
}