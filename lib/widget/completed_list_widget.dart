import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo_widget.dart';

class CompletedListWidget extends ConsumerWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos =
        ref.watch(todosProvider).where((element) => element.isDone).toList();

    return todos.isEmpty
        ? const Center(child: Text('No completed tasks yet'))
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: todos.length,
            separatorBuilder: (context, index) => Container(
                  height: 10,
                ),
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            });
  }
}
