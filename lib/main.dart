import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/Veri.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Veri>> _veriGetir() async {
    var response = await http.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((veri) => Veri.fromJsonMap(veri))
          .toList();
    } else {
      throw Exception("Hata ! ${response.statusCode}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _veriGetir(),
        builder: (BuildContext context, AsyncSnapshot<List<Veri>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text("Title"),
                          subtitle: Text("Body"),
                          leading: Text("Id"),
                          trailing: Text("User Id"),
                        ),
                        Divider(
                          thickness: 5,
                        ),
                        ListTile(
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].body),
                          leading: CircleAvatar(
                            child: Text(snapshot.data[index].id.toString()),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.blueAccent.shade100,
                            child: Text(snapshot.data[index].userId.toString()),
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        )
                      ],
                    );
                  }
                  return Column(
                    children: [
                      ListTile(
                        title: Text(snapshot.data[index].title),
                        subtitle: Text(snapshot.data[index].body),
                        leading: CircleAvatar(
                          child: Text(snapshot.data[index].id.toString()),
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.blueAccent.shade100,
                          child: Text(snapshot.data[index].userId.toString()),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                      )
                    ],
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
