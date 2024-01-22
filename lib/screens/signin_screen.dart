import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stockmaster/screens/home.dart';
import 'package:stockmaster/screens/signup_screen.dart';
import 'package:stockmaster/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightblack,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(color: AppColors.white),
            backgroundColor: const Color.fromARGB(0, 40, 40, 40),
            expandedHeight: 200.0,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/images/stockmaster.png',
                  fit: BoxFit.cover),
            ),
          ),
             _buildForm(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 20.0),
        decoration: const BoxDecoration(
          color: AppColors.ice,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Form(
          key: _formSignInKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderText(),
              const SizedBox(height: 20.0),
              _buildTextField('Email', 'Insira o email', _emailController,
                  (value) => value == null || value.isEmpty ? 'Email invalido!' : null),
              const SizedBox(height: 25.0),
              _buildTextField('Senha', 'Insira a senha', _senhaController,
                  (value) => value == null || value.isEmpty ? 'Senha invalida!' : null,
                  obscureText: true),
              const SizedBox(height: 25.0),
              _buildRememberMe(),
              const SizedBox(height: 25.0),
              _buildSignInButton(),
              const SizedBox(height: 25.0),
              _buildDivider('Faça o login com'),
              const SizedBox(height: 25.0),
              _buildSocialMediaLogos(),
              const SizedBox(height: 25.0),
              _buildSignUpLink(),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Text(
      'Login',
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
      obscuringCharacter: '*',
      validator: validator,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
        filled: true,
        fillColor: AppColors.white,
        border: _buildOutlineInputBorder(),
        enabledBorder: _buildOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black12,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

   Widget _buildRememberMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberPassword,
              onChanged: (bool? value) {
                setState(() {
                  rememberPassword = value!;
                });
              },
              activeColor: AppColors.orange,
            ),
            const Text(
              'Lembre-se',
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
          ],
        ),

        //Essa função ainda será implementada

        /*GestureDetector(
          onTap: () {
            
          },
          child: const Text(
            'Esqueceu a senha?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.orange,
            ),
          ),
        ),*/
      ],
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: login,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Entrar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            thickness: 0.7,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          child: Text(
            text,
            style: const TextStyle(
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

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Não possui uma conta? ',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (e) => const SignUpScreen(),
              ),
            );
          },
          child: const Text(
            'Registre-se',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.orange,
            ),
          ),
        ),
      ],
    );
  }

  login() async {
    try {
      if (_formSignInKey.currentState!.validate() && rememberPassword) {
        UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _senhaController.text,
        );

        User? user = userCredential.user;

        if (user != null) {
          // Obtendo o UID do usuário logado
          String uid = user.uid;
          // Login bem-sucedido, navegar para a tela Home
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Home(userId: uid))); // Passando o UID para a tela Home
        } else {
          // Algo inesperado aconteceu
          mostrarSnackBar('Erro inesperado ao fazer login');
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        // Email não cadastrado
        mostrarSnackBar('Email não cadastrado. Por favor, registre-se.');
      } else if (e.code == 'wrong-password') {
        // Senha incorreta
        mostrarSnackBar('Senha incorreta!');
      } else {
        // Tratando outras exceções de forma mais genérica
        mostrarSnackBar('Dados invalidas!');
      }
    } catch (e) {
      // Lidando com exceções não relacionadas ao Firebase de forma mais genérica
      mostrarSnackBar('Erro ao fazer login. Por favor, tente novamente.');
    }
  }

  void mostrarSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
