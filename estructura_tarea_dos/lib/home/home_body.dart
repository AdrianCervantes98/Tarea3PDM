import 'package:flutter/material.dart';
import 'package:tarea_dos/home/item_reminder.dart';
import 'package:tarea_dos/models/todo_remainder.dart';

import 'bloc/home_bloc.dart';

class HomeBody extends StatefulWidget {
  final HomeState homeState;
  final HomeBloc homeBloc;
  HomeBody({
    Key key,
    @required this.homeState,
    @required this.homeBloc,
  }) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<TodoRemainder> _remindersList = List();
  @override
  Widget build(BuildContext context) {
    if (widget.homeState is NoRemindersState) {
      return Center(child: Text("Agrega tu primer recordatorio."));
    }
    if (widget.homeState is NewReminderState) {
      TodoRemainder _reminder = (widget.homeState as NewReminderState).todo;
      _remindersList.add(_reminder);
      widget.homeBloc.add(OnReminderAddedEvent());
    }
    if (widget.homeState is LoadedRemindersState) {
      _remindersList = (widget.homeState as LoadedRemindersState).todosList;
      widget.homeBloc.add(OnReminderAddedEvent());
    }
    return ListView.builder(
      itemCount: _remindersList.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.indigo,
            child: Icon(
              Icons.delete,
              color: Colors.grey[100],
            ),
          ),
          child: ItemRemainder(
            reminder: _remindersList[index].todoDescription,
            time: _remindersList[index].hour,
          ),
          onDismissed: (direction) {
            widget.homeBloc.add(OnRemoveElementEvent(removedAtIndex: index));
            setState(() {
              _remindersList.removeAt(index);
            });
          },
        );
      },
    );
  }
}
