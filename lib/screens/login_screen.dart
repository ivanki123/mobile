import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('user_email');
    String? storedPassword = prefs.getString('user_password');

    return email == storedEmail && password == storedPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вхід')),
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

                bool success = await loginUser(email, password);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Вхід успішний!')),
                  );
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Некоректний email або пароль!')),
                  );
                }
              },
              child: Text('Увійти'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Зареєструватися'),
            ),
          ],
        ),
      ),
    );
  }
}
