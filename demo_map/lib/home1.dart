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

class AnimatedMarkersMap extends StatefulWidget {
  const AnimatedMarkersMap({super.key});

  @override
  State<AnimatedMarkersMap> createState() => _AnimatedMarkersMapState();
}

class _AnimatedMarkersMapState extends State<AnimatedMarkersMap>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = 0;
  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (var i = 0; i < _latLngList.length; i++) {
      final item = _latLngList[i];
      _markerList.add(
        Marker(
          point: item,
          width: 55,
          height: 55,
          builder: (context) => GestureDetector(
            onTap: () {
              _selectedIndex = i;
              setState(() {
                _pageController.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                );
              });
              // print(point.longitude);
            },
            child: _LocationMarker(
              selected: _selectedIndex == i,
            ),
          ),
        ),
      );
    }

    return _markerList;
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // List<Marker> _buildMarkers() {
  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
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
              MarkerLayer(markers: _markers),
              MarkerLayer(
                markers: [
                  Marker(
                    height: 60,
                    width: 60,
                    point: LatLng(13, 77.5),
                    builder: (_) {
                      return _MyLocationMaker(_animationController);
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
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                final item = _markers[index];
                return _MapItemDetails(mapMarker: item);
              }),
              itemCount: _markers.length,
            ),
          )
        ],
      ),
    );
  }
}

class _LocationMarker extends StatelessWidget {
  const _LocationMarker({super.key, this.selected = false});
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        // height: 80,
        // width: 80,
        duration: const Duration(milliseconds: 400),
        child: Icon(
          Icons.pin_drop,
          color: Colors.indigo,
          size: selected ? 60 : 40,
        ),
      ),
    );
  }
}

class _MyLocationMaker extends AnimatedWidget {
  const _MyLocationMaker(Animation<double> animation, {Key? key})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(0.5, 1.0, value)!;
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 50 * newValue,
              width: 50 * newValue,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.indigo.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
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
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              color: Colors.indigo,
              elevation: 6,
              child: const Text(
                'CLICK',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
