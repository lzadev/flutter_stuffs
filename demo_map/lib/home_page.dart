import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PopupController _popupController = PopupController();
  final MapController _mapController = MapController();

  final double _zoom = 7;
  final List<LatLng> _latLngList = [
    LatLng(13, 77.5),
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
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    // _mapController.state = this;
    _markers = _latLngList
        .map((point) => Marker(
              point: point,
              width: 60,
              height: 60,
              builder: (context) => const Icon(
                Icons.pin_drop,
                size: 60,
                color: Colors.blueAccent,
              ),
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _latLngList[0],
          zoom: _zoom,
          keepAlive: true,
          bounds: LatLngBounds.fromPoints(_latLngList),
          onTap: ((tapPosition, point) {
            _popupController.hideAllPopups();
          }),
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            minZoom: 2,
            maxZoom: 18,
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
          ),
          // MarkerLayer(
          //   markers: _markers,
          // ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 190,
              disableClusteringAtZoom: 16,
              size: const Size(50, 50),
              fitBoundsOptions: const FitBoundsOptions(
                padding: EdgeInsets.all(50),
              ),
              markers: _markers,
              polygonOptions: const PolygonOptions(
                  borderColor: Colors.blueAccent,
                  color: Colors.black12,
                  borderStrokeWidth: 3),
              popupOptions: PopupOptions(
                popupState: PopupState(initiallySelectedMarkers: _markers),
                popupSnap: PopupSnap.mapTop,
                popupController: _popupController,
                popupBuilder: (_, marker) => Container(
                  color: Colors.amberAccent,
                  child: const Text('Popup'),
                ),
              ),
              builder: (context, markers) {
                return Container(
                  // decoration: const BoxDecoration(
                  //     color: Color.fromARGB(255, 255, 0, 47),
                  //     shape: BoxShape.circle),
                  child: Text('${markers.length}'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
