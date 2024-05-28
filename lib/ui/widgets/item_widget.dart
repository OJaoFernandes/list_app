import 'package:flutter/material.dart';
import 'package:list_app/models/item_model.dart';

class ItemWidget extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ItemWidget({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.description),
      subtitle: Text('Criado em: ${item.created}'),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirmar Exclusão'),
              content: const Text('Tem certeza que deseja excluir este item?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    onDelete();
                    Navigator.pop(context);
                  },
                  child: const Text('Excluir'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
