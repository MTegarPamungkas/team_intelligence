import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:team_intelligence/app/theme/text_theme.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/l10n/l10n_extensions.dart';
import 'package:team_intelligence/shared/features/auth/domain/usecases/auth.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_intelligence/shared/widgets/dialogs/error_dialog.dart';
import 'package:team_intelligence/shared/widgets/layouts/scaffold_wrapper.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_state.dart';
import 'package:team_intelligence/shared/features/auth/presentation/widgets/auth_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              // Handle login failure
              if (state is AuthError) {
                showErrorDialog(context, state.message);
              } else if (state is AuthLoaded) {}
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenSize.height * 0.05),
                    Text(
                      context.l10n.welcomeLogin,
                      style: AppTextTheme.withColor(
                        context.textTheme.headlineMedium!,
                        context.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      context.l10n.tagLineLogin,
                      style: AppTextTheme.withColor(
                        context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    AuthForm(
                      isRegister: false,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.noAccount,
                          style: TextStyle(
                            color: context.colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push('/register');
                          },
                          child: Text(
                            context.l10n.register,
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
