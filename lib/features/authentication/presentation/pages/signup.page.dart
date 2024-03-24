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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            const AuthField(
              hintText: 'Name',
            ),
            const SizedBox(height: 15),
            const AuthField(
              hintText: 'Email',
            ),
            const SizedBox(height: 15),
            const AuthField(
              hintText: 'Password',
            ),
            const SizedBox(height: 30),
            const AuthButton(),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                  text: "Don't have an account? ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: ColorPallete.gradient2,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
