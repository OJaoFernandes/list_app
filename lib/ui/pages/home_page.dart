import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_app/ui/pages/edit_list_page.dart';
import 'package:list_app/ui/pages/list_page.dart';

import '../../cubits/list_cubit.dart';
import '../../cubits/list_state.dart';
import '../widgets/list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas'),
      ),
      body: BlocBuilder<ListCubit, ListState>(
        builder: (context, state) {
          if (state is ListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListLoaded) {
            return ListView.builder(
              itemCount: state.lists.length,
              itemBuilder: (context, index) {
                final list = state.lists[index];
                return ListWidget(
                  list: list,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListPage(list: list)),
                    );
                  },
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditListPage(
                          list: list,
                          onSave: (editedList) {
                            context.read<ListCubit>().updateList(editedList);
                          },
                        ),
                      ),
                    );
                  },
                  onDelete: () {
                    context.read<ListCubit>().deleteList(list.id);
                  },
                );
              },
            );
          } else if (state is ListError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Nenhuma lista encontrada'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditListPage(
                onSave: (newList) {
                  context.read<ListCubit>().addList(newList);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
