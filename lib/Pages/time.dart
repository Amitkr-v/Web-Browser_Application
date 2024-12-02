import 'package:flutter/material.dart';
import 'dart:async';

class LiveClock extends StatefulWidget {
  @override
  _LiveClockState createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  late Timer _timer;
  String _timeString = "";

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    setState(() {
      _timeString = _formatDateTime(DateTime.now());
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}