import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stockmaster/screens/signin_screen.dart';
import 'package:stockmaster/services/autenticacao_service.dart';
import 'package:stockmaster/theme/colors.dart';
import 'package:stockmaster/widgets/snackbar.dart';
import 'dart:async';
import 'package:stockmaster/screens/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final AutenticacaoServico _autenticacaoServico = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightblack,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildSliverToBoxAdapter(),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      iconTheme: const IconThemeData(color: AppColors.white),
      backgroundColor: const Color.fromARGB(0, 40, 40, 40),
      expandedHeight: 200.0,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background:
            Image.asset('assets/images/stockmaster.png', fit: BoxFit.cover),
      ),
    );
  }

  SliverToBoxAdapter _buildSliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 20.0),
        decoration: const BoxDecoration(
          color: AppColors.ice,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formSignupKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 20.0),
                _buildTextField(
                    'Nome completo', 'Insira o nome completo', _nomeController,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira seu nome completo!';
                  }
                  return null;
                }),
                const SizedBox(height: 25.0),
                _buildTextField(
                    'Email', 'Insira um Email válido', _emailController,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um Email válido!';
                  }
                  return null;
                }),
                const SizedBox(height: 25.0),
                _buildTextField('Senha', 'Crie uma senha', _senhaController,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira uma senha!';
                  }
                  return null;
                }, obscureText: true),
                const SizedBox(height: 25.0),
                _buildCheckBox(),
                const SizedBox(height: 25.0),
                _buildButton(),
                const SizedBox(height: 30.0),
                _buildDivider(),
                const SizedBox(height: 30.0),
                _buildSocialMediaLogos(),
                const SizedBox(height: 25.0),
                _buildAccountLink(),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Registre-se',
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w900,
        color: AppColors.darkgrey,
      ),
    );
  }

  Widget _buildTextField(String label, String hintText,
      TextEditingController controller, String? Function(String?) validator,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildCheckBox() {
    return Row(
      children: [
        Checkbox(
          value: agreePersonalData,
          onChanged: (bool? value) {
            setState(() {
              agreePersonalData = value!;
            });
          },
          activeColor: AppColors.orange,
        ),
        const Text(
          'Concordo com a ',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
        const Text(
          'Política de privacidade',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _registrarUsuario,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Registrar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            thickness: 0.7,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          child: Text(
            'Registre-se com',
            style: TextStyle(
              color: Colors.black45,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 0.7,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaLogos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Logo(Logos.twitter),
        Logo(Logos.google),
        Logo(Logos.apple),
      ],
    );
  }

  Widget _buildAccountLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Já possui uma conta? ',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (e) => const SignInScreen(),
              ),
            );
          },
          child: const Text(
            'Acesse aqui',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.orange,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _registrarUsuario() async {
    BuildContext currentContext = context; // Capturando o contexto antes da função assíncrona

    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (_formSignupKey.currentState!.validate() && agreePersonalData) {
      String? erro = await _autenticacaoServico.registrarUsuario(
        nome: nome,
        email: email,
        senha: senha,
      );

      if (erro != null) {
        if (!agreePersonalData) {
          MostrarSnackBar(
            context: currentContext,
            texto: 'Concorde com a política de privacidade',
          );
        } else {
          MostrarSnackBar(context: currentContext, texto: erro);
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(
            currentContext,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      }
    }
  }

  void _mostrarSnackBar(
      {required BuildContext context, required String texto}) {
    MostrarSnackBar(context: context, texto: texto);
  }
}
