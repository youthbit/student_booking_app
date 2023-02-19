import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/general/bottom_dialog.dart';
import '../data/events_repository.dart';
import 'event_booking_view.dart';

class EventDetails extends ConsumerWidget {
  final String eventId;

  const EventDetails({Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(eventsRepositoryProvider).retrieveEventDetails(eventId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.centerLeft,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 12.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                          onPressed: () => context.pop(),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.favorite_border_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0,
                        top: 18.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.all(20.0),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 10.0,
                                ),
                                itemCount: snapshot.data.photos.length,
                                itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data.photos[index],
                                    placeholder: (context, url) => ColoredBox(
                                      color: Theme.of(context)
                                          .buttonTheme
                                          .colorScheme!
                                          .onBackground,
                                      child: Container(
                                        width: 100.0,
                                        color: const Color(0xFF393939),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Theme.of(context)
                                                .buttonTheme
                                                .colorScheme!
                                                .background,
                                          ),
                                        ),
                                      ),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      snapshot.data.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AutoSizeText(
                                      'Description',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      maxLines: 1,
                                    ),
                                    ExpandableText(
                                      snapshot.data.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      maxLines: 10,
                                      expandText: 'Read more',
                                      linkColor: Colors.white,
                                      collapseText: '',
                                      collapseOnTextTap: true,
                                      expandOnTextTap: true,
                                      animation: true,
                                      animationDuration:
                                          const Duration(milliseconds: 500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ColoredBox(
                              color: Theme.of(context).iconTheme.color!,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 20.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: max(
                                      MediaQuery.of(context).viewPadding.bottom,
                                      20.0),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Стоимость',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryIconTheme
                                                      .color),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${snapshot.data.price}₽',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .primaryIconTheme
                                                            .color),
                                              ),
                                              TextSpan(
                                                text: '/ человек',
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
                                            BottomDialog.show(
                                              context,
                                              title:
                                                  const Text('Новая заявка'),
                                              body: EventBookingView(
                                                event: snapshot.data,
                                              ),
                                              height: 0.64,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .primaryIconTheme
                                                .color,
                                            side: const BorderSide(width: 2),
                                          ),
                                          child: Text(
                                            'Забронировать',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
