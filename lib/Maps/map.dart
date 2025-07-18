import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Polygon> Polygons = [
      Polygon(
        points: [
          LatLng(51.5251217665913, -0.08750429301284157),
          LatLng(51.52472895081553, -0.08759899699452944),
          LatLng(51.52334424817988, -0.08734645304377864),
          LatLng(51.52229341736876, -0.08707812509587143),
          LatLng(51.52165505036376, -0.0870465571028376),
          LatLng(51.52059435924525, -0.08723596506618492),
          LatLng(51.52045686043991, -0.08723596506618492),
          LatLng(51.52025061145315, -0.08523139745747699),
          LatLng(51.52126220468193, -0.0848367975335691),
          LatLng(51.521213098733455, -0.08355829378393764),
          LatLng(51.52200860857974, -0.08332153382906426),
        ],
        color: Colors.redAccent,
        isFilled: true,
      )
    ];

    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(31.582045, 74.329376),
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => _launchOpenStreetMap(),
            ),
          ],
        ),
      ],
    );
  }

  // Function to launch OpenStreetMap URL
  void _launchOpenStreetMap() async {
    const url = 'https://openstreetmap.org/copyright';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
