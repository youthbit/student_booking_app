import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import '../../domain/room.dart';

class RoomCard extends StatelessWidget {
  final String dormitoryId;
  final Room room;
  final bool selected;
  final void Function() onSelect;

  const RoomCard({
    required this.dormitoryId,
    required this.room,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: InkWell(
        onTap: onSelect,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF393939),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: room.photos[0],
                    width: 130.0,
                    height: 130.0,
                    placeholder: (context, url) => ColoredBox(
                      color: Theme.of(context)
                          .buttonTheme
                          .colorScheme!
                          .onBackground,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .background,
                        ),
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandableText(
                        room.description,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 4,
                        expandText: 'Подробнее',
                        linkColor: Colors.white,
                        collapseText: '',
                        collapseOnTextTap: true,
                        expandOnTextTap: true,
                        animation: true,
                        animationDuration: const Duration(milliseconds: 500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room.type,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${room.price}₽',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    TextSpan(
                                      text: '/ Ночь',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Icon(
                            selected
                                ? Icons.check_circle_outline_rounded
                                : Icons.circle_outlined,
                            size: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .fontSize,
                            color: selected
                                ? Colors.white
                                : Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .color,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
