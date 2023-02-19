import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';

class UrbanPlannersSubscreen extends StatefulWidget {
  final ScrollController controller;

  const UrbanPlannersSubscreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<UrbanPlannersSubscreen> createState() => _UrbanPlannersSubscreenState();
}

class _UrbanPlannersSubscreenState extends State<UrbanPlannersSubscreen>
    with SingleTickerProviderStateMixin {
  late FlutterGifController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FlutterGifController(vsync: this);
    _controller.animateTo(29, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      if (widget.controller.offset < 500) {
        _controller
          ..reset()
          ..animateTo(29, duration: const Duration(seconds: 1));
      }
    });
    // widget.controller!.animateTo(1540,
    //     duration: const Duration(milliseconds: 2300),
    //     curve: Curves.ease);
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: SizedBox(
        //     width: MediaQuery.of(context).size.width * .8,
        //     child: ClipOval(
        //       child: GifImage(
        //         controller: _controller,
        //         image: const AssetImage("assets/gifs/island.gif"),
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(height: MediaQuery.of(context).size.height),
        _buildExteriorInfoSection(),
        SizedBox(height: MediaQuery.of(context).size.height * 2),
      ],
    );
  }

  Widget _buildExteriorInfoSection() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }
}
