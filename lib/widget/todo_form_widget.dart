import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget(
      {Key? key,
      this.title = "",
      this.description = "",
      required this.onChangedTitle,
      required this.onChangedDescription,
      required this.onSavedTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildTitle(),
        const SizedBox(height: 8),
        buildDescription(),
        const SizedBox(height: 32),
        buildSaveButton(),
      ],
    ));
  }

  Widget buildTitle() => TextFormField(
      initialValue: title,
      decoration: const InputDecoration(
          labelText: "Title", border: UnderlineInputBorder()),
      validator: (title) {
        if ((title as String).isEmpty) {
          return "Title is required";
        }
        return null;
      },
      onChanged: onChangedTitle);

  Widget buildDescription() => TextFormField(
      initialValue: description,
      maxLines: 3,
      decoration: const InputDecoration(
          labelText: "Description", border: UnderlineInputBorder()),
      validator: (description) {
        if (description!.isEmpty) {
          return "Description is required";
        }
        return null;
      },
      onChanged: onChangedDescription);

  Widget buildSaveButton() => SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: onSavedTodo,
        child: const Text("Save"),
      ));
}
