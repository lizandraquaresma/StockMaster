import 'package:flutter/material.dart';
import 'package:stockmaster/screens/signin_screen.dart';
import 'package:stockmaster/theme/colors.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ice,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
          Text(
            "Bem-vindo(a) ao StockMaster!",
            style: AppTextStyles.headline1(context),
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

// Classe para centralizar estilos de texto
class AppTextStyles {
  static TextStyle headline1(BuildContext context) {
    return TextStyle(
      color: Colors.black,
      fontSize: MediaQuery.of(context).size.width * 0.06,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle headline2(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.normal,
    );
  }
}

//Classe contendo os textos de introdução ao app
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
            style: AppTextStyles.headline2(context),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Controle de estoque e rastreamento de operações de armazém com base na venda.",
            textAlign: TextAlign.center,
            style: AppTextStyles.body(context),
          ),
        ),
      ],
    );
  }
}

//Botao para prosseguir para o login
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
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: AppColors.orange,
      ),
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: MediaQuery.of(context).size.width * 0.12,
      ),
    );
  }
}
