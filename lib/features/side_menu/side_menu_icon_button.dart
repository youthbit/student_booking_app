import 'package:flutter/material.dart';

import '../../config/general/on_tap_opacity_container.dart';

class MenuIconTextButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const MenuIconTextButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: OnTapOpacityContainer(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color ?? Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                  ),
              //     Theme.of(context).textButtonTheme.style?.textStyle?.resolve(
              //   <MaterialState>{},
              // ),
            ),
            const SizedBox(
              width: 16,
            ),
            Icon(icon, color: color ?? Theme.of(context).colorScheme.onSurface),
          ],
        ),
      ),
    );
  }
}
