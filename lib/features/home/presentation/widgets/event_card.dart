import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../domain/event.dart';

class EventCard extends StatelessWidget {
  final int index;
  final Event event;

  const EventCard({
    required this.index,
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(
                0,
                3,
              ), // changes position of shadow
            ),
          ],
        ),
        key: ValueKey<int>(index),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .05,
                    child: AutoSizeText(
                      '${event.day} ${event.month}',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.circle,
                      size: 24,
                      color: Colors.amberAccent,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: AutoSizeText(
                event.name,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 28),
                textAlign: TextAlign.left,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            Expanded(
              flex: 3,
              child: Wrap(
                runSpacing: MediaQuery.of(context).size.height * .01,
                spacing: MediaQuery.of(context).size.width * .01,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * .05,
                      child: AutoSizeText(
                        event.type.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.white),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * .05,
                      child: AutoSizeText(
                        'Цена: ${event.price}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.white),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * .05,
                      child: AutoSizeText(
                        'Вы'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.white),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * .05,
                      child: AutoSizeText(
                        'Ого'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.white),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * .05,
                      child: AutoSizeText(
                        'Корпоратив'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.white),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
