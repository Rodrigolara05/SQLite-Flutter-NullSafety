import 'package:flutter/material.dart';

import 'screen/home.dart';

void main() => runApp(new MaterialApp(
      title: "Mis notas",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blueAccent[400]),
      home: new HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomeScreen()
      },
    ));
