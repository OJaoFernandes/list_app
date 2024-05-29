import 'dart:async';

import '../../models/item_model.dart';
import '../../models/list_model.dart';
import '../list_repository.dart';

class DummyListRepository implements ListRepository {
  final List<ListModel> _lists = [
    ListModel(
      id: '1',
      name: 'Groceries',
      items: [
        ItemModel(
            id: '1',
            description: 'Milk',
            created: DateTime.now(),
            modified: DateTime.now()),
        ItemModel(
            id: '2',
            description: 'Bread',
            created: DateTime.now(),
            modified: DateTime.now()),
      ],
    ),
    ListModel(
      id: '2',
      name: 'Tasks',
      items: [
        ItemModel(
            id: '1',
            description: 'Laundry',
            created: DateTime.now(),
            modified: DateTime.now()),
        ItemModel(
            id: '2',
            description: 'Homework',
            created: DateTime.now(),
            modified: DateTime.now()),
      ],
    ),
  ];

  final StreamController<List<ListModel>> _controller =
      StreamController<List<ListModel>>();

  bool throwErrorOnGetLists = false;
  bool throwErrorOnCreateList = false;
  bool throwErrorOnUpdateList = false;
  bool throwErrorOnDeleteList = false;

  DummyListRepository() {
    _controller.add(_lists);
  }

  @override
  Stream<List<ListModel>> getLists() async* {
    if (throwErrorOnGetLists) {
      throw Exception('Failed to fetch lists');
    }
    yield* _controller.stream;
  }

  @override
  Future<void> createList(ListModel list) async {
    if (throwErrorOnCreateList) {
      throw Exception('Failed to add list');
    }
    _lists.add(list);
    _controller.add(_lists);
  }

  @override
  Future<void> updateList(ListModel list) async {
    if (throwErrorOnUpdateList) {
      throw Exception('Failed to update list');
    }
    final index = _lists.indexWhere((l) => l.id == list.id);
    if (index != -1) {
      _lists[index] = list;
      _controller.add(_lists);
    }
  }

  @override
  Future<void> deleteList(String id) async {
    if (throwErrorOnDeleteList) {
      throw Exception('Failed to delete list');
    }
    _lists.removeWhere((list) => list.id == id);
    _controller.add(_lists);
  }

  @override
  Future<void> deleteItem(String listId, String itemId) async {
    final listIndex = _lists.indexWhere((list) => list.id == listId);
    if (listIndex != -1) {
      final list = _lists[listIndex];
      final itemIndex = list.items.indexWhere((item) => item.id == itemId);
      if (itemIndex != -1) {
        list.items.removeAt(itemIndex);
        _controller.add(_lists);
      }
    }
  }
}
