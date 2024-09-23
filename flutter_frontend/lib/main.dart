import 'package:flutter/material.dart';
import 'services/user_service.dart';
import 'screens/user_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD de Usuários',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserListScreen(userService: UserService()), // Passando o UserService
    );
  }
}
