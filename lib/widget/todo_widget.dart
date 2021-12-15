import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/page/edit_todo_page.dart';
import 'package:todo_app/provider/todos.dart';

import '../utils.dart';

class TodoWidget extends ConsumerWidget {
  final Todo todo;

  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  void editTodo(BuildContext context, Todo todo) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => EditTodoPage(todo: todo)));

  @override
  Widget build(BuildContext context, WidgetRef ref) => ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        child: buildTodo(context, ref),
        key: Key(todo.id),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) => editTodo(context, todo),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                final todos = ref.watch(todosProvider.notifier);

                todos.removeTodo(todo.id);
                Utils.showSnackBar(context, 'Task deleted');
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
      ));

  Widget buildTodo(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider.notifier);

    return GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (_) {
                  todos.toggleIsDone(todoId: todo.id);

                  Utils.showSnackBar(context,
                      todo.isDone ? 'Task marked incomplete' : 'Task complete');
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Text(todo.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 22)),
                    if (todo.description.isNotEmpty)
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(todo.description,
                              style:
                                  const TextStyle(fontSize: 20, height: 1.5)))
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              )
            ])));
  }
}
