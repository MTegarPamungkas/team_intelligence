// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_intelligence/app/theme/color_scheme.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/l10n/l10n_extensions.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_event.dart';

class AuthForm extends StatefulWidget {
  final bool isRegister;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;
  final TextEditingController? confirmPasswordController;

  const AuthForm({
    super.key,
    required this.isRegister,
    required this.emailController,
    required this.passwordController,
    this.nameController,
    this.confirmPasswordController,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isPasswordHidden = true;

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? hintText,
    bool enabled = true,
    VoidCallback? onTogglePassword,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        enabled: enabled,
        style: TextStyle(
          color: enabled
              ? AppColorScheme.lightPrimary
              : AppColorScheme.lightPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColorScheme.darkOnPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColorScheme.darkOnPrimary, size: 20),
          ),
          suffixIcon: isPassword
              ? Container(
                  margin: const EdgeInsets.all(8),
                  child: IconButton(
                    onPressed: onTogglePassword,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        key: ValueKey(obscureText),
                        color: context.colorScheme.onSurfaceVariant,
                        size: 22,
                      ),
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: context.colorScheme.onSurfaceVariant
                          .withOpacity(0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                    tooltip: obscureText ? 'Show password' : 'Hide password',
                  ),
                )
              : suffixIcon != null
              ? Container(margin: const EdgeInsets.all(12), child: suffixIcon)
              : null,
          labelText: label,
          hintText: hintText,
          labelStyle: TextStyle(
            color: AppColorScheme.darkOutline,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          hintStyle: TextStyle(
            color: AppColorScheme.lightPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          // floatingLabelStyle: null,
          // // floatingLabelStyle: TextStyle(
          // //   color: colorScheme.onPrimary,
          // //   fontSize: 14,
          // //   backgroundColor: Colors.white,
          // //   fontWeight: FontWeight.w600,
          // // ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: context.colorScheme.primary.withOpacity(0.3),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.3),
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.5),
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
        cursorColor: context.colorScheme.primary,
        cursorHeight: 24,
        cursorWidth: 2,
      ),
    );
  }

  Widget _buildAuthButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (widget.isRegister) {
            final name = widget.nameController?.text.trim() ?? '';
            final email = widget.emailController.text.trim();
            final password = widget.passwordController.text.trim();
            final confirmPassword =
                widget.confirmPasswordController?.text.trim() ?? '';

            if (name.isEmpty ||
                email.isEmpty ||
                password.isEmpty ||
                confirmPassword.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All fields are required')),
              );
              return;
            }

            if (password != confirmPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Passwords do not match')),
              );
              return;
            }

            context.read<AuthBloc>().add(
              RegisterEvent(name, email, password, confirmPassword),
            );
          } else {
            final email = widget.emailController.text.trim();
            final password = widget.passwordController.text.trim();

            if (email.isEmpty || password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All fields are required')),
              );
              return;
            }

            context.read<AuthBloc>().add(LoginEvent(email, password));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorScheme.lightPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          widget.isRegister ? context.l10n.register : context.l10n.login,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isRegister)
          _buildTextField(
            context: context,
            controller: widget.nameController!,
            label: context.l10n.name,
            icon: Icons.person,
          ),
        const SizedBox(height: 16),
        _buildTextField(
          context: context,
          controller: widget.emailController,
          label: context.l10n.email,
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          context: context,
          controller: widget.passwordController,
          isPassword: true,
          label: context.l10n.password,
          icon: Icons.lock,
          obscureText: _isPasswordHidden,
          onTogglePassword: () {
            setState(() {
              _isPasswordHidden = !_isPasswordHidden;
            });
          },
        ),
        const SizedBox(height: 16),
        if (widget.isRegister)
          _buildTextField(
            context: context,
            controller: widget.confirmPasswordController!,
            label: context.l10n.confirmPassword,
            icon: Icons.lock,
            obscureText: true,
          ),
        const SizedBox(height: 16),
        _buildAuthButton(context),
      ],
    );
  }
}
