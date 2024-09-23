import 'package:flutter/material.dart';
import '../models/user.dart';

class UserDialog extends StatelessWidget {
  final String title;
  final User? user;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function() onSave;

  UserDialog({
    required this.title,
    this.user,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      usernameController.text = user!.username;
      emailController.text = user!.email;
      // Não preenchemos a senha por motivos de segurança
    }

    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Nome de Usuário'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          if (user == null) // Exibe o campo de senha apenas ao adicionar um novo usuário
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Fecha o diálogo
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            onSave(); // Chama a função de salvar
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}
