import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usman_hameed/data_provider/auth_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _controller;
  BitmapDescriptor? pinLocationIcon;
  double? lat;
  double? long;


  @override
  void initState() {
    super.initState();
    // setCustomMapPin();
    Future.delayed(Duration(seconds: 2), () {
      moveToUserCurrentLocation();
    });
  }

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (BuildContext context, data, Widget? child) {
      return SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerTop,
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.location_searching,
              color: Colors.white,
            ),
            onPressed: () async {
              await moveToUserCurrentLocation();
            },
          ),
          body:Stack(children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(31.5204, 74.3587),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) async {
                _controller = controller;

                moveToUserCurrentLocation();
              },
            ),
            ElevatedButton(onPressed: (){
              if(lat==null) return;

              Get.back(result: [lat,long]);


            }, child: Text("Confirm Address "))
          ],)
        ),
      );
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/gps.png');
  }

  moveToUserCurrentLocation() async {
    setCustomMapPin();

    if (_controller == null) {
      return;
    }

    var permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition();
      lat = position.latitude;
      long = position.longitude;

      _markers.clear();
      _markers.add(Marker(
          markerId: MarkerId("Main"),
          position: LatLng(position.latitude, position.longitude),
          icon: pinLocationIcon!));
      _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 18)));
      setState(() {});
    }
  }
}
