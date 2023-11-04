import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts/application/authentication/authentication_controller.dart';
import 'package:workouts/presentation/theme/typography.dart';
import 'package:workouts/presentation/widgets/buttons/main_button.dart';
import 'package:workouts/presentation/widgets/text_fields/main_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const Spacer(),
            StyledText.bodyLarge('Log in'),
            const SizedBox(height: 16),
            MainTextField(
              controller: emailTextController,
              labelText: 'Email',
            ),
            const SizedBox(height: 8),
            MainTextField(
              controller: passwordTextController,
              labelText: 'Password',
            ),
            const SizedBox(height: 16),
            MainButton(
              child: StyledText.button('Log in'),
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).signInWithCredentials(
                      email: emailTextController.text,
                      password: passwordTextController.text,
                    );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
