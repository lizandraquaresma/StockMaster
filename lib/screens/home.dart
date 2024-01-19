import 'package:flutter/material.dart';
import 'package:stockmaster/screens/adc_item_screen.dart';
import 'package:stockmaster/services/autenticacao_service.dart';
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
      drawer: Drawer(
        backgroundColor: AppColors.lightblack,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white,),
              title: const Text("Sair",),
              textColor: Colors.white,
              onTap: () async {
                await AutenticacaoServico().deslogar();
                Navigator.pop(context); // Fecha o Drawer após o logout
              },
            )
          ],
        ),
      ),
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
    return (MediaQuery.of(context).size.width - 40) / 2 - 5;
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Home',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.lightblack,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  BoxDecoration buildBodyContainerDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }

  Widget buildBodyContent(double itemWidth) {
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
    return Row(
      children: [
        TotalItens(),
        const SizedBox(width: 10),
        ValorTotal(),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AdcItem()),
        );
      },
      icon: const Icon(Icons.add, color: Colors.white,),
      label: const Text(
        'Adicionar Item',
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.orange,
    );
  }
}
