// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'my_button.dart';
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCansel;
   DialogBox({Key? key, required this.controller,required this.onSave,required this.onCansel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepOrangeAccent,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new text",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text:"Save",onPressed:onSave),
                const SizedBox(width: 8,),
                MyButton(text:'Cancel',onPressed:onCansel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
