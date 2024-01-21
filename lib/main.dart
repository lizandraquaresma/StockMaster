import 'package:flutter/material.dart';
import 'package:stockmaster/screens/home.dart';
import 'package:stockmaster/screens/Initial_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const AppRouter(),
    );
  }
}

// Roteador de tela baseado no estado de autenticação do usuário
class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          // Se o usuário estiver autenticado, exibe a tela principal (Home)
          if (snapshot.hasData) {
            String userId = snapshot.data!.uid;
            return Home(userId: userId);
          } else {
            // Se o usuário não estiver autenticado, exibe a tela inicial
            return const InitialScreen();
          }
        });
  }
}
