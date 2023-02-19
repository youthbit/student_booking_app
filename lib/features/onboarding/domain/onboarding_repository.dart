import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingRepository {
  static const onboardingCompleteKey = 'onboarding-complete-key';
  final SharedPreferences sharedPreferences;

  OnboardingRepository(this.sharedPreferences);

  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  bool isOnboardingComplete() =>
      sharedPreferences.getBool(onboardingCompleteKey) ?? false;
}

final onboardingRepositoryProvider =
    Provider<OnboardingRepository>((ref) => throw UnimplementedError());
