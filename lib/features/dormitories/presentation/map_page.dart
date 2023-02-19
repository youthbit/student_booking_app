import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../exceptions/app_exception.dart';
import '../data/dormitories_repository.dart';
import '../domain/dormitory.dart';
import 'widgets/gmap_view.dart';
import 'widgets/search_sheet.dart';

final userPositionProvider = FutureProvider((ref) async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw const AppException.someErrorOccurred();
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw const AppException.someErrorOccurred();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw const AppException.someErrorOccurred();
  }

  return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
});

double radiusToZoom(latitude, kilometers) => log(38000 * cos(latitude * pi / 180) / kilometers) / log(2) - 1;

class MapPage extends ConsumerStatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  ConsumerState<MapPage> createState() => MapPageState();
}

class MapPageState extends ConsumerState<MapPage>
    with AutomaticKeepAliveClientMixin {
  late ClusterManager<Dormitory> _clusterManager;

  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  bool _mapLoaded = false;

  @override
  void initState() {
    super.initState();
    _clusterManager = ClusterManager([], _updateMarkers);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userPosition = ref.watch(userPositionProvider);
    final searchRadius = ref.watch(searchRadiusProvider);

    ref
      ..listen(dormitoriesProvider, (previous, next) {
        if (!next.hasValue) return;

        _clusterManager.setItems(next.value!);
      })
      ..listen(searchRadiusProvider, (previous, next) async {
        final userPosition = await ref.watch(userPositionProvider.future);

        _controller?.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(userPosition.latitude, userPosition.longitude),
            radiusToZoom(userPosition.latitude, next),
          ),
        );
      });

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.65,
            child: userPosition.when(
              data: (position) => GMapView(
                initialPosition: CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: radiusToZoom(position.latitude, searchRadius),
                ),
                markers: _markers,
                circles: {
                  Circle(
                    circleId: const CircleId('searchRadius'),
                    fillColor: Colors.green.withOpacity(0.5),
                    strokeWidth: 0,
                    center: LatLng(position.latitude, position.longitude),
                    radius: searchRadius * 1000,
                  )
                },
                mapCreated: (controller) {
                  _clusterManager.setMapId(controller.mapId);
                  setState(() {
                    _controller = controller;
                  });
                },
                mapLoaded: () {
                  setState(() {
                    _mapLoaded = true;
                  });
                },
                onCameraMove: _clusterManager.onCameraMove,
                onCameraIdle: _clusterManager.updateMap,
              ),
              error: (error, stacktrace) => const SizedBox.shrink(),
              loading: SizedBox.shrink,
            ),
          ),
          const SearchSheet(key: ValueKey('search_sheet')),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _mapLoaded
                ? null
                : SizedBox.expand(
                    key: const ValueKey('loader'),
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      _markers = markers;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
