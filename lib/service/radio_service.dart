import 'dart:convert';
import 'package:http/http.dart' as http;


class RadioStationService {
  final String _baseUrl = 'http://89.58.16.19/json/stations/lastclick/'; // API URL

  // Метод для отримання списку радіостанцій
  Future<List<RadioStation>> fetchRadioStations(int numberOfStations) async {
    final response = await http.get(Uri.parse('$_baseUrl$numberOfStations'));

    if (response.statusCode == 200) {
      // Якщо сервер відповів успішно, парсимо JSON
      final List data = json.decode(response.body);
      // Перетворюємо JSON у список об'єктів RadioStation
      return data.map((station) => RadioStation.fromJson(station)).toList();
    } else {
      throw Exception('Не вдалося завантажити радіостанції');
    }
  }
}

class RadioStation {
  final String name;
  final String url;
  final String country;

  RadioStation({required this.name, required this.url, required this.country});

  // Фабричний метод для створення об'єкта з JSON
  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      name: json['name'] ?? 'Без назви',
      url: json['url'] ?? 'Немає URL',
      country: json['country'] ?? 'Невідомо',
    );
  }
}
