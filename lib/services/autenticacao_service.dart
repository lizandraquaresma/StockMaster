import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> registrarUsuario({
    required String nome,
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
      
      await userCredential.user!.updateDisplayName(nome);

      print('Usuário criado com sucesso: ${userCredential.user?.uid}');
      return null;

    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        print('Email já cadastrado');
      }
      return 'Erro desconhecido';
    }
  }
}
