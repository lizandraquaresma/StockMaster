import 'package:flutter/material.dart';
import 'package:stockmaster/screens/adc_item_screen.dart';
import 'package:stockmaster/screens/edit_product_screen.dart';
import 'package:stockmaster/widgets/valor_total.dart';
import 'package:stockmaster/services/autenticacao_service.dart';
import 'package:stockmaster/database/db_firestore.dart';
import 'package:stockmaster/theme/colors.dart';
import 'package:stockmaster/widgets/total_itens_util.dart';
import 'package:stockmaster/services/data_service.dart';
import 'package:stockmaster/alerts/delete_confirmation_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockmaster/widgets/ProductCard.dart';

class Home extends StatefulWidget {
  final String userId;
  const Home({required this.userId});
  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  final GlobalKey<TotalItensState> totalItensKey = GlobalKey<TotalItensState>();
  List<Product> productList = [];
  bool isLoading = false;
  String? nomeUsuario;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

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
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                "Sair",
              ),
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
      color: AppColors.ice,
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
          const SizedBox(height: 20),
          Expanded(
            child: buildProductList(),
          ),
        ],
      ),
    );
  }

  Row buildUserGreeting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Olá, ${nomeUsuario ?? ''}!',
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buildReloadButton(),
      ],
    );
  }

  Container buildReloadButton() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: IconButton(
        icon: const Icon(
          Icons.refresh,
          color: AppColors.black,
        ),
        onPressed: () {
          // Chame a função para recarregar os dados aqui
          _reloadData();
        },
      ),
    );
  }

  void _loadUserData() async {
    // Carregue o nome do usuário inicialmente
    nomeUsuario = await AutenticacaoServico().getNomeUsuario(widget.userId);
    setState(() {
      _reloadData();
    });
  }

  void _reloadData() async {
    // Chame a função no arquivo DataService
    DataService.reloadData(widget.userId, productList, isLoading, setState);
    // Atualize o total no TotalItens
    totalItensKey.currentState?.updateTotal();
  }

  Row buildTotalItemsAndValue(double itemWidth) {
    return Row(
      children: [
        TotalItens(key: totalItensKey, userId: widget.userId),
        const SizedBox(width: 10),
        ValorTotal(userId: widget.userId),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AdcItem()),
        );
      },
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      label: const Text(
        'Adicionar Item',
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.orange,
    );
  }

// Método para construir a lista de produtos
  Widget buildProductList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('products')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Erro ao carregar os dados: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('Estoque Vazio');
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return ProductCard(
              userId: widget.userId,
              productId: document.id,
              title: data['title'],
              description: data['description'],
              quantity: data['quantity'].toString(),
              price: data['price'].toString(),
              onEditPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return EditProductBottomSheet(
                        userId: widget.userId, 
                        productId: document.id,
                        reloadData: _reloadData,);
                  },
                );
              },
              onDeletePressed: () {
                showDeleteConfirmationDialog(context, () {
                  // Função a ser chamada se o usuário confirmar a exclusão
                  deleteProduct(widget.userId, document.id);
                  _reloadData();
                  Navigator.pop(context); // Fecha o alerta após a exclusão
                });
              },
            );
          },
        );
      },
    );
  }
}
