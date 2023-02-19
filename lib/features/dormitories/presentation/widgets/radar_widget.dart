import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'radar_painter.dart';

class RadarWidget extends StatefulWidget {
  const RadarWidget({super.key});

  @override
  State<StatefulWidget> createState() => RadarWidgetState();
}

class RadarWidgetState extends State<RadarWidget>
    with TickerProviderStateMixin {
  var updateTime = 0.0;

  @override
  void initState() {
    super.initState();
    createTicker((elapsed) {
      updateTime = elapsed.inMilliseconds / 1000;
      setState(() {});
    }).start();
  }

  @override
  dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: FutureBuilder<FragmentProgram>(
        future: _initShader(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final shader = snapshot.data!.fragmentShader();
            final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
            final radarColor = Theme.of(context).primaryColor;

            try {
              shader
                ..setFloat(0, 150)
                ..setFloat(1, 150)
                ..setFloat(2, backgroundColor.red / 255)
                ..setFloat(3, backgroundColor.green / 255)
                ..setFloat(4, backgroundColor.blue / 255)
                ..setFloat(5, radarColor.red / 255)
                ..setFloat(6, radarColor.green / 255)
                ..setFloat(7, radarColor.blue / 255)
                ..setFloat(8, updateTime);
            } catch (e) {
              return Text(e.toString());
              // fucking shaders
            }

            return Stack(
              children: [
                CustomPaint(
                  painter: RadarPainter(shader, updateTime),
                  child: Container(),
                ),
                Transform.rotate(
                  angle: cos(updateTime),
                  child: Center(
                    child: Icon(
                      Icons.navigation_rounded,
                      size: 30.0,
                      color: radarColor,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<FragmentProgram> _initShader() {
    return FragmentProgram.fromAsset('assets/radar.glsl');
  }
}
