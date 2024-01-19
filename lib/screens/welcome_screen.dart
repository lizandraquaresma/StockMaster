import 'package:flutter/material.dart';
import 'package:stockmaster/screens/signin_screen.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bem-vindo(a) ao StockMaster!",
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/banner1.png', height: 300),
          ),
          const SizedBox(height: 40),
          const DescricaoDoApp(),
          const SizedBox(height: 40),
          const BotaoSetaParaDireita(),
        ],
      ),
    );
  }
}

class DescricaoDoApp extends StatelessWidget {
  const DescricaoDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Seu App de gerenciamento de estoque",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Controle de estoque e rastreamento de operações de armazém com base na venda.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

class BotaoSetaParaDireita extends StatelessWidget {
  const BotaoSetaParaDireita({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: const Color(0xFFFFB22E),
      ),
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: MediaQuery.of(context).size.width * 0.11,
      ),
    );
  }
}
