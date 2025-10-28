import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final username = TextEditingController();
  final password = TextEditingController();
  late AnimationController animasiconteoller;
  late Animation<AlignmentGeometry> animasi;
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    username.dispose();
    password.dispose();
    animasiconteoller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animasiconteoller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animasi = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(animasiconteoller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                  controller: username,
                  decoration: InputDecoration(
                    label: const Text("username"),
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    label: const Text("password"),
                    border: OutlineInputBorder(),
                  ),
                ),
                AlignTransition(
                  alignment: animasi,
                  child: OutlinedButton(
                    onHover: (value) async {
                      if(animasiconteoller.isAnimating)return;
                      if(!formkey.currentState!.validate()){
                        animasiconteoller.isCompleted?animasiconteoller.reverse():animasiconteoller.forward();
                      }
                    },
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        final email = username.text;
                        final passwor = password.text;
                        final text = "Email: $email \nPassword: $passwor";
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(text)));
                      }
                    },
                    child: const Text("login"),
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
