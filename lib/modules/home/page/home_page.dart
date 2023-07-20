import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide BlocProvider;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../lib.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late io.Socket socket;
  late Map<MarkerId, Marker> _marker;

  // ignore: prefer_final_fields
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(21.006560, 105.848429), zoom: 14);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late bool isOnAntiThief;

  late bool isWarning;
  bool isLoadingOfWarning = false;

  final _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    isOnAntiThief = true;
    isWarning = true;
    _marker = <MarkerId, Marker>{};
    _marker.clear();
    initSocket();
    _homeBloc.add(
      HomeBlocEvent(
        homeBlocEvent: HomeBlocEventEnum.getDeviceInfor,
        stateToggleAntiThief: isOnAntiThief,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: const PreferredSize(
              preferredSize: Size.zero,
              child: Divider(
                height: 2,
              )),
          title: const Text(AppPageName.homepage),
        ),
        body: BlocBuilder<HomeBloc, HomeBlocState>(
          bloc: _homeBloc,
          builder: (context, state) {
            final homeError = state.error;
            final device = state.device;
            if (device != null) {
              //remote false if check nullable, mock test
              isOnAntiThief = device.config?.antiTheft! ?? false;
              final statusDevice = device.status ?? 0;

              return Stack(
                children: [
                  _googleMap(),
                  statusDevice != 0
                      ?
                      //Get current location widget
                      WarningWidget(
                          isLoadingOfWarning: isLoadingOfWarning,
                          onPressed: () async {
                            setState(
                              () {
                                isWarning = !isWarning;
                                isLoadingOfWarning = true;
                              },
                            );
                            await showConfirmSafeDialog(context);
                          },
                        )
                      : GetLocationWidget(onPressed: () {
                          setState(() {
                            isWarning = !isWarning;
                          });
                          _homeBloc.add(HomeBlocEvent(
                            stateToggleAntiThief: isOnAntiThief,
                            homeBlocEvent: HomeBlocEventEnum.getCurrentLocation,
                          ));
                        }),
                  //toggle antithief widget
                  Positioned(
                      right: 15,
                      top: 15,
                      child: ConnectionBatteryStatusWidget(
                        batteryLevel: device.battery ?? 0,
                        isConnected: device.isConnected ?? true,
                      )),
                  Positioned(
                    left: 15,
                    bottom: 40,
                    child: ToggleAntiThiefWidget(
                      isOnAntiThief: isOnAntiThief,
                      onPressed: () async {
                        await toggleAntiThief(!isOnAntiThief);
                        setState(() {
                          isOnAntiThief = !isOnAntiThief;
                        });
                      },
                    ),
                  )
                ],
              );
            }
            if (homeError != null) {
              return Center(
                child: Text(
                  homeError.toString(),
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const LinkDeviceToUserWidget(isUseInHomePage: true),
            );
          },
        ),
      ),
    );
  }

  Widget _googleMap() {
    return GoogleMap(
      // polylines: {},
      markers: Set<Marker>.of(_marker.values),
      initialCameraPosition: _cameraPosition,
      mapType: MapType.normal,
      onMapCreated: ((GoogleMapController controller) {
        _controller.complete(controller);
      }),
    );
  }

  Future<void> toggleAntiThief(bool antiThiefState) async {
    _homeBloc.add(
      HomeBlocEvent(
        homeBlocEvent: HomeBlocEventEnum.toggleAntiThief,
        stateToggleAntiThief: antiThiefState,
      ),
    );
  }

  Future<void> showConfirmSafeDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm off warning'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _homeBloc.add(
                  HomeBlocEvent(
                      homeBlocEvent: HomeBlocEventEnum.offWarning,
                      stateToggleAntiThief: isOnAntiThief),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    isLoadingOfWarning = false;
                  });
                  Navigator.pop(context, 'OK');
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void initSocket() async {
    try {
      // socket = io.Socket(io: );
      // socket = io.Socket()
      String backendUserAccessToken = await AuthLocalStorageRepo
              .getBackendUserAccesskenFromLocalStorage() ??
          AccessToken.accessToken;
      final String socketUrl = await getSocketUrl() ?? '';
      debugPrint(
          '///////////////////////////////////////////////////////////////////////////');
      debugPrint(socketUrl);
      socket = io.io(
        socketUrl,
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
          'query': {'accessToken': backendUserAccessToken}
        },
      );
      socket.connect();
      socket.onConnect((data) => {
            DebugPrint.dataLog(
                currentFile: "Home_page", title: "socket connected", data: data)
          });
      socket.on(
        AppSocketTerm.socketEvent,
        (data) async {
          var latLng = data;

          DebugPrint.dataLog(
              currentFile: 'homepage',
              title: 'Data on emit socket',
              data: latLng.toString());
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  latLng[AppSocketTerm.lat] == 0 ||
                          latLng[AppSocketTerm.lat] == null
                      ? 21.006560
                      : latLng[AppSocketTerm.lat],
                  latLng[AppSocketTerm.long] == 0 ||
                          latLng[AppSocketTerm.long] == null
                      ? 105.848429
                      : latLng[AppSocketTerm.long],
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
              latLng[AppSocketTerm.lat] == 0 ||
                      latLng[AppSocketTerm.lat] == null
                  ? 21.006560
                  : latLng[AppSocketTerm.lat],
              latLng[AppSocketTerm.long] == 0 ||
                      latLng[AppSocketTerm.long] == null
                  ? 105.848429
                  : latLng[AppSocketTerm.long],
            ),
          );

          setState(() {
            _marker[const MarkerId('ID')] = marker;
          });

          _homeBloc.add(HomeBlocEvent(
            homeBlocEvent: HomeBlocEventEnum.getDeviceInfor,
            stateToggleAntiThief: isOnAntiThief,
          ));
        },
      );
    } catch (e) {
      DebugPrint.dataLog(
          currentFile: 'home_page', title: 'Init socket IO Fail', data: e);
      // rethrow;
    }
  }
}
