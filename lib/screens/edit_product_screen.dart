import 'package:flutter/material.dart';
import 'package:stockmaster/database/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductBottomSheet extends StatefulWidget {
  final String userId;
  final String productId;
  final VoidCallback reloadData;
  final Key? key; // Adicionando o parâmetro key

  const EditProductBottomSheet({
    required this.userId,
    required this.productId,
    required this.reloadData, 
    this.key,
  }) : super(key: key);

  @override
  EditProductBottomSheetState createState() => EditProductBottomSheetState();
}

class EditProductBottomSheetState extends State<EditProductBottomSheet> {
  
  // Controladores para os campos de edição
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Carrega os dados do produto existente
    loadProductData();
  }

  void loadProductData() async {
    try {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('products')
          .doc(widget.productId)
          .get();

      if (productSnapshot.exists) {
        // Se o produto existir, os controladores estão sendo preenchidos com dados reais
        Map<String, dynamic> productData =
            productSnapshot.data() as Map<String, dynamic>;

        _titleController.text = productData['title'] ?? '';
        _descriptionController.text = productData['description'] ?? '';
        _quantityController.text = productData['quantity'].toString();
        _priceController.text = productData['price'].toString();
      } else {
        // Produto não encontrado
        print('Produto não encontrado para o ID: ${widget.productId}');
      }
    } catch (e) {
      // Lidando com possíveis erros ao buscar dados do produto
      print('Erro ao buscar dados do produto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Editar Produto',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _quantityController,
            decoration: const InputDecoration(labelText: 'Quantidade'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(labelText: 'Preço'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Chame a função de edição aqui, passando os dados atualizados
              Product updatedProduct = Product(
                title: _titleController.text,
                description: _descriptionController.text,
                quantity: int.parse(_quantityController.text),
                price: double.parse(_priceController.text),
              );

              // Chame a função de edição do serviço
              editProduct(widget.userId, widget.productId, updatedProduct);

              // Chame a função de recarregar dados diretamente aqui
              widget.reloadData();

              // Feche o BottomSheet/modal
              Navigator.pop(context);
            },
            child: const Text('Salvar Alterações'),
          ),
        ],
      ),
    );
  }
}
