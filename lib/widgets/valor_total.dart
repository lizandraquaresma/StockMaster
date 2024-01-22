import 'package:flutter/material.dart';
import 'package:stockmaster/theme/colors.dart';
import 'package:stockmaster/services/product_service.dart';

class ValorTotal extends StatelessWidget {
  final String userId;

  const ValorTotal({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(25),
        child: FutureBuilder<double>(
          future: productService.calculateTotalPrice(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro ao calcular o preço total: ${snapshot.error}');
            } else {
              double totalPrice = snapshot.data ?? 0.0;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'R\$ Total:',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                   totalPrice.toStringAsFixed(2),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
