import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'video.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muggle Video',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Muggle Video'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<String> name = [];
  static List<int> year = [];
  static List<String> link = [];
  static List<String> image = [];

  void initState() {
    super.initState();
    getDataFromSheets();
  }

  static getDataFromSheets() async {
    var raw = await http.get(
      Uri.parse(
        "https://script.google.com/macros/s/AKfycbwysvzlpbYBMVKaFFOrbGTvLC2BI0Uzg7w1YERfjGaL3n7xZKNpP9cK0kDdGncShwoImw/exec",
      ),
    );

    var jsonData = convert.jsonDecode(raw.body);
    jsonData.forEach((element) {
      name.add(element['name']);
      year.add(element['year']);
      link.add(element['link']);
      image.add(element['image']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: ElevatedButton(
        onPressed: () {
          getDataFromSheets();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    video(image: image, link: link, name: name)),
          );
        },
        child: const Center(child: Text("Click here to Enter..")),
      ),
    );
  }
}
