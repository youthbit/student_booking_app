import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../authentication/data/auth_repository.dart';
import '../../routing/router_spec.dart';
import '../data/events_repository.dart';
import '../domain/event_details.dart';

class EventBookingView extends HookConsumerWidget {
  final EventDetails event;

  const EventBookingView({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.read(authRepositoryProvider);
    final guestsCount = useState(0);
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Text(
              'Please review auto-inserted data and fill required fields',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        authRepository.currentUser == null
            ? const Spacer()
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authRepository.currentUser!.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.alternate_email_rounded,
                            size: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              authRepository.currentUser!.email,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sim_card_outlined,
                            size: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              authRepository.currentUser!.phone,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
        const Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
                right: 20.0,
                bottom: 10.0,
              ),
              child: Text(
                'Guests',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFF393939),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('Students',
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text(
                            '18-35 years',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          guestsCount.value = guestsCount.value - 1;
                        },
                        icon: const Icon(
                          Icons.remove,
                        ),
                      ),
                      Text(
                        '${guestsCount.value}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          guestsCount.value = guestsCount.value + 1;
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        ColoredBox(
          color: Theme.of(context).iconTheme.color!,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
              bottom: max(MediaQuery.of(context).viewPadding.bottom, 20.0),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Theme.of(context).primaryIconTheme.color),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${event.price * guestsCount.value}₽',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color),
                          ),
                          TextSpan(
                            text: '/ person',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final eventsRepository =
                            ref.read(eventsRepositoryProvider);

                        if (authRepository.currentUser == null) {
                          context.push(RouteSpec.login.path);
                          return;
                        }

                        eventsRepository
                            .bookEvent(
                              user: authRepository.currentUser!,
                              guestsCount: guestsCount.value,
                              eventId: event.id,
                            )
                            .then(
                              (value) => context.push(RouteSpec.success.path),
                              onError: (error, stack) =>
                                  context.push(RouteSpec.error.path),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(
                            color: Theme.of(context).primaryIconTheme.color!,
                          ),
                        ),
                        backgroundColor:
                            Theme.of(context).primaryIconTheme.color,
                        disabledBackgroundColor: const Color(0xFF393939),
                      ),
                      child: Text(
                        'CONFIRM BOOKING',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context).iconTheme.color,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
