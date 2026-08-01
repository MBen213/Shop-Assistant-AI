import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../widgets/login_form.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(LoginProvider provider) async {
    final success = await provider.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login failed"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Assistant AI"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.storefront,
                  size: 90,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  onLogin: () => _login(provider),
                ),

                const SizedBox(height: 25),

                if (provider.isLoading)
                  const CircularProgressIndicator(),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () => _login(provider),
                    child: const Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}