
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

class SerialProvider with ChangeNotifier {
  int _logLength = 0;
  int  get logLength  => _logLength;
  List<String?> _logs = [];
  List<String?>  get logs => _logs;

  SerialProvider(){
    init();
  }

  changeLogLength(int l){
    _logLength = l;
    notifyListeners();
  }

  init(){
    _logLength = 500;
    _logs = List.generate(_logLength, (index) => null);
    notifyListeners();
  }

  getLogger(){
    Timer.periodic(const Duration(milliseconds: 500), (_) {
      String data = "Hello";
      makeLogs(msg: data, type: LogType.DEFAULT);
    });
  }

  makeLogs({required String msg, required LogType type}){
    String date = DateTime.now().toIso8601String();
    String logThis = "$type [$date] : $msg";
    _logs.insert(0, logThis);
    _logs.removeLast();
    print(_logs);
    notifyListeners();
  }


}

enum LogType {
  DEFAULT,
  DEBUG,
  ERROR,
  WARNING,
  UNKNOWN
}

