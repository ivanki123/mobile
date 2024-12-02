import 'package:flutter/material.dart';
import 'package:untitled2/service/storage_service.dart';

import '../service/shared_preferences_storage_service.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final StorageService storageService = SharedPreferencesStorageService();  // Ініціалізуємо реалізацію

  Future<void> registerUser(String email, String password) async {
    await storageService.saveUser(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Реєстрація')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                // Перевірка коректності email
                if (email.isEmpty || !email.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Некоректний Email!')),
                  );
                  return;
                }
                // Перевірка паролю
                if (password.isEmpty || password.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Пароль повинен бути довшим за 6 символів!')),
                  );
                  return;
                }

                // Реєстрація користувача
                await registerUser(email, password);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Реєстрація успішна!')),
                );
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Зареєструватися'),
            ),
          ],
        ),
      ),
    );
  }
}
