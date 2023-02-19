import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import 'form.dart';
import 'validators.dart';

mixin EmailAndPasswordValidators {
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator phoneSubmitValidator = PhoneSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPhone(String email) {
    return phoneSubmitValidator.isValid(email);
  }

  bool canSubmitPassword(
    String password,
    EmailPasswordSignInFormType formType,
  ) {
    if (formType == EmailPasswordSignInFormType.register) {
      return passwordRegisterSubmitValidator.isValid(password);
    }
    return passwordSignInSubmitValidator.isValid(password);
  }

  String? emailErrorText(String email) {
    final showErrorText = !canSubmitEmail(email);
    final errorText = email.isEmpty
        ? LocaleKeys.loginFormsEmailValidationEmpty.tr()
        : LocaleKeys.loginFormsEmailValidationWrong.tr();
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(
    String password,
    EmailPasswordSignInFormType formType,
  ) {
    final showErrorText = !canSubmitPassword(password, formType);
    final errorText = password.isEmpty
        ? LocaleKeys.loginFormsPasswordValidationEmpty.tr()
        : LocaleKeys.loginFormsPasswordValidationWrong.tr();
    return showErrorText ? errorText : null;
  }

  String? phoneErrorText(String phone) {
    final showErrorText = !canSubmitPhone(phone);
    final errorText = phone.isEmpty
        ? LocaleKeys.loginFormsPhoneValidationEmpty.tr()
        : LocaleKeys.loginFormsPhoneValidationWrong.tr();
    return showErrorText ? errorText : null;
  }
}
