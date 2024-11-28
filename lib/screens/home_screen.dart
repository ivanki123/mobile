import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> quotes = [
    "Віра в себе — початок будь-якого шляху.",
    "Великі справи починаються з маленьких кроків.",
    "Кожен день — це нова можливість.",
    "Сьогодні найкращий день для початку.",
    "Успіх — це результат наполегливості."
  ];

  final Map<int, String> cardQuotes = {};

  String getRandomQuote() {
    final random = Random();
    return quotes[random.nextInt(quotes.length)];
  }

  void setQuoteForCard(int index) {
    setState(() {
      cardQuotes[index] = getRandomQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Головна сторінка'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            tooltip: 'Перейти до профілю',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 6, // Кількість карток
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setQuoteForCard(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    cardQuotes[index] ?? 'Картка ${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
