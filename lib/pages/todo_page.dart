import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';
import '../models/todo_stack.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TodoService todoService = TodoService();
  final TodoStack todoStack = TodoStack();

  List<TodoModel> todos = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchTodos();
  }

  void fetchTodos() async {
    try {
      final data = await todoService.getTodos();
      for (var todo in data) {
        todoStack.push(todo);
      }

      setState(() {
        todos = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error al cargar tareas')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tareas API')),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),

                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final removed = todoStack.pop();

                        if (removed != null && todos.isNotEmpty) {
                          todos.removeLast();
                        }
                      });
                    },

                    child: const Text('Desapilar tarea'),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),

                  color: Colors.blueGrey,

                  child: Text(
                    'Última tarea en pila:\n${todoStack.peek()?.title ?? "Sin tareas"}',

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,

                    itemBuilder: (context, index) {
                      final reversedTodos = todos.reversed.toList();

                      final todo = reversedTodos[index];

                      return ListTile(
                        leading: Icon(
                          todo.completed ? Icons.check_circle : Icons.cancel,
                        ),

                        title: Text(todo.title),

                        subtitle: Text('Usuario: ${todo.userId}'),

                        trailing: Text('#${todo.id}'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
