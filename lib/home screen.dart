import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:allergy_app/account%20screen.dart';
import 'package:allergy_app/details%20screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _hasPersonalInfo = false;
  bool _processing = false;
  String _riskLevel = "0";
  String _initMessage =
      'Please provide/check your personal details initially to obtain risky level';

  @override
  void initState() {
    super.initState();
    checkAllValuesExist().then((value) {
      if (value) {
        setState(() {
          _processing = true;
          sendData();
        });
      }
    });
  }

  Future<bool> checkAllValuesExist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.containsKey('age') &&
        prefs.containsKey('time_year') &&
        prefs.containsKey('distance2city') &&
        prefs.containsKey('gender') &&
        prefs.containsKey('asthma') &&
        prefs.containsKey('smoking'));
    return prefs.containsKey('age') &&
        prefs.containsKey('time_year') &&
        prefs.containsKey('distance2city') &&
        prefs.containsKey('gender') &&
        prefs.containsKey('asthma') &&
        prefs.containsKey('smoking');
  }

  Future<void> sendData() async {
    final url = Uri.parse('https://allergylevel.codingminds5.repl.co/predict');
    final headers = {'Content-Type': 'application/json'};
    final data = await _getData(); // Your JSON data here

    http
        .post(
      url,
      headers: headers,
      body: jsonEncode(data),
    )
        .then((response) {
      if (response.statusCode == 200) {
        print('Data sent successfully');
        setState(() {
          _hasPersonalInfo = true;
          _riskLevel = response.body;
          _processing = false;
        });
      } else {
        print('Error sending data');
      }
    });
  }

  Future<Map> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'age': prefs.getString('age'),
      'time_year': prefs.getString('time_year'),
      'distance2city': prefs.getString('distance2city'),
      'gender': prefs.getString('gender'),
      'asthma': prefs.getString('asthma'),
      'smoking': prefs.getString('smoking')
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserInfoPage()));
                }),
            IconButton(
                icon: const Icon(Icons.question_mark),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AdviceForUserPage(
                        riskLevel: _riskLevel,
                      )));
                }),
          ]),
      body: _processing
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [CircularProgressIndicator()],
        ),
      )
          : _hasPersonalInfo
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              ' Your RISKY level out of 10 will be... ',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              // If we change this to be a variable, we should remove const from ln 68
                _riskLevel,
                style: const TextStyle(fontSize: 60))
          ],
        ),
      )
          : Center(
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Text(_initMessage))),
    );
  }
}
