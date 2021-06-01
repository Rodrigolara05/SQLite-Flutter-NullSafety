import 'package:flutter/material.dart';
import 'package:flutter_application_1/connections/startConnection.dart';
import 'package:flutter_application_1/entities/note.dart';

class HomeScreen extends StatefulWidget {
  @override
  Home createState() => Home();
}

class Home extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = new AppBar(
      title: const Text('Mis notas'),
    );

    _createCard(Note note, String title) {
      return new Card(
          child: new Column(
        children: [
          ListTile(title: Text(title), subtitle: Text(note.description!)),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: Text("Editar"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String noteText = note.description!;
                        return AlertDialog(
                          title: Text("Edit Note"),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          content: Container(
                            child: TextField(
                              controller:
                                  new TextEditingController(text: noteText),
                              onChanged: (value) => {noteText = value},
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                      setState(() {
                                        note.description = noteText;
                                        noteDatabase.update(note);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                child: Text("Editar"))
                          ],
                        );
                      });
                },
              ),
              TextButton(
                child: Text("Eliminar"),
                onPressed: () {
                  setState(() {
                    noteDatabase.delete(note);
                  });
                },
              )
            ],
          )
        ],
        mainAxisSize: MainAxisSize.min,
      ));
    }

    _showListCards(BuildContext context) {
      return FutureBuilder(
          future: noteDatabase.getAll(),
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.length > 0) {
                  return (Container(
                      child: new Center(
                          child: new ListView(
                    children: <Widget>[
                      for (var i = 0; i < snapshot.data!.length; i++)
                        _createCard(
                            snapshot.data![i], ("Nota " + (snapshot.data![i].id).toString()))
                    ],
                  ))));
                } else {
                  return Center(child: Text("Agrega una nota"));
                }
              } else {
                return Center(
                  child: Text("Agrega una nota"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
          future: noteDatabase.initDB(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return (_showListCards(context));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String note = "";
                return AlertDialog(
                  title: Text("New Note"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  content: Container(
                    child: TextField(
                      onChanged: (value) => {note = value},
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                              setState(() {
                                noteDatabase.insert(new Note(
                                    description: note,
                                    date: DateTime.now().toString()));
                              });
                              Navigator.of(context).pop();
                            },
                        child: Text("Guardar"))
                  ],
                );
              });
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
