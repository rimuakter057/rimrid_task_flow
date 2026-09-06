import 'package:flutter/material.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_sizer.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../main_shell.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleSignUp() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSizer.spacing(context, 24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create Account', style: AppText.h1),
              const SizedBox(height: 6),
              Text('Sign up to start organizing your work with TaskFlow.', style: AppText.bodyMedium),
              const SizedBox(height: 32),
              AppTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: _nameController,
                prefixIcon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 18),
              AppTextField(
                label: 'Email',
                hint: 'you@example.com',
                controller: _emailController,
                prefixIcon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),
              AppTextField(
                label: 'Password',
                hint: 'Create a password',
                controller: _passwordController,
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
              ),
              const SizedBox(height: 28),
              AppButton(label: 'Sign Up', onPressed: _handleSignUp),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ', style: AppText.bodyMedium),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text('Log In', style: AppText.link),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
