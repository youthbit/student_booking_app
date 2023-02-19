import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../routing/router_spec.dart';

/// Form type for email & password authentication
enum EmailPasswordSignInFormType { signIn, register }

extension EmailPasswordSignInFormTypeX on EmailPasswordSignInFormType {
  String get passwordLabelText {
    if (this == EmailPasswordSignInFormType.register) {
      return LocaleKeys.registerFormsPasswordTextFieldLabel.tr();
    } else {
      return LocaleKeys.loginFormsPasswordTextFieldLabel.tr();
    }
  }

  // Getters
  String get primaryButtonText {
    if (this == EmailPasswordSignInFormType.register) {
      return LocaleKeys.registerFormsPrimaryBtn.tr();
    } else {
      return LocaleKeys.loginFormsPrimaryBtn.tr();
    }
  }

  String get secondaryButtonText {
    if (this == EmailPasswordSignInFormType.register) {
      return LocaleKeys.registerFormsSecondaryBtn.tr();
    } else {
      return LocaleKeys.loginFormsSecondaryBtn.tr();
    }
  }

  EmailPasswordSignInFormType get secondaryActionFormType {
    if (this == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInFormType.signIn;
    } else {
      return EmailPasswordSignInFormType.register;
    }
  }

  String get errorAlertTitle {
    if (this == EmailPasswordSignInFormType.register) {
      return LocaleKeys.registerFormsErrorAlertTitle.tr();
    } else {
      return LocaleKeys.loginFormsErrorAlertTitle.tr();
    }
  }

  String get title {
    if (this == EmailPasswordSignInFormType.register) {
      return LocaleKeys.registerFormsTitle.tr();
    } else {
      return LocaleKeys.loginFormsTitle.tr();
    }
  }

  String get redirectPath {
    if (this == EmailPasswordSignInFormType.register) {
      return RouteSpec.login.name;
    } else {
      return RouteSpec.register.name;
    }
  }
}
