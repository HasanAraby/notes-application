import 'package:flutter/material.dart';
import 'package:notes/sqldb.dart';

class EditNote extends StatefulWidget {
  final Map data;
  const EditNote({super.key, required this.data});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();

  GlobalKey formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    super.initState();
    note.text = widget.data['note'];
    title.text = widget.data['title'];
    color.text = widget.data['color'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Edit')),
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
                          child: Text('SAVE'),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () async {
                            int response = await sqlDb.updateData('''
                    UPDATE notes SET
                     note = "${note.text}",
                     title = "${title.text}",
                      color = "${color.text}"
                      WHERE id = ${widget.data['id']}
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
