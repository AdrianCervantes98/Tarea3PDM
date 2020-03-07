import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tarea_dos/home/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:tarea_dos/models/todo_remainder.dart';

void main() async {
  // inicializar antes de crear app
  WidgetsFlutterBinding.ensureInitialized();
  // acceso al local storage
  final _local_storage = await path_provider.getApplicationDocumentsDirectory();
  // inicializar hive
  Hive.init(_local_storage.path);
  // agregar adapter
  Hive.registerAdapter(TodoRemainderAdapter());
  // abrir una caja
  await Hive.openBox("reminders");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.grey[50],
      ),
      home: HomePage(),
    );
  }
}
