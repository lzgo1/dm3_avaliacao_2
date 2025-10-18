import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> item;
  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item['titulo'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descrição: ${item['descricao']}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Data: ${item['data']}',
                style: const TextStyle(fontSize: 18)),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                final confirm = await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Confirmar exclusão'),
                    content: const Text('Deseja excluir este item?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar')),
                      TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Excluir')),
                    ],
                  ),
                );
                if (confirm == true) {
                  await DBHelper().deleteItem(item['id']);  // ID agora vem do Firestore
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Excluir'),
            )
          ],
        ),
      ),
    );
  }
}
