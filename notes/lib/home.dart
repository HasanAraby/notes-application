import 'package:flutter/material.dart';
import 'package:notes/sqldb.dart';
import 'editNote.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  List notes = [];
  bool isLoading = true;

  readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Container(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: notes.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                    title: Text(notes[i]['note']),
                    subtitle: Text(notes[i]['title']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              int response = await sqlDb.deleteData(
                                  "DELETE FROM notes WHERE id = ${notes[i]['id']}");
                              if (response > 0) {
                                notes.removeWhere((element) =>
                                    element['id'] == notes[i]['id']);
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blue,
                            )),
                        IconButton(
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNote(
                                        data: notes[i],
                                      )));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                      ],
                    )),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addNote');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
