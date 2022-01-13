import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapWithMarkers extends StatelessWidget {
  const MapWithMarkers({
    Key? key,
    required this.mapController,
    required this.onMapLongPress,
    required this.notes,
    required this.onMarkerTap,
  }) : super(key: key);

  final MapController mapController;
  final List<Note> notes;
  final void Function(LatLng latLng) onMapLongPress;
  final void Function(Note note) onMarkerTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Directory>(
      future: MapCachingManager.normalCache,
      builder: (context, cacheDir) {
        if (!cacheDir.hasData) {
          return const Center(child: Text('Waiting for the caching directory...'));
        }
        return FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, prefs) {
            if (!prefs.hasData) {
              return const Center(child: Text('Waiting for persistent storage...'));
            }
            return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onLongPress: (tapPosition, latLng) => onMapLongPress(latLng),
                center: LatLng(0, 0),
                zoom: 10,
                minZoom: 3.5,
                maxZoom: 17,
                plugins: [
                  MarkerClusterPlugin(),
                ],
              ),
              children: [
                TileLayerWidget(
                  options: TileLayerOptions(
                    tileProvider: StorageCachingTileProvider.fromMapCachingManager(
                      MapCachingManager(cacheDir.data!, 'Default Store'),
                      behavior: CacheBehavior.cacheFirst,
                      cachedValidDuration: const Duration(days: 16),
                      maxStoreLength: 20000,
                    ),
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return const Text("© OpenStreetMap contributors");
                    },
                    retinaMode: true,
                  ),
                ),
                LocationMarkerLayerWidget(),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                      maxClusterRadius: 60,
                      size: const Size(40, 40),
                      fitBoundsOptions: const FitBoundsOptions(
                        padding: EdgeInsets.all(50),
                        maxZoom: 17,
                      ),
                      rotate: true,
                      rotateAlignment: AlignmentDirectional.bottomCenter,
                      anchor: AnchorPos.align(AnchorAlign.center),
                      markers: _buildMarkersList(context, notes: notes),
                      showPolygon: false,
                      builder: (BuildContext context, List<Marker> markers) {
                        return FloatingActionButton(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                          child: Text(markers.length.toString()),
                          onPressed: null,
                        );
                      }),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<Marker> _buildMarkersList(BuildContext context, {required List<Note> notes}) {
    List<Marker> markers = [];
    for (var note in notes) {
      markers.add(Marker(
        height: 56,
        width: 100,
        anchorPos: AnchorPos.align(AnchorAlign.top),
        point: LatLng(note.latitude, note.longitude),
        builder: (context) => GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                note.title,
                style: const TextStyle(color: Colors.black),
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              Image.asset(
                'assets/images/note_icon.png',
                height: 40,
                width: 40,
              ),
            ],
          ),
          onTap: () => onMarkerTap(note),
        ),
      ));
    }
    return markers;
  }
}
