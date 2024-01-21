import 'package:flutter/material.dart';
import 'package:stockmaster/theme/colors.dart';
import 'package:stockmaster/screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final String userId;
  final String productId;
  final String title;
  final String description;
  final String quantity;
  final String price;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const ProductCard({
    required this.userId,
    required this.productId,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Abrir a tela flutuante com os detalhes do produto
        showModalBottomSheet(
          context: context,
          builder: (context) => ProductDetailsScreen(
            title: title,
            description: description,
            quantity: quantity,
            price: price,
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: AppColors.white,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(color: AppColors.lightblack),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(color: AppColors.lightgrey),
              ),
              Text(
                'Quantidade: $quantity',
                style: const TextStyle(color: AppColors.lightgrey),
              ),
              Text(
                'Valor: ${double.parse(price).toStringAsFixed(2)}',
                style: const TextStyle(color: AppColors.lightgrey),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEditPressed,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDeletePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
