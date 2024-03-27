import 'package:bloc_clean_architecture_tdd_solid/core/common/widgets/loader.dart';
import 'package:bloc_clean_architecture_tdd_solid/core/theme/color.pallete.dart';
import 'package:bloc_clean_architecture_tdd_solid/core/utils/snackbar.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/presentation/pages/login.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/auth.button.dart';
import '../widgets/auth.field.dart';

class SignupPage extends StatefulWidget {
  static route() => CupertinoPageRoute(
        builder: (context) => const SignupPage(),
      );
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
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
              Navigator.pushAndRemoveUntil(
                context,
                LoginPage.route(),
                (route) => true,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: SingleChildScrollView(
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
                    AuthButton(
                      label: 'Sign Up',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignUp(
                              email: _emailController.text,
                              name: _nameController.text,
                              password: _passwordController.text));
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          LoginPage.route(),
                          (route) => true,
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Login',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
