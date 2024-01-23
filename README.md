<p align="center">
  <img src="assets/images/stockmaster.png" alt="StockMaster Logo" width="500">
</p>

O StockMaster é um aplicativo de gerenciamento de estoque desenvolvido em Flutter, que oferece funcionalidades como login, registro de usuários, visualização, cadastro, edição e remoção de produtos. Os dados são armazenados na nuvem usando o Firebase Authentication para autenticação e o Cloud Firestore para o banco de dados.

**Recursos:**
- **Autenticação:** Login e registro de usuários por e-mail via FirebaseAuth.
- **Produtos:** Visualização, cadastro, edição e remoção de produtos.
- **Armazenamento:** Utiliza o Cloud Firestore para armazenar dados na nuvem.
- **Design:** Interface amigável e intuitiva, projetada no Figma.


**Recursos Futuros:**

- **Categorias:** 
  - Os usuarios poderão associar produtos a categorias específicas para facilitar a organização e pesquisa.

- **Histórico de Alterações:** 
  - Vai registrar a entrada e saida de produtos.

- **Perfil do Usuário:** 
  - Os usuários vão gerenciar suas informações e configurações personalizadas.

- **Barra Inferior de Navegação:** 
  - Possibilitará uma navegação mais intuitiva entre as telas do aplicativo.

- **Incremento e Decremento Aprimorados:** 
  - Tornará a interação com a quantidade de produtos mais fácil e precisa, aprimorando a usabilidade do aplicativo.

- **Recuperação de Senha**

- **Login e Registro através de Redes Sociais**

- **Ordenação de Produtos**
  
- **Refinamento das Interfaces**

**Como Rodar o App:**

1. **Instale as Ferramentas:**
   Certifique-se de ter o Flutter, o VS Code, o Android Studio, o Java e o Git instalados em sua máquina.

2. **Clonar o Repositório:**
   ```
   git clone https://github.com/lizandraquaresma/StockMaster.git
   ```

3. **Configurar Dependências:**
   ```
   cd StockMaster
   flutter pub get
   ```

4. **Configurar o Firebase:**
   - Acesse o [Firebase Console](https://console.firebase.google.com/) e crie um novo projeto.
   - Adicione um aplicativo para Android e/ou iOS ao projeto e faça o download dos arquivos de configuração (`google-services.json` para Android e `GoogleService-Info.plist` para iOS).
   - Coloque esses arquivos na pasta apropriada no projeto Flutter (`android/app` para Android e `ios/Runner` para iOS).

5. **Configurar Dependências do Firebase no `pubspec.yaml`:**
   Certifique-se de que as dependências do Firebase estão listadas no arquivo `pubspec.yaml`. Exemplo:
   
   ```yaml
   dependencies:
     firebase_core: ^1.10.6
     firebase_auth: ^4.5.0
     cloud_firestore: ^3.3.0
   ```

   Execute `flutter pub get` para baixar as dependências.

6. **Inicializar o Firebase no Código Flutter:**
   No código Flutter, inicialize o Firebase no início do aplicativo, geralmente no método `main()` ou no método `initState()` de um widget. Exemplo:

   ```dart
   import 'package:firebase_core/firebase_core.dart';

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     runApp(MyApp());
   }
   ```

7. **Executar o App:**
   Certifique-se de ter um emulador Android ou um dispositivo físico conectado.
   ```
   flutter run
   ```

8. **Nota:**
   - Certifique-se de seguir a documentação do Firebase para a versão específica que está utilizando.


9. **Apk**
   - Caso tenha interesse em baixar o apk diretamente no seu dispositivo mobile, utilize o botão:
   - [![StockMaster](https://img.shields.io/badge/Baixar%20APK-Download-blue?style=for-the-badge&logo=android)](https://drive.google.com/uc?export=download&id=1SXvI-HYryFgROk3YnDPcsBHnuFamhgFQ)
   - Você também pode baixar através do link: [StockMaster App](https://drive.google.com/file/d/1SXvI-HYryFgROk3YnDPcsBHnuFamhgFQ/view?usp=sharing)

**Autora:**
Lizandra Quaresma

**Contato:**
- Email: lizandraquaresma.dev@gmail.com
- LinkedIn: [Lizandra Quaresma](https://www.linkedin.com/in/lizandraquaresma/)

**Licença:**
Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.



