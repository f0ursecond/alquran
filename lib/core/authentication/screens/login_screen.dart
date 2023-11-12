import 'dart:async';

import 'package:alquran/constant/route_path.dart';
import 'package:alquran/core/authentication/cubit/login_cubit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                //controller: emailController,
                initialValue: '2ez4second@gmail.com',
                decoration: const InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: '123456',
                obscureText: true,
                //controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              BlocProvider.value(
                value: BlocProvider.of<LoginCubit>(context),
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    print('listener $state');
                    if (state is LoginSuccess) {
                      Flushbar(
                        title: 'Congratulations!',
                        message: 'Login Success',
                        duration: const Duration(seconds: 3),
                      ).show(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutePath.homeScreen,
                        (route) => false,
                      );
                    } else if (state is LoginFailure) {
                      Flushbar(
                        backgroundColor: Colors.redAccent,
                        title: 'Ooopss!!!',
                        message: state.failure.message,
                        duration: const Duration(seconds: 3),
                      ).show(context);
                    }
                  },
                  builder: (context, state) {
                    var loading = state is LoginLoading;
                    print('builder $state');
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            context.read<LoginCubit>().login(
                                  '2ez4second@gmail.com',
                                  '123456',
                                );
                          },
                          child: Center(
                            child: loading
                                ? LoadingAnimationWidget.discreteCircle(
                                    color: Colors.black,
                                    size: 25,
                                  )
                                : const Text(
                                    'Login',
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
                  const Text("Don't Have an Account?"),
                  const SizedBox(width: 10),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePath.registerScreen);
                      },
                      child: const Text(
                        'Register',
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
