import '../models/list_model.dart';

abstract class ListRepository {
  Stream<List<ListModel>> getLists();

  Future<void> createList(ListModel list);

  Future<void> updateList(ListModel list);

  Future<void> deleteList(String id);

  Future<void> deleteItem(String listId, String itemId);
}
