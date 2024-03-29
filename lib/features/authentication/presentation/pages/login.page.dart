import 'package:bloc_clean_architecture_tdd_solid/core/theme/color.pallete.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/presentation/pages/signup.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/utils/snackbar.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth.button.dart';
import '../widgets/auth.field.dart';

class LoginPage extends StatefulWidget {
  static route() => CupertinoPageRoute(
        builder: (context) => const LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(
                  context: context,
                  snackText: state.message,
                  snackBackgroundColor: Colors.red,
                  snackTextColor: Colors.white);
            }

            if (state is AuthSuccess) {
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   LoginPage.route(),
              //   (route) => true,
              // );
              showSnackBar(
                  context: context,
                  snackText: "Success!",
                  snackBackgroundColor: Colors.green,
                  snackTextColor: Colors.white);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In.',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
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
                  AuthButton(
                    label: 'Login',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthLogin(
                            email: _emailController.text,
                            password: _passwordController.text));
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignupPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: ColorPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
