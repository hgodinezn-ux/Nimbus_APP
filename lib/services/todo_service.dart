import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoService {
  Future<List<TodoModel>> getTodos() async {
    final url = 'https://jsonplaceholder.typicode.com/todos';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener tareas');
    }
  }
}
