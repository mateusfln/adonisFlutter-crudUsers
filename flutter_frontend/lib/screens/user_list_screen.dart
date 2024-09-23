import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import '../widgets/user_dialog.dart';
import '../widgets/user_list_tile.dart';

class UserListScreen extends StatefulWidget {
  
  final UserService userService;

  UserListScreen({Key? key, required this.userService}) : super(key: key); // Modificando o construtor

  
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserService userService = UserService();
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    users = [];
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    users = await widget.userService.fetchUsers();
    setState(() {});
  }

  void showAddUserDialog() {
    _showUserDialog(
      title: 'Adicionar Usuário',
      onSubmit: (User user) async {
        await userService.addUser(user);
        await fetchUsers();
      },
    );
  }

  void showEditUserDialog(User user) {
    _showUserDialog(
      title: 'Editar Usuário',
      user: user,
      onSubmit: (User updatedUser) async {
        await userService.updateUser(updatedUser);
        await fetchUsers();
      },
    );
  }

  void _showUserDialog({
    required String title,
    User? user,
    required Function(User) onSubmit,
  }) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    if (user != null) {
      usernameController.text = user.username;
      emailController.text = user.email;
      passwordController.text = user.password;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UserDialog(
          title: title,
          usernameController: usernameController,
          emailController: emailController,
          passwordController: passwordController,
          onSave: () async {
            if (user == null) {
              final newUser = User(
                id: 0,
                username: usernameController.text,
                email: emailController.text,
                password: passwordController.text,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
              await onSubmit(newUser);
            } else {
              final updatedUser = User(
                id: user.id, // Mantendo o ID existente
                username: usernameController.text,
                email: emailController.text,
                password: passwordController.text, // Inclua isso se a senha precisar ser atualizada
                createdAt: user.createdAt, // Mantendo a data de criação
                updatedAt: user.updatedAt // Atualizando a data de modificação
              );
              await onSubmit(updatedUser);
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> deleteUser(int id) async {
    await userService.deleteUser(id);
    await fetchUsers();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Usuários',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
    ),
    body: users.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nenhum usuário encontrado.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  'Clique no botão "+" para adicionar.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          )
        : _buildUserList(),
    floatingActionButton: FloatingActionButton(
      onPressed: showAddUserDialog,
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
      tooltip: 'Adicionar Usuário',
    ),
  );
}


  Widget _buildUserList() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserListTile(
          user: users[index],
          onEdit: () => showEditUserDialog(users[index]),
          onDelete: () => deleteUser(users[index].id),
        );
      },
    );
  }
}

