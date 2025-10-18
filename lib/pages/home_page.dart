import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'add_item_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> itens = [];

  void carregarItens() async {
    final data = await DBHelper().getItens();
    setState(() {
      itens = data;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarItens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Lista')),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (context, index) {
          final item = itens[index];
          return ListTile(
            title: Text(item['titulo']),
            subtitle: Text(item['descricao']),
            trailing: Text(item['data']),
            onTap: () async {
              final deletado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(item: item),
                ),
              );
              if (deletado == true) carregarItens();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final inserido = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddItemPage()),
          );
          if (inserido == true) carregarItens();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
