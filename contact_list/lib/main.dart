import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  List? data;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Contacts"),
        ),
        body: new Container(
          child: new Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: new FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('data_repo/contacts.json'),
                builder: (context, snapshot) {
                  // Decode the JSON
                  var new_data = json.decode(snapshot.data.toString());

                  return new ListView.builder(
                    // Build the ListView
                    itemBuilder: (BuildContext context, int index) {
                      return new ListTile(
                          leading: CircleAvatar(
                              child: Text(jsonEncode(
                                  new_data[index]['first_name'])[1])),
                          title: new Text(new_data[index]['first_name'] +
                              " " +
                              new_data[index]['last_name']),
                          trailing: new Text(
                            new_data[index]['address'],
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ));
                    },
                    itemCount: new_data == null ? 0 : new_data.length,
                  );
                }),
          ),
        ));
  }
}
