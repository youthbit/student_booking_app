import 'package:flutter/material.dart';

class BenefitsSubscreen extends StatelessWidget {
  const BenefitsSubscreen({
    Key? key,
    this.controller,
  }) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 200.0),
      ],
    );
  }
}
