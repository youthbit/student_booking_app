import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../domain/details/settings_details.dart';
import '../domain/state/settings_state.dart';

final flutterDatabase =
    Provider<FlutterSecureStorage>((ref) => const FlutterSecureStorage());

final settingsSpec = StateNotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);

class SettingsNotifier extends StateNotifier<SettingsState> {
  final Ref ref;

  late SettingsDetails details;

  SettingsNotifier(this.ref) : super(const SettingsState.initial()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const SettingsState.loading();
    // TODO(me): enum
    final dynamic language =
        (await ref.read(flutterDatabase).read(key: 'language')) ?? 'English';
    final themeMode =
        (await ref.read(flutterDatabase).read(key: 'theme')) ?? 'Light';
    details = SettingsDetails(
      currentLanguage: language as String,
      themeMode: themeMode,
    );
    state = SettingsState.data(details: details);
  }

  Future<void> setLanguage(String language) async {
    state = const SettingsState.loading();
    await ref.read(flutterDatabase).write(key: 'language', value: language);
    details = details.copyWith(currentLanguage: language);
    state = SettingsState.data(details: details);
  }

  Future<void> setTheme(String theme) async {
    state = const SettingsState.loading();
    await ref.read(flutterDatabase).write(key: 'theme', value: theme);
    details = details.copyWith(themeMode: theme);
    state = SettingsState.data(details: details);
  }

  // TODO(demezy): разлогин
}
