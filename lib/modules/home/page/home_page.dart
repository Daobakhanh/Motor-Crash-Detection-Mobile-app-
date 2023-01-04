import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/modules/home/bloc/home_bloc.dart';
import 'package:motorbike_crash_detection/modules/home/bloc/home_bloc_event.dart';
import 'package:motorbike_crash_detection/themes/app_color.dart';
import 'package:motorbike_crash_detection/themes/app_text_style.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../data/term/app_term.dart';
import '../../auth/repo/auth_local_storage_repo.dart';

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

  Future<void> initSocket() async {
    try {
      // socket = io.Socket(io: );
      // socket = io.Socket()
      String backendUserAccessToken = await AuthLocalStorageRepo
              .getBackendUserAccesskenFromLocalStorage() ??
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiZlVaS3RHcWZ4UmI3Zmt3SXRodzJEYVA0ZU9mMSIsInBob25lTnVtYmVyIjoiMDM1NzY5ODU3MCIsImFkZHJlc3MiOiIxOSBuZ28gMTUgVGEgUXVhbmcgQnV1IiwiYXZhdGFyVXJsIjpudWxsLCJjaXRpemVuTnVtYmVyIjoiMDMwMjAwMDA1ODIxIiwibmFtZSI6IkRhbyBCYSBLaGFuaCIsImRhdGVPZkJpcnRoIjoiMy85LzIwMDAiLCJzb3NOdW1iZXJzIjpbXSwiZmNtVG9rZW5zIjpbImZUUWVRRlpCU2xTSXhTMXJZaXFHb206QVBBOTFiRlROU2xaWl9SczlZV0RPQ0xlRF96M2NEd0FzU3d3RWtLVFE5MG9BaGZCRGJobXBvbnlKZ29pWnlqVF8xY0NyYXpmUTU4dERHZjdodGpJdGluVGJEclMxRVdORVI4MWNydDFnVXFEaWpaQndjNWt3Y05LUVM2NDlNQ1JOcUZrMzhHV0xYN3MiXSwibGFzdFNpZ25JbkF0IjoiMjAyMi0xMi0yNVQwNjozNjoxMC43MTFaIn0sImlhdCI6MTY3MTk1MDE3MCwiZXhwIjoxNjc0NTQyMTcwfQ.UyKibh5LaR8ClX4tBxd9YtIxVstNHwqzcIjaEQvQZnM';

      socket = io.io(
        'https://ba66-2402-800-61b1-e0f1-6913-6d2a-306e-5781.ap.ngrok.io',
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
              title: 'Data on emit',
              data: latLng.toString());
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  latLng[AppSocketTerm.lat] as double,
                  latLng[AppSocketTerm.long] as double,
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
              latLng[AppSocketTerm.lat],
              latLng[AppSocketTerm.long],
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

  late bool isOnAntiThief;
  bool isWarning = true;
  final _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    isOnAntiThief = true;
    _marker = <MarkerId, Marker>{};
    _marker.clear();
    initSocket();
    _homeBloc.add(
        HomeBlocEvent(homeBlocEvent: HomeBlocEventEnum.getCurrentLocation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppPageName.homepage),
      ),
      body: BlocBuilder<HomeBloc, HomeBlocState>(
        bloc: _homeBloc,
        builder: (context, state) {
          final homeError = state.error;
          final device = state.device;
          if (device != null) {
            isOnAntiThief = device.config!.antiTheft!;
            // final bool toggleAntiThiefState = device.config!.antiTheft!;
            DebugPrint.dataLog(
                currentFile: 'home_page',
                title: 'toggleAntiThiefState',
                data: isOnAntiThief);

            return Stack(
              children: [
                GoogleMap(
                  // polylines: {},
                  markers: Set<Marker>.of(_marker.values),
                  initialCameraPosition: _cameraPosition,
                  mapType: MapType.normal,
                  onMapCreated: ((GoogleMapController controller) {
                    _controller.complete(controller);
                  }),
                ),

                isWarning
                    ?
                    //Get current location widget
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          // color: AppColor.activeStateBlue,
                          margin: const EdgeInsets.only(bottom: 25),
                          height: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor: AppColor.grey.withOpacity(0.5),
                              shape: const CircleBorder(),
                            ),
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       'SAFE',
                            //       style: AppTextStyle.body17.copyWith(
                            //         color: AppTextColor.dark,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     Text(
                            //       'Confirm',
                            //       style: AppTextStyle.body17.copyWith(
                            //         color: AppTextColor.dark,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            child: const Icon(
                              Icons.warning_sharp,
                              size: 60,
                              color: AppColor.activeStateYellow,
                            ),
                            onPressed: () async {
                              setState(
                                () {
                                  isWarning = !isWarning;
                                },
                              );
                              await showConfirmSafeDialog(context);
                            },
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          // color: AppColor.activeStateBlue,
                          margin: const EdgeInsets.only(bottom: 25),
                          height: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor:
                                  AppColor.lightBlue.withOpacity(0.5),
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.location_searching,
                              size: 60,
                              color: AppColor.dark,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  isWarning = !isWarning;
                                },
                              );
                              // _homeBloc.add(
                              //   HomeBlocEvent(
                              //       homeBlocEvent:
                              //           HomeBlocEventEnum.getCurrentLocation),
                              // );
                            },
                          ),
                        ),
                      ),

                //toggle antithief widget
                Positioned(
                  left: 15,
                  bottom: 40,
                  child: SizedBox(
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        backgroundColor: isOnAntiThief
                            ? AppColor.safety
                            : AppColor.grey.withOpacity(0.5),
                        shape: const CircleBorder(),
                      ),
                      child: Icon(
                        isOnAntiThief == true ? Icons.lock : Icons.lock_open,
                        size: 40,
                        color: AppColor.dark,
                      ),
                      onPressed: () async {
                        await toggleAntiThief(!isOnAntiThief);
                        setState(() {
                          isOnAntiThief = !isOnAntiThief;
                        });
                      },
                    ),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
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
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: const <Widget>[
          //       Text('Thank you'),
          //       // Text('Would you like to approve of this message?'),
          //     ],
          //   ),
          // ),
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
                  ),
                );
                Future.delayed(const Duration(seconds: 1), () {
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
}
