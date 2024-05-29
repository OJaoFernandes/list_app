import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_app/ui/pages/edit_item_page.dart';

import '../../cubits/list_cubit.dart';
import '../../cubits/list_state.dart';
import '../../models/item_model.dart';
import '../../models/list_model.dart';
import '../widgets/item_widget.dart';

class ListPage extends StatefulWidget {
  final ListModel list;

  const ListPage({super.key, required this.list});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list.name),
      ),
      body: BlocBuilder<ListCubit, ListState>(
        builder: (context, state) {
          if (state is ListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListLoaded) {
            final currentList =
                state.lists.firstWhere((l) => l.id == widget.list.id);
            return ListView.builder(
              itemCount: currentList.items.length,
              itemBuilder: (context, index) {
                final item = currentList.items[index];
                return ItemWidget(
                  item: item,
                  onTap: () async {
                    _navigateToEditItem(context, item);
                  },
                  onDelete: () {
                    context
                        .read<ListCubit>()
                        .deleteItem(widget.list.id, item.id);
                  },
                );
              },
            );
          } else if (state is ListError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Nenhum item encontrado'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddItem(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemPage(
          onSave: (item) {
            context.read<ListCubit>().updateList(
                  ListModel(
                    id: widget.list.id,
                    name: widget.list.name,
                    items: List.from(widget.list.items)..add(item),
                  ),
                );
          },
        ),
      ),
    );
  }

  void _navigateToEditItem(BuildContext context, ItemModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemPage(
          item: item,
          onSave: (updatedItem) {
            final updatedItems = widget.list.items.map((i) {
              if (i.id == item.id) {
                return updatedItem;
              }
              return i;
            }).toList();

            context.read<ListCubit>().updateList(
                  ListModel(
                    id: widget.list.id,
                    name: widget.list.name,
                    items: updatedItems,
                  ),
                );
          },
        ),
      ),
    );
  }
}
