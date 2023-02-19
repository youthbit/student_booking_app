import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../exceptions/app_exception.dart';
import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/login.dart';
import '../features/authentication/presentation/login_forms.dart';
import '../features/routing/router_spec.dart';
import '../generated/locale_keys.g.dart';
import '../main.dart';

class Utils {
  const Utils._();
}

extension MaybePop on BuildContext {
  void maybePop() {
    if (canPop()) {
      pop();
    } else {
      if (kDebugMode) {
        getIt<Logger>().d(StackTrace.current);
      }
      goNamed(RouteSpec.homepage.fullName);
    }
  }
}

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = _errorMessage(error);
      showExceptionAlertDialog(
        context: context,
        title: LocaleKeys.alertScreenTitle.tr(),
        exception: message,
      );
    }
  }

  String _errorMessage(Object? error) {
    if (error is AppException) {
      return LocaleKeys.alertScreenMessage.tr();
    } else {
      return error.toString();
    }
  }
}

typedef ResponseJson = Map<String, dynamic>;