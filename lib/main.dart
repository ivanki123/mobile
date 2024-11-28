import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;
  String inputText = '';

  void _processInput(String input) {
    if (input.toLowerCase() == 'avada kedavra') {
      setState(() {
        counter = 0;
      });
      return;
    }

    final parsedNumber = int.tryParse(input);
    if (parsedNumber != null) {
      setState(() {
        counter += parsedNumber;
      });
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Помилка'),
        content: Text('Введений текст не є числом!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ОК'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Креативний Лічильник'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Введіть число або текст',
              ),
              onChanged: (value) {
                inputText = value;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _processInput(inputText),
              child: Text('Обробити'),
            ),
            SizedBox(height: 32),
            Text(
              'Інкремент: $counter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}