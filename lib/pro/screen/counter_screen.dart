import 'package:flutter/material.dart';
import 'package:nhp/pro/counter.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<CounterProvider>(context, listen: false).loadCounter();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("CounterScreen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(builder: (context, provider, child) {
              return Text(provider.count.toString());
            }),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      provider.decreament();
                    },
                    child: Text(
                      "-",
                      style: TextStyle(fontSize: 40),
                    )),
                ElevatedButton(
                    onPressed: () {
                      provider.increate();
                    },
                    child: Icon(Icons.add)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
