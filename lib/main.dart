import 'package:debug_overlay/debug_overlay.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/app_theme.dart';
import 'config/constants.dart';
import 'exceptions/error_logger.dart';
import 'features/home/domain/event.dart';
import 'features/onboarding/domain/onboarding_repository.dart';
import 'features/routing/router_spec.dart';
import 'features/settings/data/settings_repository.dart';
import 'firebase_options.dart';

final logs = LogCollection();

final getIt = GetIt.instance;

Future<void> setup() async {
  final options = BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: Constants.dioConnectTimeout,
    receiveTimeout: Constants.dioReceiveTimeout,
  );
  getIt
    ..registerSingleton<Dio>(Dio(options))
    ..registerLazySingleton<Logger>(Logger.new)
    ..registerSingletonAsync<Isar>(
          () async => await Isar.open([EventSchema]),
    )
    ..allReady();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  await EasyLocalization.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();
    var token = await messaging.getToken();

    if (kDebugMode) {
      print('Registration Token=$token');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await messaging.subscribeToTopic(FlutterTopics.public.name);
  } catch (e) {
    print(e.toString());
    // OFFLINE!!!
  }

  final container = ProviderContainer(
    overrides: [
      onboardingRepositoryProvider.overrideWithValue(
        OnboardingRepository(sharedPreferences),
      ),
    ],
  );

  if (kDebugMode) {
    DebugOverlay.appendHelper(LogsDebugHelper(logs));
  }
  final errorLogger = container.read(errorLoggerProvider);
  //registerErrorHandlers(errorLogger);

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en', ''), Locale('ru', '')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', ''),
        child: UncontrolledProviderScope(
          container: container,
          child: const MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsSpec);
    final themeMode = settings.maybeWhen(
      data: (data) =>
      data.themeMode == 'Light' ? ThemeMode.light : ThemeMode.dark,
      orElse: () => ThemeMode.dark,
    );
    final goRouter = ref.watch(routeSpecProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      builder: DebugOverlay.builder(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      title: 'YouthBit Hackathon',
      themeMode: themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    errorLogger.logError(error, stack);
    return true;
  };
  ErrorWidget.builder = (details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}
