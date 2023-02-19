import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/onboarding_repository.dart';

class OnboardingService extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // no op
  }

  Future<void> completeOnboarding() async {
    final onboardingRepository = ref.watch(onboardingRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(onboardingRepository.setOnboardingComplete);
  }
}

final onboardingControllerProvider =
    AutoDisposeAsyncNotifierProvider<OnboardingService, void>(
  OnboardingService.new,
);
