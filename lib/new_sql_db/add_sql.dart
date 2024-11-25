import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nhp/new_sql_db/dummy_data.dart';
import 'package:nhp/new_sql_db/new_dabase_model.dart';

class AddSql extends StatefulWidget {
  const AddSql({super.key});

  @override
  State<AddSql> createState() => _AddSqlState();
}

class _AddSqlState extends State<AddSql> {
  TextEditingController _controller = TextEditingController();
  NewDatabaseModel dbModel = NewDatabaseModel();
  List fetchAllData = [];

  @override
  void initState() {
    _loadData();
    // TODO: implement initState
    super.initState();
  }

  _loadData() async {
    await dbModel.fetchData();
    setState(() {});
    fetchAllData = dbModel.fetchAllData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dbModel.insertData(dummyData: dummyData);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await dbModel.resetTable();
                _loadData();
                setState(() {});
              },
              icon: Icon(Icons.local_activity))
        ],
        title: Text("Add Sql Lite"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: fetchAllData.length,
                  itemBuilder: (context, index) {
                    var data = jsonDecode(fetchAllData[index]['dummyData']);
                    print(data);

                    print("print data ");
                    return ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                setState(() {});
                                if (_controller.text.isEmpty) {
                                  _controller.text = data["name"];
                                }
                                await dbModel.updateStudent(
                                    name: _controller.text, id: data['id']);
                                _loadData();
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () async {
                                setState(() {});

                                await dbModel.deletedata(id: data['id']);
                                _loadData();
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                      title: Text(data[0]['items'][index]['title'].toString()),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
