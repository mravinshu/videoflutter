import 'package:flutter/material.dart';

class info extends StatefulWidget {
  final List<String> episode;
  final int season;
  const info({Key? key, required this.episode, required this.season})
      : super(key: key);

  @override
  _infoState createState() => _infoState();
}

class _infoState extends State<info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          widget.season > 0
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.season,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        for (var i = 0; i < widget.season; i++)
                          ElevatedButton(
                            onPressed: null,
                            child: Text(
                              (index + 1).toString(),
                            ),
                          ),
                      ],
                    );
                  },
                )
              : Text("Movie h")
        ],
      ),
    );
  }
}
