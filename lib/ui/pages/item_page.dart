import 'package:flutter/material.dart';

import '../../models/item_model.dart';

class ItemPage extends StatefulWidget {
  final String listId;
  final ItemModel? item;
  final Function(ItemModel) onSave;

  const ItemPage({super.key, required this.listId, this.item, required this.onSave});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final _formKey = GlobalKey<FormState>();
  late String _description;

  @override
  void initState() {
    super.initState();
    _description = widget.item?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Adicionar Item' : 'Editar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newItem = ItemModel(
                      id: widget.item?.id ?? DateTime.now().toString(),
                      description: _description,
                      created: widget.item?.created ?? DateTime.now(),
                      modified: DateTime.now(),
                    );
                    widget.onSave(newItem);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
