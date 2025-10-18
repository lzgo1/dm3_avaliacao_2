import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: dataController,
              decoration: const InputDecoration(labelText: 'Data'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (tituloController.text.isNotEmpty &&
                    descricaoController.text.isNotEmpty &&
                    dataController.text.isNotEmpty) {
                  await DBHelper().insertItem({
                    'titulo': tituloController.text,
                    'descricao': descricaoController.text,
                    'data': dataController.text,
                  });
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
