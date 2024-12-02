import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = "Ім'я Користувача"; // Заглушка для демонстрації
  final String userEmail = "user@example.com"; // Заглушка для демонстрації

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Профіль')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ім\'я: $userName',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email: $userEmail',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Вийти'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}