import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../authentication/data/auth_utils.dart';

final themeProvider = FutureProvider.autoDispose.family<String, String>((ref, theme) async {
  final darkMapStyle =
      await rootBundle.loadString('assets/map_styles/${theme}.json');

  return darkMapStyle;
});

class GMapView extends ConsumerStatefulWidget {
  final CameraPosition initialPosition;
  final Set<Marker>? markers;
  final Set<Circle>? circles;
  final void Function(GoogleMapController controller)? mapCreated;
  final void Function()? mapLoaded;
  final void Function(CameraPosition position)? onCameraMove;
  final void Function()? onCameraIdle;

  const GMapView({
    required this.initialPosition,
    this.mapCreated,
    this.mapLoaded,
    this.onCameraIdle,
    this.onCameraMove,
    this.markers,
    this.circles,
    super.key,
  });

  @override
  ConsumerState<GMapView> createState() => GMapViewState();
}

class GMapViewState extends ConsumerState<GMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final _themeProvider = themeProvider(Theme.of(context).brightness.name);

    ref.listen(_themeProvider, (previous, next) async {
      final controller = await _controller.future;
      await controller.setMapStyle(next.value);
    });

    return GoogleMap(
      markers: widget.markers ?? const <Marker>{},
      circles: widget.circles ?? const <Circle>{},
      initialCameraPosition: widget.initialPosition,
      onMapCreated: (controller) {
        _controller.complete(controller);
        widget.mapCreated?.call(controller);
        controller
            .setMapStyle(
              ref.read(_themeProvider).value,
            )
            .then((_) => delay(milliseconds: 250))
            .then((_) {
          widget.mapLoaded?.call();
        });
      },
      onCameraMove: widget.onCameraMove,
      onCameraIdle: widget.onCameraIdle,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      compassEnabled: false,
    );
  }
}
