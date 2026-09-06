import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_sizer.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  // Tracks whether we've "sent" the reset email, so we can show a
  // confirmation message instead of the form. Simple local UI state.
  bool _emailSent = false;

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
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.lock_reset_rounded, color: AppColors.primary, size: 28),
              ),
              const SizedBox(height: 24),
              Text(_emailSent ? 'Check your email' : 'Forgot Password?', style: AppText.h1),
              const SizedBox(height: 6),
              Text(
                _emailSent
                    ? "We've sent a password reset link to ${_emailController.text.isEmpty ? 'your email' : _emailController.text}."
                    : "Enter the email associated with your account and we'll send a link to reset your password.",
                style: AppText.bodyMedium,
              ),
              const SizedBox(height: 32),
              if (!_emailSent) ...[
                AppTextField(
                  label: 'Email',
                  hint: 'you@example.com',
                  controller: _emailController,
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 28),
                AppButton(
                  label: 'Send Reset Link',
                  onPressed: () => setState(() => _emailSent = true),
                ),
              ] else ...[
                AppButton(label: 'Back to Login', onPressed: () => Navigator.of(context).pop()),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
