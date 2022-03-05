import 'package:flutter/material.dart';
import 'package:mugglevideo/player.dart';

// ignore: camel_case_types
class info extends StatefulWidget {
  final dynamic episode;
  final String image;
  final String name;
  const info(
      {Key? key,
      required this.episode,
      required this.image,
      required this.name})
      : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: movie
          ? SafeArea(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          player(link: widget.episode['Movie']),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage(widget.image),
                    ),
                    Text(widget.name),
                  ],
                ),
              ),
            )
          : SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: noOfSeason,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        print(
                            widget.episode[(index + 1).toString()]['episode']);
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
