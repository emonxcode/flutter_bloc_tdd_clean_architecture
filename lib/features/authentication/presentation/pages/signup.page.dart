import 'package:bloc_clean_architecture_tdd_solid/core/theme/color.pallete.dart';
import 'package:flutter/material.dart';

import '../widgets/auth.button.dart';
import '../widgets/auth.field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              AuthField(
                controller: _nameController,
                hintText: 'Name',
              ),
              const SizedBox(height: 15),
              AuthField(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 15),
              AuthField(
                controller: _passwordController,
                hintText: 'Password',
                isObsecureText: true,
              ),
              const SizedBox(height: 30),
              const AuthButton(label: 'Sign Up',),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: ColorPallete.gradient2,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
