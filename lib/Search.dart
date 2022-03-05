import 'package:flutter/material.dart';

class searchUi extends StatefulWidget {
  const searchUi({Key? key}) : super(key: key);

  @override
  State<searchUi> createState() => _searchUiState();
}

class _searchUiState extends State<searchUi> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: TextField(
        onChanged: (text) {},
        controller: controller,
      )),
    );
  }
}
