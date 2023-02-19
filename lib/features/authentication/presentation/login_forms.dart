import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/utils.dart';
import '../../../generated/locale_keys.g.dart';
import '../../routing/router_spec.dart';
import 'login.dart';
import 'login/email_password_sign_in_controller.dart';
import 'login/form.dart';
import 'login/form_validators.dart';
import 'login/validators.dart';
import 'widgets/form_button.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  String? defaultActionText,
}) async {
  defaultActionText =
      defaultActionText ?? LocaleKeys.showAlertDialogDefaultActionText.tr();
  if (kIsWeb || !Platform.isIOS) {
    return showDialog(
      context: context,
      barrierDismissible: cancelActionText != null,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: <Widget>[
          if (cancelActionText != null)
            TextButton(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          TextButton(
            child: Text(defaultActionText!),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    barrierDismissible: cancelActionText != null,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText!),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required String exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
    );

Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(
      context: context,
      title: LocaleKeys.showNotImplementedDialogTitle.tr(),
    );

class EmailPasswordSignInContents extends HookConsumerWidget
    with EmailAndPasswordValidators {
  final EmailPasswordSignInFormType formType;
  final VoidCallback? onSignedIn;
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final String? nextScreen;

  EmailPasswordSignInContents({
    required this.formType,
    required this.nextScreen,
    super.key,
    this.onSignedIn,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final submitted = useState<bool>(false);
    final isObscured = useState<bool>(true);
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(emailPasswordSignInControllerProvider);

    Future<void> submit() async {
      submitted.value = true;
      if (_formKey.currentState!.validate()) {
        final controller =
            ref.read(emailPasswordSignInControllerProvider.notifier);
        late final CredsData creds;
        if (formType == EmailPasswordSignInFormType.register) {
          creds = CredsData(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            phone: phoneController.text,
          );
        } else {
          creds = CredsData(
            email: emailController.text,
            password: passwordController.text,
          );
        }
        final success = await controller.submit(
          credsData: creds,
          formType: formType,
        );
        if (success) {
          onSignedIn?.call();
          // ignore: use_build_context_synchronously
          context.go(nextScreen ?? RouteSpec.homepage.path);
        }
      }
    }

    return SafeArea(
      child: FocusScope(
        node: _node,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: "Let's sign you in.\n",
                  style: Theme.of(context).textTheme.displayLarge,
                  children: <TextSpan>[
                    TextSpan(
                      text: "Welcome back\nYou've been missed!",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextFormField(
                key: LoginScreen.emailKey,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.loginFormsEmailTextFieldLabel.tr(),
                  enabled: !state.isLoading,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    !submitted.value ? null : emailErrorText(email ?? ''),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () =>
                    _emailEditingComplete(emailController.text),
                inputFormatters: <TextInputFormatter>[
                  ValidatorInputFormatter(
                    editingValidator: EmailEditingRegexValidator(),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                key: LoginScreen.passwordKey,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: formType.passwordLabelText,
                  enabled: !state.isLoading,
                  suffixIcon: IconButton(
                    splashRadius: .0001,
                    onPressed: () {
                      isObscured.value = !isObscured.value;
                    },
                    icon: isObscured.value
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => !submitted.value
                    ? null
                    : passwordErrorText(password ?? '', formType),
                obscureText: true,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () {
                  _passwordEditingComplete(passwordController.text);
                  submit();
                },
              ),
              if (formType == EmailPasswordSignInFormType.register)
                Column(
                  // shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      key: LoginScreen.nameKey,
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.loginFormsNameTextFieldLabel.tr(),
                        enabled: !state.isLoading,
                        filled: true,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      keyboardAppearance: Brightness.light,
                      onEditingComplete: () =>
                          _emailEditingComplete(emailController.text),
                      inputFormatters: <TextInputFormatter>[
                        ValidatorInputFormatter(
                          editingValidator: EmailEditingRegexValidator(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      key: LoginScreen.phoneName,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText:
                            LocaleKeys.loginFormsPhoneTextFieldLabel.tr(),
                        enabled: !state.isLoading,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (phone) =>
                          !submitted.value ? null : phoneErrorText(phone ?? ''),
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      keyboardAppearance: Brightness.light,
                      onEditingComplete: () =>
                          _phoneEditingComplete(emailController.text),
                      inputFormatters: <TextInputFormatter>[
                        ValidatorInputFormatter(
                          editingValidator: EmailEditingRegexValidator(),
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(
                height: 16,
              ),
              const Spacer(
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(formType.redirectPath),
                    child: Text(
                      LocaleKeys.loginFormsRegisterTextBtn.tr(),
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                child: Text(
                  LocaleKeys.loginFormsLoginTextBtn.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme
                            ?.onBackground,
                      ),
                ),
                isLoading: state.isLoading,
                onPressed: state.isLoading ? null : submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _emailEditingComplete(String email) {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _phoneEditingComplete(String phone) {
    if (canSubmitPhone(phone)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete(String password) {
    if (!canSubmitEmail(password)) {
      _node.previousFocus();
      return;
    }
  }
}
