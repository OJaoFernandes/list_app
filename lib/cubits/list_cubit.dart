import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/list_model.dart';
import '../repositories/list_repository.dart';
import 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  final ListRepository _repository;

  ListCubit(this._repository) : super(ListInitial());

  void getLists() async {
    try {
      emit(ListLoading());
      _repository.getLists().listen((lists) {
        emit(ListLoaded(lists));
      });
    } catch (e) {
      emit(ListError('Failed to fetch lists'));
    }
  }

  void addList(ListModel list) async {
    try {
      await _repository.createList(list);
    } catch (e) {
      emit(ListError('Failed to add list'));
    }
  }

  void updateList(ListModel list) async {
    try {
      await _repository.updateList(list);
    } catch (e) {
      emit(ListError('Failed to update list'));
    }
  }

  void deleteList(String id) async {
    try {
      await _repository.deleteList(id);
    } catch (e) {
      emit(ListError('Failed to delete list'));
    }
  }
}
