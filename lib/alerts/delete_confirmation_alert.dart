import 'package:flutter/material.dart';

void showDeleteConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza de que deseja excluir este produto?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o alerta sem excluir
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text('Confirmar'),
          ),
        ],
      );
    },
  );
}
