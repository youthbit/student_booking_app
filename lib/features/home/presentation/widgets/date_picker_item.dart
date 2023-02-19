import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatePickerItem extends ConsumerWidget {
  final String day;
  final String month;
  final bool isSelected;

  const DatePickerItem({
    required this.isSelected,
    required this.day,
    required this.month,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color:
            isSelected ? Theme.of(context).iconTheme.color : Colors.transparent,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: AutoSizeText(
                day,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 28,
                      color: isSelected
                          ? Theme.of(context).primaryIconTheme.color
                          : Theme.of(context).iconTheme.color,
                    ),
                maxLines: 1,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                month,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isSelected
                          ? Theme.of(context).primaryIconTheme.color
                          : Theme.of(context).iconTheme.color,
                    ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
