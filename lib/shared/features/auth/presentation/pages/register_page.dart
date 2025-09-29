import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:team_intelligence/app/theme/text_theme.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/l10n/l10n_extensions.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_intelligence/shared/widgets/dialogs/error_dialog.dart';
import 'package:team_intelligence/shared/widgets/dialogs/success_dialog.dart';
import 'package:team_intelligence/shared/widgets/layouts/scaffold_wrapper.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_state.dart';
import 'package:team_intelligence/shared/features/auth/domain/usecases/auth.dart';
import 'package:team_intelligence/shared/features/auth/presentation/widgets/auth_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = screenSize.width * 0.04;

    return ScaffoldWrapper(
      // extendBodyBehindAppBar: false,
      appBar: null,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthBloc(GetIt.instance<Auth>()),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                showErrorDialog(context, state.message);
              } else if (state is AuthLoaded) {
                showSuccessDialog(
                  context,
                  "Account created successfully!",
                ).then((_) {
                  if (context.canPop()) {
                    context.pop();
                  }
                });
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenSize.height * 0.05),
                    Text(
                      context.l10n.welcomeRegister,
                      style: AppTextTheme.withColor(
                        context.textTheme.headlineMedium!,
                        context.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      context.l10n.tagLineRegister,
                      style: AppTextTheme.withColor(
                        context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                        context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    AuthForm(
                      isRegister: true,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      nameController: _nameController,
                      confirmPasswordController: _confirmPasswordController,
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.haveAccount,
                          style: TextStyle(
                            color: context.colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            }
                          },
                          child: Text(
                            context.l10n.login,
                            style: TextStyle(
                              color: context.colorScheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
