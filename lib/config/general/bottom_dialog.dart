import 'package:flutter/material.dart';

class BottomDialog {
  static void show(
    BuildContext context, {
    Widget? title,
    Widget? body,
    double height = 0.8,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: Theme.of(context).shadowColor.withOpacity(0.1),
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * height +
              MediaQuery.of(context).viewInsets.bottom / 2,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 8.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 8,
                    width: 56,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.displayLarge!,
                    child: title ?? const Spacer(),
                  ),
                ),
                Expanded(child: body ?? const Spacer()),
              ],
            ),
          ),
        );
      },
    );
  }
}
