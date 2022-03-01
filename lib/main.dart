import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'dart:convert' as convert;
import 'info.dart';

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
  static List<dynamic> link = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(
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
    var raw = await rootBundle.loadString('assets/try.json');
    var jsonData = convert.jsonDecode(raw) as Map<String, dynamic>;
    jsonData.forEach(
      (key, value) {
        name.add(key);
        link.add(value);
      },
    );
  }

  String imageMaker(String name, String image) {
    String newImage = image;
    String nameImage = name;
    newImage = newImage.replaceFirst(
        'https://github.com/', 'https://raw.githubusercontent.com/');
    newImage = newImage.replaceFirst('blob/main/Images/', 'main/Images/');
    newImage = newImage.replaceFirst('blob/web/Images/', 'web/Images/');
    if (newImage != image) {
      newImage = newImage + name + '.jpg';
    }
    if (nameImage.contains(' ')) {
      nameImage = name.replaceAll(' ', '%20');
    }
    if (newImage == '') {
      newImage =
          'https://raw.githubusercontent.com/mravinshu/mugglevideo/main/Images/' +
              nameImage +
              '.jpg';
    }
    return newImage;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);
    int numOfItem = (device.size.width.toInt()) ~/ 200;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: SafeArea(
        child: isEmp
            ? const Center(
                child: RiveAnimation.asset(
                  'assets/new_file.riv',
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numOfItem,
                  childAspectRatio: 1,
                ),
                itemCount: name.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => info(
                            episode: link[index],
                            image: imageMaker(name[index], ""),
                            name: name[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(imageMaker(name[index], "")),
                            height: 150,
                            width: 150,
                          ),
                          Text(
                            name[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
