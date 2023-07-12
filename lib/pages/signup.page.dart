import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController emailController = TextEditingController();

  void enter() {
    String text = emailController.text;
    print(text);
  }

  void onChanged(String text) {
    print(text);
  }

  void onSubmitted(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'example@email.com',
                  border: OutlineInputBorder(),
                  errorText: 'Campo obrigatório!',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Teste@123',
                  border: OutlineInputBorder(),
                  errorText: 'Campo obrigatório!',
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Dinheiro',
                  hintText: 'Teste@123',
                  border: OutlineInputBorder(),
                  errorText: 'Campo obrigatório!',
                  prefixText: 'R\$ ',
                  suffixText: '0,00',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: enter,
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
