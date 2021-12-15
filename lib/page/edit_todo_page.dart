import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo_form_widget.dart';

class EditTodoPage extends ConsumerStatefulWidget {
  final Todo todo;
  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends ConsumerState<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              final todos = ref.watch(todosProvider.notifier);

              todos.removeTodo(widget.todo.id);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: TodoFormWidget(
                title: title,
                description: description,
                onChangedDescription: (description) =>
                    this.description = description,
                onChangedTitle: (title) => this.title = title,
                onSavedTodo: saveTodo,
              ))));

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final todos = ref.watch(todosProvider.notifier);

      todos.updateTodo(widget.todo.id, title, description);

      Navigator.pop(context);
    }
  }
}
