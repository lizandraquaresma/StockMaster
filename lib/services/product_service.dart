import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  //Função que calcula a quantidade total de produtos
  static Future<num> getQuantidadeTotalProdutos(String userId) async {
    try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('products')
        .get();

    num quantidadeTotal = 0;

    // Iterar pelos documentos e somar as quantidades
    querySnapshot.docs.forEach((doc) {
      quantidadeTotal += doc['quantity'] ?? 0;
    });

    return quantidadeTotal;
  } catch (e) {
    print('Erro ao recuperar a quantidade total de produtos: $e');
    return 0;
  }
  }

  //Função que calcula o preço total dos produtos em estoque
  Future<double> calculateTotalPrice(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('products')
          .get();

      double totalPrice = 0.0;

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        double price = data['price'] ?? 0.0;
        int quantity = data['quantity'] ?? 0;
        totalPrice += price * quantity;
      });

      return totalPrice;
    } catch (e) {
      print('Erro ao calcular o preço total: $e');
      return 0.0;
    }
  }
}
