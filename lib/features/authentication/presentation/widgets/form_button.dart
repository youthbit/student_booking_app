import 'package:flutter/material.dart';
import '../../../../config/general/on_tap_opacity_container.dart';

class PrimaryButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final Widget? child;

  const PrimaryButton({
    this.isLoading = false,
    this.onPressed,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: OnTapOpacityContainer(
        onTap: () => onPressed!.call(),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: Theme.of(context).buttonTheme.colorScheme?.onBackground,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).buttonTheme.colorScheme?.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(child: child ?? const SizedBox.shrink()),
                  ),
          ),
        ),
      ),
    );
  }
}
