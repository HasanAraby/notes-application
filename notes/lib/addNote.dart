import 'package:flutter/material.dart';
import 'package:notes/sqldb.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  SqlDb sqlDb = SqlDb();

  GlobalKey formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Form(
                  key: formState,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: note,
                        decoration: InputDecoration(
                          hintText: 'note',
                        ),
                      ),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(
                          hintText: 'title',
                        ),
                      ),
                      TextFormField(
                        controller: color,
                        decoration: InputDecoration(
                          hintText: 'color',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                          child: Text('Add note'),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () async {
                            int response = await sqlDb.insertData('''
                    INSERT INTO notes ("note", "color", "title")
                    VALUES ("${note.text}", "${title.text}", "${color.text}")
                    ''');
                            if (response > 0) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'home', (context) => false);
                            }
                          }),
                    ],
                  ))
            ],
          ),
        ));
  }
}
