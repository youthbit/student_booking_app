import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../generated/locale_keys.g.dart';
import '../../authentication/data/auth_repository.dart';
import '../../routing/router_spec.dart';
import '../data/settings_repository.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsSpec);
    final details =
        settings.maybeWhen(data: (details) => details, orElse: () => null);
    final authRepository = ref.watch(authRepositoryProvider);
    final darkModeSwitch = useState(details?.themeMode == 'Dark');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            if (!context.mounted) return;
            context.goNamed(RouteSpec.homepage.name);
          },
          splashRadius: 24.0,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
            child: Text(
              LocaleKeys.settingsTitle.tr(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.settingsSection1.tr(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                TextButton(
                  onPressed: () {
                    if (!context.mounted) return;
                    context.goNamed(RouteSpec.success.name);
                  },
                  child: const Text('Success Alert'),
                ),
                TextButton(
                  onPressed: () {
                    if (!context.mounted) return;
                    context.goNamed(RouteSpec.error.name);
                  },
                  child: const Text('Error Alert'),
                ),
                Row(
                  children: [
                    FloatingActionButton(
                      heroTag: '',
                      elevation: 0,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 24),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text:
                              '${authRepository.currentUser?.name ?? 'Аноним'}\n',
                          style: Theme.of(context).textTheme.headlineMedium,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Ваша информация',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: FloatingActionButton(
                        heroTag: 'person',
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () => context.goNamed('profile'),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.settingsSection2.tr(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'language_rounded',
                          elevation: 0,
                          backgroundColor: Colors.orange.withAlpha(30),
                          onPressed: () {},
                          child: const Icon(
                            Icons.language_rounded,
                            size: 24,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        LocaleKeys.settingsSubSection1.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      Text(
                        details?.currentLanguage ?? 'English',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(width: 24),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'language',
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () async {
                            final result = await showConfirmationDialog<String>(
                              title: 'Выбрать язык',
                              context: context,
                              actions: [
                                // TODO: поправить баг в светлой теме
                                const AlertDialogAction(
                                  key: 'en',
                                  label: 'English',
                                ),
                                const AlertDialogAction(
                                  key: 'ru',
                                  label: 'Русский',
                                ),
                              ],
                            );

                            // ignore: use_build_context_synchronously
                            await context.setLocale(Locale(result ?? 'en'));
                            await ref
                                .read(settingsSpec.notifier)
                                .setLanguage(result ?? 'en');
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'notification',
                          elevation: 0,
                          backgroundColor: Colors.blueAccent.withAlpha(30),
                          onPressed: () {},
                          child: const Icon(
                            Icons.notifications_none,
                            size: 24,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        LocaleKeys.settingsSubSection2.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'notifications',
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {},
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'dark_mode',
                          elevation: 0,
                          backgroundColor: Colors.indigo.withAlpha(30),
                          onPressed: () {},
                          child: const Icon(
                            Icons.dark_mode_outlined,
                            size: 24,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        LocaleKeys.settingsSubSection3.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                        value: darkModeSwitch.value,
                        activeColor: Colors.indigoAccent,
                        onChanged: (value) {
                          //ignore: avoid_dynamic_calls
                          ref
                              .read<dynamic>(settingsSpec.notifier)
                              .setTheme(value ? 'Dark' : 'Light');
                          darkModeSwitch.value = !darkModeSwitch.value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'help',
                          elevation: 0,
                          backgroundColor: Colors.pinkAccent.withAlpha(30),
                          onPressed: () {},
                          child: const Icon(
                            Icons.help_outline,
                            size: 24,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        LocaleKeys.settingsSubSection4.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'some_tag',
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {},
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
