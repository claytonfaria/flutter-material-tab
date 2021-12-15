import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo_form_widget.dart';

class AddTodoDialogWidget extends ConsumerStatefulWidget {
  const AddTodoDialogWidget({Key? key}) : super(key: key);

  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends ConsumerState<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add Todo",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                const SizedBox(
                  height: 8,
                ),
                TodoFormWidget(
                  onChangedTitle: (title) => setState(() => this.title = title),
                  onChangedDescription: (description) =>
                      setState(() => this.description = description),
                  onSavedTodo: addTodo,
                )
              ],
            )));
  }

  void addTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final todos = ref.watch(todosProvider.notifier);

      final newTodo = Todo(
          title: title,
          description: description,
          isDone: false,
          createdTime: DateTime.now(),
          id: DateTime.now().toString());

      todos.addTodo(newTodo);

      Navigator.pop(context);
    }
  }
}
