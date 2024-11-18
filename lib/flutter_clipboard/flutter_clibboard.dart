import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class FlutterClipBoardExample extends StatefulWidget {
  const FlutterClipBoardExample({super.key});

  @override
  State<FlutterClipBoardExample> createState() =>
      _FlutterClipBoardExampleState();
}

class _FlutterClipBoardExampleState extends State<FlutterClipBoardExample> {
  final message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Clipboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: message,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (message.text.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("TextFrom is empty ")));
                      } else {
                        FlutterClipboard.copy(message.text).then((value) {});
                      }
                    },
                    child: Text("Copy")),
                ElevatedButton(
                    onPressed: () {
                      FlutterClipboard.paste().then((value) {
                        setState(() {
                          message.text = value;
                        });
                      });
                    },
                    child: Text("Past"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
