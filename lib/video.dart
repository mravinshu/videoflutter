import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mugglevideo/player.dart';

// ignore: camel_case_types
class video extends StatefulWidget {
  final List<String> name;
  final List<String> link;
  final List<String> image;
  const video({
    Key? key,
    required this.image,
    required this.link,
    required this.name,
  }) : super(key: key);

  @override
  _videoState createState() => _videoState();
}

// ignore: camel_case_types
class _videoState extends State<video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoApp(widget.link[index]),
                ),
              );
            },
            child: Card(
              child: Text(widget.name[index]),
            ),
          );
        }));
  }
}
