import 'package:flutter/material.dart';
import 'package:nhp/sql_lite/class_helper.dart';
import 'package:nhp/sql_lite/notes';

class SqlHomeNotes extends StatefulWidget {
  const SqlHomeNotes({super.key});

  @override
  State<SqlHomeNotes> createState() => _SqlHomeNotesState();
}

class _SqlHomeNotesState extends State<SqlHomeNotes> {
  DBhelper? dBhelper;
  late Future<List<NotesModel>> fetchNoteList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dBhelper = DBhelper();
    loadData();
  }

  loadData() async {
    fetchNoteList = dBhelper!.retriveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sql Home Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dBhelper!
              .insertdb(NotesModel(
                  title: "third",
                  email: "thrid@gmail.com",
                  description: "this is third email",
                  age: 30))
              .then((value) {
            print("data is insert");
            setState(() {});
            fetchNoteList = dBhelper!.retriveData();
          }).onError((error, trackError) {
            print(error.toString());
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: fetchNoteList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Someting is wrong"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No Data is found");
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        dBhelper!.updateNotes(NotesModel(
                            title: "this is new thie",
                            email: "new email",
                            description: "new eds",
                            age: 40,
                            id: snapshot.data![index].id!));

                        setState(() {
                          fetchNoteList = dBhelper!.retriveData();
                        });
                      },
                      child: Card(
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: const Icon(Icons.delete_forever),
                          ),
                          onDismissed: (direction) {
                            dBhelper!
                                .delete(snapshot.data![index].id)
                                .then((value) {
                              print("id delete");
                            }).onError((error, trackErorr) {
                              print(error.toString());
                            });
                            // snapshot.data!.removeAt(snapshot.data![index].id!);
                          },
                          key: ValueKey(snapshot.data![index].id),
                          child: ListTile(
                            trailing:
                                Text(snapshot.data![index].age.toString()),
                            title: Text(snapshot.data![index].title),
                            subtitle: Text(snapshot.data![index].description),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
