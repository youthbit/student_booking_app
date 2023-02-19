import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/auth_repository.dart';
import 'form.dart';

part 'email_password_sign_in_controller.g.dart';

class CredsData {
  final String email;
  final String password;
  final String? name;
  final String? phone;
  const CredsData({
    required this.email,
    required this.password,
    this.name,
    this.phone,
  });
}

@riverpod
class EmailPasswordSignInController extends _$EmailPasswordSignInController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> submit({
    required CredsData credsData,
    required EmailPasswordSignInFormType formType,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authenticate(credsData, formType));
    return state.hasError == false;
  }

  Future<void> _authenticate(
    CredsData credsData,
    EmailPasswordSignInFormType formType,
  ) {
    final authRepository = ref.read(authRepositoryProvider);
    switch (formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(
          credsData.email,
          credsData.password,
        );
      case EmailPasswordSignInFormType.register:
        assert(credsData.phone != null);
        assert(credsData.name != null);
        return authRepository.createUserWithEmailAndPassword(
          email: credsData.email,
          password: credsData.password,
          name: credsData.name!,
          phone: credsData.phone!,
        );
    }
  }
}
