import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Реєстрація')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                label: 'Ім\'я',
                obscureText: false,
                controller: nameController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Прізвище',
                obscureText: false,
                controller: surnameController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                obscureText: false,
                controller: emailController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Пароль',
                obscureText: true,
                controller: passwordController,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Зареєструватися'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Повернутися до входу'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
