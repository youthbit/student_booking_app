import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../config/utils.dart';
import '../../routing/router_spec.dart';
import 'login/form.dart';
import 'login_forms.dart';

class LoginScreen extends HookConsumerWidget {
  static const emailKey = Key('email');
  static const passwordKey = Key('password');
  static const nameKey = Key('name');
  static const phoneName = Key('phone');

  final EmailPasswordSignInFormType formType;

  const LoginScreen(
    this.formType, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.centerLeft,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (context.mounted) {
                        context.maybePop();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 40.0,
                        top: 40.0,
                      ),
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset('assets/images/arrow_white.png'),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: EmailPasswordSignInContents(
                    formType: formType,
                    nextScreen: ref.read(nextScreenProvider),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

