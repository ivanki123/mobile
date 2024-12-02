import 'package:flutter/material.dart';
import '../check_internet_connection.dart';
import '../service/shared_preferences_storage_service.dart';
import '../service/storage_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final StorageService storageService = SharedPreferencesStorageService();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  Future<void> _autoLogin() async {
    String? email = await storageService.getEmail();
    String? password = await storageService.getPassword();
    if (email != null && password != null) {
      // Перевірка інтернет з'єднання
      bool isConnected = await checkInternetConnection();
      if (isConnected) {
        setState(() {
          isLoggedIn = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Автологін успішний! Підключення до мережі необхідне.')),
        );
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    }
  }

  Future<void> loginUser(String email, String password) async {
    bool isConnected = await checkInternetConnection();
    if (!isConnected) {
      _showNoConnectionDialog();
      return;
    }

    String? storedEmail = await storageService.getEmail();
    String? storedPassword = await storageService.getPassword();

    if (email == storedEmail && password == storedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Вхід успішний!')));
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Некоректний email або пароль!')));
    }
  }

  Future<void> _showNoConnectionDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Немає з\'єднання з Інтернетом'),
        content: Text('Будь ласка, підключіться до Інтернету для виконання входу.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showLogoutDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Вихід'),
        content: Text('Ви дійсно хочете вийти?'),
        actions: [
          TextButton(
            onPressed: () {
              storageService.clearUser();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Так'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ні'),
          ),
        ],
      ),
    );
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
                await loginUser(email, password);
              },
              child: Text('Увійти'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Зареєструватися'),
            ),
            isLoggedIn
                ? ElevatedButton(
              onPressed: _showLogoutDialog,
              child: Text('Вийти'),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}