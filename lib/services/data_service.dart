import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockmaster/database/db_firestore.dart';

class DataService {
  static Future<void> reloadData(String userId, List<Product> productList, bool isLoading, Function setState) async {
    setState(() {
      // Marque a página como "carregando" enquanto os novos dados estão sendo buscados
      isLoading = true;
    });

    try {
      // Carregue os dados do Firestore novamente
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('products')
          .get();

      // Limpe a lista de produtos
      productList.clear();

      // Adicione os novos produtos à lista
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        // Crie um objeto Product com os dados do Firestore
        Product product = Product(
          title: data['title'],
          description: data['description'],
          quantity: data['quantity'],
          price: data['price'],
        );

        // Adicione o produto à lista
        productList.add(product);
      });
    } catch (e) {
      // Lidar com erros, se houver
      print('Erro ao carregar os dados: $e');
    }

    setState(() {
      // Marque a página como "carregada"
      isLoading = false;
    });
  }
}
