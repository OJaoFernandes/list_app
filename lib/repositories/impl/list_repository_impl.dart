import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:list_app/repositories/list_repository.dart';

import '../../models/list_model.dart';

class ListRepositoryImpl implements ListRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ListModel>> getLists() {
    return _firestore.collection('lists').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ListModel.fromMap(doc.data())).toList();
    });
  }

  @override
  Future<void> createList(ListModel list) {
    return _firestore.collection('lists').doc(list.id).set(list.toMap());
  }

  @override
  Future<void> updateList(ListModel list) {
    return _firestore.collection('lists').doc(list.id).update(list.toMap());
  }

  @override
  Future<void> deleteList(String id) {
    return _firestore.collection('lists').doc(id).delete();
  }
}
