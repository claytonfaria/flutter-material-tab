import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/page/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = 'Todo App';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: const Color(0xFFf6f5ee),
        ),
        home: const HomePage(),
      );
}
