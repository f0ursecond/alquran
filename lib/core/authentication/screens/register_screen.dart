import 'dart:async';

import 'package:alquran/constant/route_path.dart';
import 'package:alquran/core/authentication/cubit/register_cubit.dart';
import 'package:alquran/core/authentication/screens/login_screen.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(),
              TextFormField(
                validator: (value) {
                  if (value == "" && value!.isEmpty) {
                    return 'Email Harus Diisi';
                  }
                  return null;
                },
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == "" && value!.isEmpty) {
                    return 'Password Harus Diisi';
                  }
                  return null;
                },
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              BlocProvider.value(
                value: BlocProvider.of<RegisterCubit>(context),
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Flushbar(
                        title: 'Congratulations!',
                        message: 'Register Success',
                        duration: const Duration(seconds: 3),
                      ).show(context);
                      if (context.mounted) {
                        Timer(const Duration(seconds: 3), () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutePath.homeScreen,
                            (route) => false,
                          );
                        });
                      }
                    } else if (state is RegisterFailure) {
                      Flushbar(
                        backgroundColor: Colors.redAccent,
                        title: 'Ooopss!!!',
                        message: state.failure.message,
                        duration: const Duration(seconds: 3),
                      ).show(context);
                    }
                  },
                  builder: (context, state) {
                    var loading = state is RegisiterLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<RegisterCubit>().register(
                                    emailController.text,
                                    passwordController.text,
                                  );
                            }
                          },
                          child: Center(
                            child: loading
                                ? LoadingAnimationWidget.discreteCircle(
                                    color: Colors.white, size: 30)
                                : const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Have an Account?'),
                  const SizedBox(width: 10),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.green),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
