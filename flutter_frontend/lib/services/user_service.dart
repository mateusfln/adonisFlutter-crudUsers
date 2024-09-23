import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserService {
  final String baseUrl = 'http://localhost:3333/users';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    }
    throw Exception('Failed to load users');
  }

  Future<void> addUser(User user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': user.username,
        'email': user.email,
        'password': user.password,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add user');
    }
  }

  Future<void> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': user.username,
        'email': user.email,
        'password': user.password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }
}
