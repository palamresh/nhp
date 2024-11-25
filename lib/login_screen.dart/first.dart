import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // ignore: unused_field
  PageController _controller = PageController();

  // ignore: prefer_final_fields, unused_field
  int _currentPage = 0;
  @override
  void initState() {
    _checkOpenCount();
    super.initState();
  }

  void _checkOpenCount() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.clear();

    var currentDate = DateTime.now().toIso8601String().split('T').first;

    // get store date and opencout

    var storeDate = sp.getString("storeDate");
    var openCount = sp.getInt("openCount") ?? 0;
    print(openCount);

    if (currentDate == storeDate) {
      if (openCount == 2) {
        await sp.setInt("openCount", openCount + 1);
        _showWelcomeDialog();
      } else {
        await sp.setInt("openCount", openCount + 1);
      }
    } else {
      await sp.setString("storeDate", currentDate);
      await sp.setInt('openCount', openCount + 1);
    }
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Welcome'),
        content: Text('Welcome to open my app for the 3rd time today!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var date = DateTime.now().toIso8601String().split("T").first;

          print(date);
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              children: [
                _buildPage1(Colors.pink, "Page1"),
                _buildPage1(Colors.orange, "Page2"),
                _buildPage1(Colors.red, "Page3"),
                _buildPage1(Colors.indigo, "Page4"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildPage1(MaterialColor pink, String s) {
    return Container(
      color: pink,
      child: Center(
        child: Text(
          s,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
