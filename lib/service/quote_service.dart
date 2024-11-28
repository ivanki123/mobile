import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  final String _baseUrl = 'https://api.adviceslip.com/advice';

  Future<String> fetchQuote() async {
    final url = Uri.parse(_baseUrl);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['slip']['advice'];
      } else {
        return 'Не вдалося завантажити цитату. Спробуйте пізніше.';
      }
    } catch (e) {
      return 'Помилка під час завантаження цитати: $e';
    }
  }
}
