<p align="center">
  <img src="assets/images/stockmaster.png" alt="StockMaster Logo" width="500">
</p>

**Descrição:**
O StockMaster é um aplicativo de gerenciamento de estoque desenvolvido em Flutter, que oferece funcionalidades como login, registro de usuários, visualização, cadastro, edição e remoção de produtos. Os dados são armazenados na nuvem usando o Firebase Authentication para autenticação e o Cloud Firestore para o banco de dados.

**Recursos:**
- **Autenticação:** Login e registro de usuários por e-mail via FirebaseAuth.
- **Produtos:** Visualização, cadastro, edição e remoção de produtos.
- **Armazenamento:** Utiliza o Cloud Firestore para armazenar dados na nuvem.
- **Design:** Interface amigável e intuitiva, projetada no Figma.
- **Organização:** Controle de tarefas com o Trello.

**Como Rodar o App:**

1. **Instale as Ferramentas:**
   Certifique-se de ter o Flutter, o VS Code, o Android Studio e o Git instalados em sua máquina.

2. **Clonar o Repositório:**
   ```
   git clone https://github.com/lizandraquaresma/StockMaster.git
   ```

3. **Configurar Dependências:**
   ```
   cd StockMaster
   flutter pub get
   ```

4. **Executar o App:**
   Certifique-se de ter um emulador Android ou um dispositivo físico conectado.
   ```
   flutter run
   ```

5. **Nota:**
   - É necessário configurar um projeto no [Firebase Console](https://console.firebase.google.com/) e adicionar o arquivo `google-services.json` (para Android) e `GoogleService-Info.plist` (para iOS) ao projeto Flutter para utilizar os serviços do Firebase.

**Autor:**
Lizandra Quaresma

**Contato:**
- Email: lizandraquaresma.dev@gmail.com
- LinkedIn: [Lizandra Quaresma](https://www.linkedin.com/in/seu-linkedin)

**Licença:**
Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.
