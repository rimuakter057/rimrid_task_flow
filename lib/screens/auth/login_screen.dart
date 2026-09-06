import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_sizer.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../main_shell.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    // This is a static UI, so we just navigate straight to the dashboard.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSizer.spacing(context, 24),
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ResponsiveSizer.height(context, 4)),
              _LogoMark(),
              const SizedBox(height: 28),
              Text('Welcome back', style: AppText.h1),
              const SizedBox(height: 6),
              Text('Log in to keep track of your projects and tasks.', style: AppText.bodyMedium),
              const SizedBox(height: 32),
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
                hint: 'Enter your password',
                controller: _passwordController,
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 12),
              AppButton(label: 'Log In', onPressed: _handleLogin),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: AppText.bodyMedium),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      );
                    },
                    child: Text('Sign Up', style: AppText.link),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small reusable purple logo mark shown on the auth screens.
class _LogoMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.check_circle_rounded, color: Colors.white, size: 30),
    );
  }
}
