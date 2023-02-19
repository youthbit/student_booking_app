import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/router_spec.dart';
import '../../domain/dormitory.dart';

class DormitoryCard extends StatelessWidget {
  const DormitoryCard(this.dormitory, {super.key});

  final Dormitory dormitory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: InkWell(
        onTap: () {
          context.push(ComplexRoutes.dormitory([dormitory.id]));
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: dormitory.photos[0],
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
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: SizedBox(
                    height: 88.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          dormitory.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 2,
                        ),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: SizedBox(
                                  width: 36.0,
                                  child: Stack(
                                    children: [
                                      const Icon(
                                        Icons.currency_ruble,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      Positioned(
                                        left: 10.0,
                                        child: Icon(
                                          Icons.currency_ruble,
                                          size: 16,
                                          color: dormitory.priceMin >= 100
                                              ? Colors.white
                                              : Colors.white54,
                                        ),
                                      ),
                                      Positioned(
                                        left: 20.0,
                                        child: Icon(
                                          Icons.currency_ruble,
                                          size: 16,
                                          color: dormitory.priceMin >= 200
                                              ? Colors.white
                                              : Colors.white54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontSize: 16, color: Colors.white),
                                text: dormitory.priceMax != dormitory.priceMin
                                    ? '${dormitory.priceMin} – ${dormitory.priceMax}'
                                    : '${dormitory.priceMax}',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
