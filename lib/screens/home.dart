import 'package:flutter/material.dart';
import 'package:stockmaster/screens/adc_item_screen.dart';
import 'package:stockmaster/theme/colors.dart';
import 'package:stockmaster/widgets/total_itens_util.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double itemWidth = calculateItemWidth(context);

    return Scaffold(
      backgroundColor: AppColors.lightblack,
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          decoration: buildBodyContainerDecoration(),
          child: buildBodyContent(itemWidth),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  double calculateItemWidth(BuildContext context) {
    // Calcula a largura dos contêineres TotalItens e ValorTotal com base na largura da tela
    return (MediaQuery.of(context).size.width - 40) / 2 - 5;
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Stock Master',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.lightblack,
      elevation: 0,
    );
  }

  BoxDecoration buildBodyContainerDecoration() {
    // Configuração da decoração do corpo
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }

  Widget buildBodyContent(double itemWidth) {
    // Conteúdo do corpo
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          buildUserGreeting(),
          const SizedBox(height: 20),
          buildTotalItemsAndValue(itemWidth),
        ],
      ),
    );
  }

  Row buildUserGreeting() {
    // Linha de saudação do usuário
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Olá, Usuário!',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buildHistoryIcon(),
      ],
    );
  }

  Container buildHistoryIcon() {
    // Ícone de histórico
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(131, 78, 78, 81),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: const Icon(
        Icons.restore,
        color: AppColors.white,
      ),
    );
  }

  Row buildTotalItemsAndValue(double itemWidth) {
    // Linha contendo TotalItens e ValorTotal
    return Row(
      children: [
        Flexible(
          child: SizedBox(
            width: itemWidth,
            child: const TotalItens(),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: SizedBox(
            width: itemWidth,
            child: const ValorTotal(),
          ),
        ),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton() {
  // Botão de ação flutuante para adicionar itens
  return FloatingActionButton.extended(
    onPressed: () {
      // Navegar para a tela adcItem
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const AdcItem()),
      );
    },
    icon: const Icon(Icons.add),
    label: const Text(
    'Adicionar Item',
    style: TextStyle(
      color: AppColors.white, // Defina a cor do texto como branco
    ),
  ),
  backgroundColor: AppColors.orange, // Define a cor do botão como laranja
  );
}
}
