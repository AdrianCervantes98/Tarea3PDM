import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea_dos/home/home_body.dart';
import 'package:tarea_dos/models/todo_remainder.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _todoTextController = TextEditingController();
  TimeOfDay _horario;

  @override
  void dispose() {
    // cerrar bloc
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      drawer: Drawer(
        child: ListView(
          // Drawer elements
          children: <Widget>[
            // Drawer header
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(color: Colors.grey[300]),
                ],
              ),
              currentAccountPicture: CircleAvatar(
                child: FlutterLogo(size: 36),
                backgroundColor: Colors.white,
              ),
              accountName: Text("Usuario ejemplo"),
              accountEmail: Text("user@mail.com"),
            ),
            // Drawer body
            ListTile(
              title: Text("Opcion vacia 1"),
            ),
            ListTile(
              title: Text("Close drawer"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Opcion vacia"),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) {
          _homeBloc = HomeBloc();
          return _homeBloc;
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitialState) {
              _homeBloc.add(OnLoadRemindersEvent());
            }
            return HomeBody(
              homeState: state,
              homeBloc: _homeBloc,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (context) => StatefulBuilder(
              // para refrescar la botton sheet en caso de ser necesario
              builder: (context, setModalState) =>
                  _bottomSheet(context, setModalState),
            ),
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
          ).then(
            (result) {
              if (result != null)
                _homeBloc.add(OnAddElementEvent(todoReminder: result));
            },
          );
          // add reminder to listview
          // bloc add reminder to db
          // TODO: dejarlo como todo
        },
        label: Text("Agregar"),
        icon: Icon(Icons.add_circle),
      ),
    );
  }

  Widget _bottomSheet(BuildContext context, StateSetter setModalState) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24.0,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Agrega recordatorio",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: _todoTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.text_fields,
                  color: Colors.black,
                ),
                labelText: "Ingrese actividad",
                labelStyle: TextStyle(color: Colors.black87),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () {
                    _selectTime(context);
                    // refreshes modal bottom sheet with new hour value
                    setModalState(() {});
                  },
                ),
                Text(
                  _horario == null
                      ? "Seleccione horario"
                      : "${_horario.hour}:${_horario.minute}",
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            MaterialButton(
              child: Text("Guardar"),
              onPressed: () {
                Navigator.of(context).pop(
                  TodoRemainder(
                    todoDescription: "${_todoTextController.text}",
                    hour: "${_horario.format(context)}",
                  ),
                );
                _todoTextController.clear();
                _horario = null;
              },
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (time) {
        if (time != null) {
          _horario = time;
        }
      },
    );
  }
}
