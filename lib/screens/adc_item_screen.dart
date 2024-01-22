import 'package:flutter/material.dart';
import 'package:stockmaster/theme/colors.dart';
import 'package:stockmaster/database/db_firestore.dart';
import 'package:stockmaster/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdcItem extends StatelessWidget {
  AdcItem({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightblack,
      appBar: buildAppBar(),
      body: Container(
        decoration: buildBodyContainerDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              buildInputForm(context), // Passe o contexto para buildInputForm
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

  Widget buildInputForm(BuildContext context) {
    return Column(
      children: [
        buildTextField(
            controller: titleController,
            label: 'Título',
            hintText: 'Informe o título'),
        buildTextField(
            controller: descriptionController,
            label: 'Descrição',
            hintText: 'Informe a descrição'),
        buildTextField(
            controller: quantityController,
            label: 'Quantidade',
            hintText: 'Informe a quantidade',
            keyboardType: TextInputType.number), // Adiciona keyboardType
        buildTextField(
            controller: priceController,
            label: 'Valor',
            hintText: 'Informe o valor',
            keyboardType: const TextInputType.numberWithOptions(decimal: true)),
        buildSubmitButton(context),
      ],
    );
  }

  Widget buildTextField(
      {required TextEditingController controller,
      required String label,
      required String hintText,
      TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: AppColors.black),
        keyboardType: keyboardType, // Adiciona keyboardType
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

  Widget buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          // Obtenha o UID do usuário logado
          String? uid = obterUidUsuarioLogado();

          if (uid != null) {
            // Adiciona o produto ao Firebase Firestore com o UID do usuário
            await addProduct(
              uid,
              Product(
                title: titleController.text,
                description: descriptionController.text,
                quantity: int.parse(quantityController.text),
                price: double.parse(priceController.text),
              ),
            );

            // Limpa os campos após adicionar o produto
            titleController.clear();
            descriptionController.clear();
            quantityController.clear();
            priceController.clear();

            // Exibe uma mensagem de sucesso ou realiza a ação desejada
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Produto adicionado com sucesso!')),
            );

            // Navega de volta para a tela Home após adicionar o produto
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Home(userId: uid)));
          } else {
            // Caso não haja usuário autenticado
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nenhum usuário autenticado')),
            );
          }
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

  String? obterUidUsuarioLogado() {
    // Obtém o usuário atualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    // Verifica se há um usuário autenticado
    if (user != null) {
      // Retorna o UID do usuário autenticado
      return user.uid;
    } else {
      // Caso não haja usuário autenticado
      return null;
    }
  }
}
