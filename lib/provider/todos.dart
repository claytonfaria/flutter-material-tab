import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo.dart';

final todosProvider =
    StateNotifierProvider<TodosNotifier, List<Todo>>((ref) => TodosNotifier());

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier()
      : super([
          Todo(
              createdTime: DateTime.now(),
              title: 'Buy milk',
              description: 'Buy milk',
              id: "1"),
          Todo(
              createdTime: DateTime.now(),
              title: 'Go to gym',
              description: 'Go to gym',
              id: "2"),
        ]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggleIsDone({required String todoId}) {
    state = [
      for (final todo in state)
        if (todo.id == todoId) todo.copyWith(isDone: !todo.isDone) else todo
    ];
  }

  void updateTodo(String todoId, String title, String description) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(title: title, description: description)
        else
          todo
    ];
  }
}
