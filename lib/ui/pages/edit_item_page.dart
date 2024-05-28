import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/item_model.dart';

class EditItemPage extends StatefulWidget {
  final ItemModel? item;
  final Function(ItemModel) onSave;

  const EditItemPage({super.key, this.item, required this.onSave});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
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
                decoration: const InputDecoration(labelText: 'Descrição do Item'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição para o item';
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
                      id: widget.item?.id ?? const Uuid().v4(),
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
