import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:story_view/story_view.dart';

import '../avatars/avatars_data.dart';
import '../avatars/domain/part_type.dart';
import 'data/news_repository.dart';

class StoriesView extends ConsumerStatefulWidget {
  const StoriesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => StoriesViewState();
}

class StoriesViewState extends ConsumerState<StoriesView> {
  late StoryController controller;

  @override
  void initState() {
    super.initState();
    controller = StoryController();
  }

  @override
  Widget build(BuildContext context) {
    final news = ref.watch(newsProvider);

    return Scaffold(
      body: news.when(
        data: (news) => StoryView(
          storyItems: news
              .map(
                (news) => StoryItem(
                  ColoredBox(
                    color: Color(
                      (listColors(PartType.body).toList()..shuffle()).first,
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 30.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              news.content,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(height: 50.0,),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: CachedNetworkImage(
                                  imageUrl: news.cover,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    key: ValueKey(news.id),
                  ),
                  duration: const Duration(seconds: 3),
                ),
              )
              .toList(),
          controller: controller,
          onComplete: () {
            context.pop();
          },
          indicatorColor: Colors.black,
          onVerticalSwipeComplete: (direction) {},
        ),
        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
