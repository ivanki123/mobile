import 'package:flutter/material.dart';

import '../service/radio_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RadioStationService _radioStationService = RadioStationService(); // Ініціалізуємо сервіс для радіостанцій
  bool isLoading = false; // Стан завантаження
  List<RadioStation> stations = []; // Список радіостанцій
  int numberOfStations = 5; // Кількість радіостанцій

  // Завантажуємо радіостанції
  void loadRadioStations() async {
    setState(() {
      isLoading = true;
    });
    try {
      final List<RadioStation> fetchedStations = await _radioStationService.fetchRadioStations(numberOfStations);
      setState(() {
        stations = fetchedStations;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Не вдалося завантажити радіостанції')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Радіостанції'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Введення кількості радіостанцій
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfStations = int.tryParse(value) ?? 5;
                });
              },
              decoration: InputDecoration(
                labelText: 'Введіть кількість радіостанцій',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: loadRadioStations,
              child: Text('Завантажити радіостанції'),
            ),
            SizedBox(height: 20),
            // Якщо ми в стані завантаження, показуємо індикатор
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: stations.length,
                itemBuilder: (context, index) {
                  final station = stations[index];
                  return ListTile(
                    title: Text(station.name),
                    subtitle: Text('Країна: ${station.country}'),
                    onTap: () {
                      // Додаткові дії при натисканні на станцію
                      print('Вибрана станція: ${station.name}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
