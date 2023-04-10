import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final List<LatLng> _latLngList = [
  LatLng(13.02, 77.51),
  LatLng(13.05, 77.53),
  LatLng(13.055, 77.54),
  LatLng(13.059, 77.55),
  LatLng(13.07, 77.55),
  LatLng(13.1, 77.5342),
  LatLng(13.12, 77.51),
  LatLng(13.015, 77.53),
  LatLng(13.155, 77.54),
  LatLng(13.159, 77.55),
  LatLng(13.17, 77.55),
];

final markers = _latLngList
    .map(
      (point) => Marker(
        point: point,
        width: 40,
        height: 40,
        builder: (context) => GestureDetector(
          onTap: () {
            print(point.longitude);
          },
          child: const Icon(
            Icons.pin_drop,
            size: 60,
            color: Colors.blueAccent,
          ),
        ),
      ),
    )
    .toList();

class AnimatedMarkersMap extends StatefulWidget {
  const AnimatedMarkersMap({super.key});

  @override
  State<AnimatedMarkersMap> createState() => _AnimatedMarkersMapState();
}

class _AnimatedMarkersMapState extends State<AnimatedMarkersMap> {
  final _pageController = PageController();
  // List<Marker> _buildMarkers() {
  @override
  Widget build(BuildContext context) {
    // final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 16,
              zoom: 13,
              center: LatLng(13, 77.5),
            ),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                // userAgentPackageName: 'com.example.app',
                // retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
              ),
              MarkerLayer(markers: markers),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(13, 77.5),
                    builder: (_) {
                      return _MyLocationMaker();
                    },
                  )
                ],
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              itemBuilder: ((context, index) {
                final item = markers[index];
                return _MapItemDetails(mapMarker: item);
              }),
              itemCount: markers.length,
            ),
          )
        ],
      ),
    );
  }
}

class _MyLocationMaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  final Marker mapMarker;
  const _MapItemDetails({required this.mapMarker});
  @override
  Widget build(BuildContext context) {
    final _styleTitle = TextStyle(color: Colors.grey[800], fontSize: 20.0);
    final _styleAddress = TextStyle(color: Colors.grey[800], fontSize: 20.0);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    child: Icon(Icons.local_pizza),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Estacion de Gasolina Haina",
                          style: _styleTitle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "K12 CARRETERA SANCHEZ",
                          style: _styleAddress,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
