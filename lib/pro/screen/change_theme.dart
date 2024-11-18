import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nhp/pro/screen/task_provider.dart';
import 'package:nhp/pro/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({super.key});

  @override
  State<ChangeTheme> createState() => ChangeThemeState();
}

class ChangeThemeState extends State<ChangeTheme> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Theme"),
        actions: [
          Switch(
              value: provider.isDarkMode,
              onChanged: (value) {
                provider.toggleTheme();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: "Add Task", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  var task = _controller.text;
                  context.read<TaskProvider>().addTask(task);
                  _controller.clear();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Add Task"),
                )),
            SizedBox(
              height: 20,
            ),
            Expanded(child:
                Consumer<TaskProvider>(builder: (context, provider, child) {
              return ListView.builder(
                  itemCount: provider.tasts.length,
                  itemBuilder: (context, index) {
                    var tasks = provider.tasts[index];
                    return ListTile(
                      title: Text(tasks),
                      trailing: IconButton(
                          onPressed: () {
                            provider.removeTask(index);
                          },
                          icon: Icon(Icons.delete)),
                    );
                  });
            }))
          ],
        ),
      ),
    );
  }
}
