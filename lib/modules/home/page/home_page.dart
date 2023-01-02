import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../data/term/app_term.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late io.Socket socket;
  late Map<MarkerId, Marker> _marker;

  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(21.006560, 105.848429), zoom: 14);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    _marker = <MarkerId, Marker>{};
    _marker.clear();
    initSocket();
  }

  Future<void> initSocket() async {
    try {
      // socket = io.Socket(io: );
      // socket = io.Socket()
      socket = io.io(
        'https://ba66-2402-800-61b1-e0f1-6913-6d2a-306e-5781.ap.ngrok.io',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
          'query': {
            'accessToken':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiZlVaS3RHcWZ4UmI3Zmt3SXRodzJEYVA0ZU9mMSIsInBob25lTnVtYmVyIjoiKzg0MzU3Njk4NTcwIiwibmFtZSI6Iktow6FuaCIsInNvc051bWJlcnMiOltdLCJmY21Ub2tlbnMiOlsiZlFjdGJobFNSOEtLZmViR084TzNBYzpBUEE5MWJGMkVqckQ5ckNYWnhlbzVjUGFvb3ZDMDJJREhTelVCM3l4akhCWHNWM2JubDVyY19ZeDdIWEZPMXdvcVY4ZjNMN1lQd2xFY2JTbVFXdHBvcTF5UjFINzlib3hKd24tY2htNElWN2FNRV9hU0RhNWdCSnNqdUNFSDVYRDVWY003Um5ibzk5biJdLCJjaXRpemVuTnVtYmVyIjoiMDMwMzAzMDMwMzAiLCJhdmF0YXJVcmwiOm51bGwsImRhdGVPZkJpcnRoIjoiMjAwMC8wOS8wMyIsImFkZHJlc3MiOiJITiIsImxhc3RTaWduSW5BdCI6IjIwMjItMTItMjNUMTU6MjM6NDcuNzc3WiJ9LCJpYXQiOjE2NzE4MDkwMjcsImV4cCI6MTY3NDQwMTAyN30.rsMlgMEfycaCwzSjqrQumfAO6HgQuwQLgXIxrE1DiUI'
          }
        },
      );
      socket.connect();
      socket.onConnect((data) => {
            DebugPrint.dataLog(
                currentFile: "Home_page", title: "socket connected", data: data)
          });
      socket.on(
        'location-change',
        (data) async {
          var latLng = data;

          DebugPrint.dataLog(
              currentFile: 'homepage',
              title: 'Data on emit',
              data: latLng.toString());
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  latLng["lat"] as double,
                  latLng["lng"] as double,
                ),
                zoom: 19,
              ),
            ),
          );

          // var image = await BitmapDescriptor.fromAssetImage(
          //   const ImageConfiguration(),
          //   'assets/images/motorbike_location.png',
          // );
          var image = BitmapDescriptor.defaultMarkerWithHue(10);

          Marker marker = Marker(
            markerId: const MarkerId('ID'),
            icon: image,
            position: LatLng(
              latLng["lat"],
              latLng["lng"],
            ),
          );

          setState(() {
            _marker[const MarkerId('ID')] = marker;
          });
        },
      );
    } catch (e) {
      DebugPrint.dataLog(
          currentFile: 'home_page', title: 'Init socket IO Fail', data: e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppPageName.homepage),
      ),
      body: GoogleMap(
        // polylines: {},
        markers: Set<Marker>.of(_marker.values),
        initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        onMapCreated: ((GoogleMapController controller) {
          _controller.complete(controller);
        }),
      ),
    );
  }
}
