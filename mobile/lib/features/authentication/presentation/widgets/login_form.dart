import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  void submit() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }

              if (!value.contains("@")) {
                return "Invalid email";
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: widget.passwordController,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }

              if (value.length < 6) {
                return "Password too short";
              }

              return null;
            },
            onFieldSubmitted: (_) => submit(),
          ),
        ],
      ),
    );
  }
}