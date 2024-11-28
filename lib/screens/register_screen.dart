import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
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

                if (email.isEmpty || !email.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Некоректний Email!')),
                  );
                  return;
                }
                if (password.isEmpty || password.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Пароль повинен бути довшим за 6 символів!')),
                  );
                  return;
                }

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
