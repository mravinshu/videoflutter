// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mugglevideo/player.dart';
import 'package:rive/rive.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'dart:convert' as convert;

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
        home: const MyHomePage(
          title: "Muggle Video",
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isEmp = true;
  static List<String> name = [];
  static List<int> year = [];
  static List<String> link = [];
  static List<String> image = [];
  Timer? _everySecond;

  @override
  void initState() {
    super.initState();
    _everySecond = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          isEmp = name.isEmpty;
        });
      },
    );
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
      body: isEmp
          ? const Center(
              child: RiveAnimation.asset("new_file.riv"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoApp(link[index]),
                      ),
                    );
                  },
                  child: Card(
                    child: Text(name[index]),
                  ),
                );
              },
            ),
    );
  }
}
