import 'package:flutter/material.dart';
import 'package:navigation_2/model/user.dart';
import 'package:navigation_2/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;
  const RegisterScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("register Screen")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                context.watch<AuthProvider>().isloadingregister
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final scaffoldMessenger = ScaffoldMessenger.of(
                              context,
                            );
                            final User user = User(
                              username: emailController.text,
                              password: passwordController.text,
                            );
                            final authRead = context.read<AuthProvider>();
                            final result = await authRead.saveUser(user);
                            if (result) {
                              widget.onRegister();
                            } else {
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Your email or password is invalid",
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text("Register"),
                      ),
                const SizedBox(height: 8),
                OutlinedButton(onPressed: () => widget.onLogin, child: const Text("Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
