import 'package:flutter/material.dart';
import 'package:untitled2/service/quote_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<int, String> cardQuotes = {};
  final QuoteService _quoteService = QuoteService();
  bool isLoading = false; // Стан завантаження

  // Встановлення цитати для картки
  void setQuoteForCard(int index) async {
    setState(() {
      isLoading = true; // Встановлюємо стан завантаження
    });

    final quote = await _quoteService.fetchQuote();
    setState(() {
      cardQuotes[index] = quote;
      isLoading = false; // Завершення завантаження
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
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Індикатор завантаження
            : GridView.builder(
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
