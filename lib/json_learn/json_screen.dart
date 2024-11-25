import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nhp/json_learn/first_json.dart';
import 'package:nhp/login_screen.dart/first.dart';
import 'package:nhp/sql_lite/new_learn_sql/databasehelper.dart';

import 'model/user_model.dart';

class JsonScreen extends StatefulWidget {
  const JsonScreen({super.key});

  @override
  State<JsonScreen> createState() => _JsonScreenState();
}

class _JsonScreenState extends State<JsonScreen> {
  List<Map<String, Object?>> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {});
          data.add(UserData(email: "Amresh", password: "2423255").toMap());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "JsonScreen S",
          style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25, color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index]['email'].toString()),
            );
          }),
    );
  }
}
