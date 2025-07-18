import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<dynamic> dataList = [];

  Future<void> fetchData() async {
    var apiUrl =
        Uri.parse("http://127.0.0.1:5000/recommend"); // Replace with your API endpoint

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          jsonDecode(response.body) as List<dynamic>;
      setState(() {
        dataList = List<String>.from(responseData);
        debugPrint(responseData.toString());
      });
    } else {
      // Handle error scenario
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flask API Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            if (dataList.isNotEmpty)
              Column(
                children: dataList.map((data) => Text(data)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}