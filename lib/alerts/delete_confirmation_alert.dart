import 'package:flutter/material.dart';

void showDeleteConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Tem certeza de que deseja excluir este produto?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o alerta sem excluir
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: onConfirm,
            child: const Text('Confirmar'),
          ),
        ],
      );
    },
  );
}
