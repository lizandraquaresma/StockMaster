import 'package:flutter/material.dart';
import 'package:stockmaster/theme/colors.dart';

//Tela modal que apresenta os detalhes do produto
class ProductDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String quantity;
  final String price;

  // Construtor que recebe os detalhes do produto
  ProductDetailsScreen({
    Key? key, // Adicione o parâmetro 'key'
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título centralizado
            Container(
              alignment: Alignment.center,
              child: Text(
                'Detalhes do Produto',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 16),
            // Linhas de detalhes
            _buildDetailRow('Título', title),
            _buildDetailRow('Descrição', description),
            _buildDetailRow('Quantidade', quantity),
            _buildDetailRow('Preço', 'R\$ ${double.parse(price).toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  // Método para construir uma linha de detalhes
  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rótulo da linha
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.darkgrey,
          ),
        ),
        // Valor da linha
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.lightblack,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
