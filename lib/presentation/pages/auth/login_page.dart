import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventro_fnb_app/presentation/bloc/login/login_bloc.dart';
import 'package:ventro_fnb_app/presentation/widgets/text_form_custom.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement actual login logic
      final username = _usernameController.text;
      final password = _passwordController.text;

      debugPrint('Login attempt: $username / $password');
      context.read<LoginBloc>().add(LoginRequested(username: username, password: password));
      // context.goNamed(HomePage.routeName);

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login berhasil!')));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/illustrations/auth.png'),
                SizedBox(height: 16),
                Text(
                  "Login",
                  style: (Theme.of(context).textTheme.titleLarge ?? const TextStyle()).copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),
                // Username
                TextFormCustom(
                  controller: _usernameController,
                  labelText: 'Username',
                  hintText: 'Masukkan username',
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Password
                TextFormCustom(
                  controller: _passwordController,
                  obscureText: true,
                  labelText: 'Password',
                  hintText: 'Masukkan password',
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _login(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // context.goNamed(ForgetPasswordPage.routeName);
                    },
                    child: Text(
                      "Lupa Kata sandi?",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 48)),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum punya akun? "),
                    GestureDetector(
                      onTap: () {
                        // context.goNamed(RegisterPage.routeName);
                      },
                      child: Text(
                        "Daftar",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}