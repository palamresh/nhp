import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';

class StreakTrackerPage extends StatefulWidget {
  @override
  _StreakTrackerPageState createState() => _StreakTrackerPageState();
}

class _StreakTrackerPageState extends State<StreakTrackerPage> {
  int streakCounter = 0;
  List<DateTime> streakDates = [];
  Timer? _timer;
  int _elapsedSeconds = 0;
  DateTime? lastAccessDate;
  bool isDialogShownToday = false;

  @override
  void initState() {
    super.initState();
    _loadStreakData();
    _startTimer();
    _checkDailyReset();
  }

  Future<void> _loadStreakData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      streakCounter = prefs.getInt('streakCounter') ?? 0;
      streakDates = (prefs.getStringList('streakDates') ?? [])
          .map((date) => DateTime.parse(date))
          .toList();
      lastAccessDate =
          DateTime.tryParse(prefs.getString('lastAccessDate') ?? '');
      isDialogShownToday = prefs.getBool('isDialogShownToday') ?? false;
    });
  }

  Future<void> _saveStreakData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('streakCounter', streakCounter);
    prefs.setStringList(
      'streakDates',
      streakDates.map((date) => date.toIso8601String()).toList(),
    );
    prefs.setString('lastAccessDate', DateTime.now().toIso8601String());
    prefs.setBool('isDialogShownToday', isDialogShownToday);
  }

  void _checkDailyReset() {
    final now = DateTime.now();
    if (lastAccessDate == null || !_isSameDay(lastAccessDate!, now)) {
      if (lastAccessDate != null &&
          !_isSameDay(lastAccessDate!, now.subtract(Duration(days: 1)))) {
        // User missed a day, reset streak
        setState(() {
          streakCounter = 0;
          streakDates.clear();
        });
      }
      // Reset daily dialog flag
      setState(() {
        isDialogShownToday = false;
      });
      _saveStreakData();
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        if (_elapsedSeconds == 30 && !isDialogShownToday) {
          // 5 minutes
          _showDialog();
          _incrementStreak();
          isDialogShownToday = true; // Mark dialog as shown
          _saveStreakData();
        }
      });
    });
  }

  void _incrementStreak() {
    final today = DateTime.now();
    if (!streakDates.any((date) => _isSameDay(date, today))) {
      setState(() {
        streakDates.add(today);
        streakCounter++;
      });
      _saveStreakData();
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Congratulations!'),
        content: Text('You have spent 5 minutes in the app today!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCalendar() {
    showModalBottomSheet(
      context: context,
      builder: (context) => TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.orangeAccent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        selectedDayPredicate: (day) =>
            streakDates.any((date) => _isSameDay(date, day)),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(streakCounter.toString()),
        leading: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: _showCalendar,
        ),
      ),
      body: Center(
        child: Text(
          'Your current streak is $streakCounter days!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
