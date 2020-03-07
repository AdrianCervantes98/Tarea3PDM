import 'package:flutter/material.dart';

class ItemRemainder extends StatelessWidget {
  final String reminder;
  final String time;
  ItemRemainder({
    Key key,
    @required this.reminder,
    @required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.live_help),
            title: Text(reminder),
          ),
          ListTile(
            leading: Icon(Icons.timer),
            title: Text(time),
          ),
        ],
      ),
    );
  }
}
