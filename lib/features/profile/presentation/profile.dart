import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/general/on_tap_opacity_container.dart';
import '../../authentication/data/auth_repository.dart';
import '../../avatars/avatars_repository.dart';
import '../../avatars/domain/avatar.dart';
import '../../avatars/widgets/avatar_view.dart';

final _renderedAvatarProvider =
    FutureProvider.autoDispose<RenderedAvatar?>((ref) async {
  final avatar = await ref.watch(avatarProvider.future);

  final renderedAvatarValue = ref.watch(renderedAvatarProvider(avatar).future);
  return await renderedAvatarValue;
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatar = ref.watch(_renderedAvatarProvider);
    final authRepository = ref.read(authRepositoryProvider);
    return Material(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.centerLeft,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 24.0, right: 24.0, top: 80, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .4,
                        width: MediaQuery.of(context).size.width * .4,
                        child: avatar.when(
                          data: (avatar) {
                            return avatar == null
                                ? const Icon(CupertinoIcons.person)
                                : AvatarView(
                                    avatar: avatar,
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    height:
                                        MediaQuery.of(context).size.width * .4,
                                  );
                          },
                          error: (_, __) {
                            return const Icon(Icons.error);
                          },
                          loading: () {
                            return const Icon(Icons.loop);
                          },
                        ),
                      ),
                      OnTapOpacityContainer(
                        onTap: () {},
                        child: Container(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C7DF7),
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AutoSizeText(
                authRepository.currentUser == null
                    ? 'Анонимный аккаунт'
                    : authRepository.currentUser!.name,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 48),
                maxLines: 1,
              ),
              AutoSizeText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                style: Theme.of(context).textTheme.displayMedium,
                maxLines: 1,
              ),
              AutoSizeText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                style: Theme.of(context).textTheme.displayMedium,
                maxLines: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '12\n',
                            style: Theme.of(context).textTheme.displayLarge,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Поездок',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '8\n',
                            style: Theme.of(context).textTheme.displayLarge,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Городов',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '5\n',
                            style: Theme.of(context).textTheme.displayLarge,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Событий',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Spacer(),
              Stack(
                children: [
                  ClipRect(
                    child: Container(
                      height: MediaQuery.of(context).size.width * .8,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/lol.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0, left: 100.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        border: Border.all(
                          color: const Color(0xFF6C7DF7),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'В разработке',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
