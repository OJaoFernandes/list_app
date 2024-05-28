import 'item_model.dart';

class ListModel {
  String id;
  String name;
  List<ItemModel> items;

  ListModel({
    required this.id,
    required this.name,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  static ListModel fromMap(Map<String, dynamic> map) {
    return ListModel(
      id: map['id'],
      name: map['name'],
      items: List<ItemModel>.from(map['items']?.map((item) => ItemModel.fromMap(item))),
    );
  }
}
