import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:list_app/cubits/list_cubit.dart';
import 'package:list_app/cubits/list_state.dart';
import 'package:list_app/models/list_model.dart';
import 'package:list_app/repositories/impl/dummy_repository_impl.dart';

void main() {
  group('ListCubit', () {
    late ListCubit listCubit;
    late DummyListRepository dummyRepository;

    setUp(() {
      dummyRepository = DummyListRepository();
      listCubit = ListCubit(dummyRepository);
    });

    tearDown(() {
      listCubit.close();
    });

    test('initial state is ListInitial', () {
      expect(listCubit.state.runtimeType, ListInitial);
    });

    group('getLists', () {
      blocTest<ListCubit, ListState>(
        'emits [ListLoading, ListLoaded] when lists are loaded successfully',
        build: () => listCubit,
        act: (cubit) => cubit.getLists(),
        expect: () => [
          isA<ListLoading>(),
          isA<ListLoaded>(),
        ],
      );

      blocTest<ListCubit, ListState>(
        'emits [ListLoading, ListError] when an exception occurs',
        build: () {
          dummyRepository.throwErrorOnGetLists = true;
          return listCubit;
        },
        act: (cubit) => cubit.getLists(),
        expect: () => [isA<ListError>()],
      );
    });

    group('addList', () {
      final newList = ListModel(id: '3', name: 'New List', items: []);

      blocTest<ListCubit, ListState>(
        'adds a new list successfully',
        build: () => listCubit,
        act: (cubit) => cubit.addList(newList),
        verify: (_) async {
          final lists = await dummyRepository.getLists().first;
          expect(lists.contains(newList), isTrue);
        },
      );

      blocTest<ListCubit, ListState>(
        'emits [ListError] when an exception occurs',
        build: () {
          dummyRepository.throwErrorOnCreateList = true;
          return listCubit;
        },
        act: (cubit) => cubit.addList(newList),
        expect: () => [isA<ListError>()],
      );
    });

    group('updateList', () {
      final updatedList = ListModel(id: '1', name: 'Updated List', items: []);

      blocTest<ListCubit, ListState>(
        'updates a list successfully',
        build: () => listCubit,
        act: (cubit) => cubit.updateList(updatedList),
        verify: (_) async {
          final lists = await dummyRepository.getLists().first;
          expect(lists.any((list) => list.id == updatedList.id && list.name == 'Updated List'), isTrue);
        },
      );

      blocTest<ListCubit, ListState>(
        'emits [ListError] when an exception occurs',
        build: () {
          dummyRepository.throwErrorOnUpdateList = true;
          return listCubit;
        },
        act: (cubit) => cubit.updateList(updatedList),
        expect: () => [isA<ListError>()],
      );
    });

    group('deleteList', () {
      const listId = '1';

      blocTest<ListCubit, ListState>(
        'deletes a list successfully',
        build: () => listCubit,
        act: (cubit) => cubit.deleteList(listId),
        verify: (_) async {
          final lists = await dummyRepository.getLists().first;
          expect(lists.any((list) => list.id == listId), isFalse);
        },
      );

      blocTest<ListCubit, ListState>(
        'emits [ListError] when an exception occurs',
        build: () {
          dummyRepository.throwErrorOnDeleteList = true;
          return listCubit;
        },
        act: (cubit) => cubit.deleteList(listId),
        expect: () => [isA<ListError>()],
      );
    });
    group('deleteItem', () {
      const listId = '1';
      const itemId = '1';

      blocTest<ListCubit, ListState>(
        'deletes an item successfully',
        build: () => listCubit,
        act: (cubit) => cubit.deleteItem(listId, itemId),
        verify: (_) async {
          final lists = await dummyRepository.getLists().first;
          final updatedList = lists.firstWhere((list) => list.id == listId);
          expect(updatedList.items.any((item) => item.id == itemId), isFalse);
        },
      );

      blocTest<ListCubit, ListState>(
        'emits [ListError] when an exception occurs',
        build: () {
          dummyRepository.throwErrorOnDeleteItem = true;
          return listCubit;
        },
        act: (cubit) => cubit.deleteItem(listId, itemId),
        expect: () => [isA<ListError>()],
      );
    });
  });
}
