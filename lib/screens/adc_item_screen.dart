import 'package:flutter/material.dart';
import 'package:stockmaster/theme/colors.dart';

class AdcItem extends StatelessWidget {
  const AdcItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightblack,
      appBar: buildAppBar(),
      body: Container(
        decoration: buildBodyContainerDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildInputForm(),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Cadastro de Produtos',
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
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      color: AppColors.ice,
    );
  }

  Widget buildInputForm() {
    return Column(
      children: [
        buildTextField(label: 'Título', hintText: 'Informe o título'),
        buildTextField(label: 'Descrição', hintText: 'Informe a descrição'),
        buildTextField(label: 'Quantidade', hintText: 'Informe a quantidade'),
        buildTextField(label: 'Valor', hintText: 'Informe o valor'),
        buildSubmitButton(),
      ],
    );
  }

  Widget buildTextField({required String label, required String hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: const TextStyle(color: AppColors.black),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Adicione aqui a lógica para processar os dados do formulário
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          textStyle: const TextStyle(fontSize: 24),
        ),
        child: const Text('Adicionar Produto'),
      ),
    );
  }
}
