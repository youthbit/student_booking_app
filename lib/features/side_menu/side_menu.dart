import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../authentication/data/auth_repository.dart';
import '../avatars/avatars_repository.dart';
import '../avatars/domain/avatar.dart';
import '../avatars/widgets/avatar_view.dart';
import '../routing/router_spec.dart';
import 'side_menu_icon_button.dart';

final _renderedAvatarProvider =
    FutureProvider.autoDispose<RenderedAvatar?>((ref) async {
  final avatar = await ref.watch(avatarProvider.future);

  final renderedAvatarValue = ref.watch(renderedAvatarProvider(avatar).future);
  return await renderedAvatarValue;
});

// to use widget create globalkey and use SideMenuScreen.toggleMenu

class SideMenuScreen extends HookConsumerWidget {
  // widget that displays normally
  final Widget child;
  final GlobalKey<SideMenuState> menuStateKey;

  // menuStateKey is used to toggle menu inside child
  const SideMenuScreen({
    required this.child,
    required this.menuStateKey,
    // required key
    Key? key,
  }) : super(key: key);

  // call it when needed
  static toggleMenu(GlobalKey<SideMenuState> key) {
    if (key.currentState == null) {
      if (kDebugMode) {
        print('toggle filed');
        print(StackTrace.current);
      }
      return;
    }
    final _state = key.currentState!;
    if (_state.isOpened) {
      _state.closeSideMenu();
    } else {
      _state.openSideMenu();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpened = useState<bool>(false);
    final authRepository = ref.watch(authRepositoryProvider);
    final avatar = ref.watch(_renderedAvatarProvider);

    return SideMenu(
      maxMenuWidth: MediaQuery.of(context).size.width * 0.85,
      key: menuStateKey,
      type: SideMenuType.shrinkNSlide,
      inverse: true,
      onChange: (newState) {
        isOpened.value = newState;
      },
      background: Theme.of(context).colorScheme.background,

      // make menu behave like click to return
      child: GestureDetector(
        onTap: () {
          if (!isOpened.value) return;
          SideMenuScreen.toggleMenu(menuStateKey);
        },
        child: AbsorbPointer(
          absorbing: isOpened.value,
          child: child,
        ),
      ),

      menu: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        authRepository.currentUser?.name ?? 'Anon',
                        style: Theme.of(context).textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    avatar.when(
                      data: (avatar) {
                        return avatar == null
                            ? const Icon(CupertinoIcons.person)
                            : AvatarView(avatar: avatar, width: 50, height: 50);
                      },
                      error: (_, __) {
                        return const Icon(Icons.error);
                      },
                      loading: () {
                        return const Icon(Icons.loop);
                      },
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  MenuIconTextButton(
                    label: 'Профиль',
                    icon: CupertinoIcons.person,
                    onTap: () {
                      context.pushNamed(RouteSpec.profile.fullName);
                    },
                  ),
                  MenuIconTextButton(
                    label: 'Чат',
                    icon: CupertinoIcons.chat_bubble,
                    onTap: () {
                      throw UnimplementedError('Chat is not implemented');
                    },
                  ),
                  MenuIconTextButton(
                    label: 'Настройки',
                    icon: Icons.settings_outlined,
                    onTap: () {
                      context.pushNamed(RouteSpec.settings.fullName);
                    },
                  ),
                ],
              ),
              MenuIconTextButton(
                label: 'Выход',
                icon: Icons.exit_to_app,
                color: Theme.of(context).colorScheme.error,
                onTap: authRepository.signOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
