import 'package:dnd_order_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  static final CameraPosition _deu =
      CameraPosition(target: LatLng(35.144706, 129.035759), zoom: 17.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addCustomIcon();
  }

  // void addCustomIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration(), "assets/images/robot.webp")
  //       .then(
  //     (icon) {
  //       setState(() {
  //         markerIcon = icon;
  //       });
  //     },
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '지도',
          style: TextStyle(
            color: BLUE,
          ),
        ),
        backgroundColor: BACKGROUND,
      ),
      body: GoogleMap(
        initialCameraPosition: _deu,
        markers: {
          Marker(
            markerId: const MarkerId('maker1'),
            position: LatLng(35.144706, 129.035759),
            draggable: true,
            onDragEnd: (value) => {},
            icon: markerIcon,
          )
        },
      ),
    );
  }
}
