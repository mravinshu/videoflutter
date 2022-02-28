import 'dart:async';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class info extends StatefulWidget {
  final dynamic episode;
  const info({Key? key, required this.episode}) : super(key: key);

  @override
  _infoState createState() => _infoState();
}

// ignore: camel_case_types
class _infoState extends State<info> {
  int noOfSeason = 0;
  bool movie = false;
  @override
  void initState() {
    super.initState();
    handleSeason();
  }

  void handleSeason() {
    if (widget.episode['Season'] != null) {
      noOfSeason = widget.episode['Season'];
    } else {
      movie = true;
    }
    print(noOfSeason);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: movie
          ? Text("Under Development")
          : SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: noOfSeason,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        print(index);
                      },
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Season " + (index + 1).toString()),
                      )),
                    );
                  }),
            ),
    );
  }
}
