import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_note/bloc/auth/auth_bloc.dart';
import 'package:hot_note/core/common/custom_button.dart';
import 'package:hot_note/core/routes/app_routes.dart';
import 'package:hot_note/core/theme/app_colors.dart';
import 'package:hot_note/core/utils/show_toast.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "SIGN IN",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                controller: emailController,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                controller: passwordController,
                validator: (value) {
                  if (value == null) {
                    return "Enter Password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  print("all state $state ");

                  if (state is Authloading) {
                    isLoading = true;
                  } else if (state is AuthSuccess) {
                    print("all state ${state.user} ");

                    context.go(AppRoutes.home);
                  } else if (state is AuthFailure) {
                    showToast(context: context, msg: state.error);
                  }
                },
                builder: (context, state) {
                  return CstmBtn(
                    txt: "Sign In",
                    isLoading: isLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
