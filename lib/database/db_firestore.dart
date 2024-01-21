import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String title;
  String description;
  int quantity;
  double price;

  // Construtor atualizado com parâmetros nomeados
  Product({
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
  });

  // Converte o objeto Product em um mapa para enviar para o Firebase
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'quantity': quantity,
      'price': price,
    };
  }
}

// Adicionar um produto
Future<void> addProduct(String userId, Product product) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('products')
      .add({
        ...product.toMap(),
        'uidUsuario': userId, // Adiciona o UID do usuário ao produto
      });
}


// Editar um produto
Future<void> editProduct(String userId, String productId, Product updatedProduct) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('products')
      .doc(productId)
      .update({
        'title': updatedProduct.title,
        'description': updatedProduct.description,
        'quantity': updatedProduct.quantity,
        'price': updatedProduct.price,
      });
}



// Excluir um produto
Future<void> deleteProduct(String userId, String productId) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('products')
      .doc(productId)
      .delete();
}

