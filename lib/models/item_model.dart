class ItemModel {
  String id;
  String description;
  DateTime created;
  DateTime modified;

  ItemModel({
    required this.id,
    required this.description,
    required this.created,
    required this.modified,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'created': created.toIso8601String(),
      'modified': modified.toIso8601String(),
    };
  }

  static ItemModel fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      description: map['description'],
      created: DateTime.parse(map['created']),
      modified: DateTime.parse(map['modified']),
    );
  }
}
