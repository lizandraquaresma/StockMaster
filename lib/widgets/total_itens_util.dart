import 'package:flutter/material.dart';
import 'package:stockmaster/theme/colors.dart';
import 'package:stockmaster/services/product_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TotalItens extends StatefulWidget {
  final String userId;

  const TotalItens({Key? key, required this.userId}) : super(key: key);

  @override
  TotalItensState createState() => TotalItensState();
}

class TotalItensState extends State<TotalItens> {
  late Future<num> quantidadeTotalProdutos;

  
  Future<void> updateTotal() async {
    setState(() {
      quantidadeTotalProdutos = ProductService.getQuantidadeTotalProdutos(widget.userId);
    });
  }

  @override
  void initState() {
    super.initState();
    updateTotal();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      quantidadeTotalProdutos = ProductService.getQuantidadeTotalProdutos(user.uid);
    } else {
      print('Usuário não logado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkgrey,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(25),
        child: FutureBuilder<num>(
          future: quantidadeTotalProdutos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Erro ao carregar a quantidade total de produtos');
            } else {
              num totalProdutos = snapshot.data ?? 0;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Produtos:',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    totalProdutos.toString(),
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

