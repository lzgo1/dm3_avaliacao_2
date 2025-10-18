import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Inserir item no Firestore
  Future<void> insertItem(Map<String, dynamic> item) async {
    await _db.collection('itens').add(item);
  }

  // Buscar itens no Firestore
  Future<List<Map<String, dynamic>>> getItens() async {
    final snapshot = await _db.collection('itens').get();
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id, // Firestore ID
        'titulo': doc['titulo'],
        'descricao': doc['descricao'],
        'data': doc['data'],
      };
    }).toList();
  }

  // Deletar item do Firestore
  Future<void> deleteItem(String id) async {
    await _db.collection('itens').doc(id).delete();
  }
}
