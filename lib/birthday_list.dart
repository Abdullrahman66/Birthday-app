import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'user.dart';


class BirthdayList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "Upcoming Birthdays",
          style: TextStyle(fontSize: 28.0),
        ),
      ),
    );
  }
}
