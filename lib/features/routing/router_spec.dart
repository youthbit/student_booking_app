import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../alert/alert_error_view.dart';
import '../alert/alert_success_view.dart';
import '../authentication/data/auth_repository.dart';
import '../authentication/presentation/login.dart';
import '../authentication/presentation/login/form.dart';
import '../avatars/avatars_creator_view.dart';
import '../dormitories/presentation/booking_page.dart';
import '../dormitories/presentation/dormitories_page.dart';
import '../dormitories/presentation/dormitory_page.dart';
import '../home/presentation/event_details.dart';
import '../home/presentation/general_view.dart';
import '../news/stories_view.dart';
import '../onboarding/domain/onboarding_repository.dart';
import '../onboarding/presentation/onboarding_view.dart';
import '../profile/presentation/profile.dart';
import '../settings/presentation/settings_view.dart';
import 'refresh_stream.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

mixin RouteOps {
  get path => null;

  get fullName => null;

  _Route subRoute(String name) {
    return _Route('${fullName}_$name', '$path/$name');
  }

  _Route parameter(String name) {
    return _Route('$fullName($name)', '$path/:$name', params: [name]);
  }
}

class _Route with RouteOps {
  @override
  final String path;

  @override
  final String fullName;

  final List<String> params;

  _Route(this.fullName, this.path, {params}) : params = params ?? [];

  String call(List<dynamic> params) {
    assert(this.params.length == params.length);

    var fullPath = path;
    for (var i = 0; i < params.length; i++) {
      fullPath =
          fullPath.replaceFirst(':${this.params[i]}', params[i].toString());
    }

    return fullPath;
  }

  @override
  _Route subRoute(String name) {
    return _Route('${fullName}_$name', '$path/$name', params: params);
  }

  @override
  _Route parameter(String name) {
    return _Route('$fullName($name)', '$path/:$name',
        params: [...params, name]);
  }
}

enum RouteSpec with RouteOps {
  onboarding,
  signing,
  homepage,
  error,
  success,
  settings,
  avatar,
  login,
  register,
  profile,
  dormitories,
  eventDetails,
  news;

  @override
  String get path => '/$name';

  @override
  String get fullName => name;
}

extension ComplexRoutes on RouteSpec {
  static _Route dormitory = RouteSpec.dormitories.parameter('dormitoryId');
  static _Route eventDetails = RouteSpec.eventDetails.parameter('eventId');
  static _Route dormitoryBooking =
      dormitory.subRoute('booking').parameter('roomId');
}

final nextScreenProvider = StateProvider<String?>((_) => null);

extension AuthGuard on BuildContext {
  void pushGuard(WidgetRef ref, String nextScreen) {
    final user = ref.read(authRepositoryProvider).currentUser;

    if (user == null) {
      ref.read(nextScreenProvider.notifier).state = nextScreen;
      pushNamed(RouteSpec.login.fullName);
      return;
    }

    push(nextScreen);
  }
}

final routeSpecProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final onboardingRepository = ref.watch(onboardingRepositoryProvider);

  return GoRouter(
    initialLocation: '/homepage',
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) async {
      //TODO: fix delay
      final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
      if (!didCompleteOnboarding) {
        if (state.subloc != '/onboarding') {
          return '/onboarding';
        }
      }
      return null;
    },
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: ComplexRoutes.eventDetails.path,
        name: ComplexRoutes.eventDetails.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: EventDetails(eventId: state.params['eventId']!),
        ),
      ),
      GoRoute(
        path: RouteSpec.onboarding.path,
        name: RouteSpec.onboarding.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: RouteSpec.settings.path,
        name: RouteSpec.settings.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: const SettingsScreen(),
        ),
      ),
      GoRoute(
        path: RouteSpec.avatar.path,
        name: RouteSpec.avatar.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: const AvatarsCreatorScreen(),
        ),
      ),
      GoRoute(
        path: RouteSpec.dormitories.path,
        name: RouteSpec.dormitories.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: const DormitoriesPage(),
        ),
      ),
      GoRoute(
        path: ComplexRoutes.dormitory.path,
        name: ComplexRoutes.dormitory.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: DormitoryPage(dormitoryId: state.params['dormitoryId']!),
        ),
      ),
      GoRoute(
        path: ComplexRoutes.dormitoryBooking.path,
        name: ComplexRoutes.dormitoryBooking.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: DormitoryBookingPage(
            dormitoryId: state.params['dormitoryId']!,
            roomId: state.params['roomId']!,
          ),
        ),
      ),
      GoRoute(
        path: RouteSpec.error.path,
        name: RouteSpec.error.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: const AlertErrorView(),
        ),
      ),
      GoRoute(
        path: RouteSpec.success.path,
        name: RouteSpec.success.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: const AlertSuccessView(),
        ),
      ),
      GoRoute(
        path: RouteSpec.profile.path,
        name: RouteSpec.profile.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: RouteSpec.news.path,
        name: RouteSpec.news.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: const StoriesView(),
        ),
      ),
      // TODO(demezy): auth routing
      GoRoute(
        path: RouteSpec.login.path,
        name: RouteSpec.login.fullName,
        pageBuilder: (context, state) => CustomTransitionPage<dynamic>(
          key: state.pageKey,
          child: const LoginScreen(
            EmailPasswordSignInFormType.signIn,
          ),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: RouteSpec.register.path,
        name: RouteSpec.register.fullName,
        pageBuilder: (context, state) => CustomTransitionPage<dynamic>(
          key: state.pageKey,
          child: const LoginScreen(
            EmailPasswordSignInFormType.register,
          ),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        ),
      ),

      GoRoute(
        path: RouteSpec.homepage.path,
        name: RouteSpec.homepage.fullName,
        pageBuilder: (context, state) => MaterialPage<dynamic>(
          key: state.pageKey,
          child: const GeneralView(),
        ),
      ),
    ],
  );
});
