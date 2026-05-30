import 'todo_model.dart';

class TodoStack {
  List<TodoModel> stack = [];

  // PUSH
  void push(TodoModel todo) {
    stack.add(todo);
  }

  // POP
  TodoModel? pop() {
    if (stack.isEmpty) {
      return null;
    }

    return stack.removeLast();
  }

  // PEEK
  TodoModel? peek() {
    if (stack.isEmpty) {
      return null;
    }

    return stack.last;
  }

  // OBTENER TODOS
  List<TodoModel> getAll() {
    return stack.reversed.toList();
  }
}
