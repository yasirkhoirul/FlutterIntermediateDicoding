import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final tourismPlaces = const [
    LatLng(-6.8168954, 107.6151046),
    LatLng(-6.8331128, 107.6048483),
    LatLng(-6.8668408, 107.608081),
    LatLng(-6.9218518, 107.6025294),
    LatLng(-6.780725, 107.637409),
  ];
  late GoogleMapController mapscontroller;
  final Set<Marker> markers = {};
  final latlang = LatLng(-6.8957473, 107.6337669);
  void addmymarker() {
    for (var data in tourismPlaces) {
      markers.add(
        Marker(
          position: data,
          markerId: MarkerId("markers $data"),
          onTap: () {
            mapscontroller.animateCamera(CameraUpdate.newLatLngZoom(data, 18));
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final marker = Marker(
      markerId: const MarkerId("dicoding"),
      position: latlang,
      onTap: () {
        mapscontroller.animateCamera(CameraUpdate.newLatLngZoom(latlang, 18));
      },
    );
    markers.add(marker);
    addmymarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              GoogleMap(
                
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                markers: markers,
                onMapCreated: (controller) {
                  setState(() {
                    mapscontroller = controller;
                  });
                },

                initialCameraPosition: CameraPosition(
                  zoom: 18,
                  target: latlang,
                ),
                onLongPress: (argument) {
                  onLongPressGooglemaps(argument);
                },
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Column(
                  children: [
                    FloatingActionButton.small(
                      onPressed: () {
                        onmylocationpressed();
                      },
                      child: const Icon(Icons.my_location),
                    ),
                    FloatingActionButton.small(
                      onPressed: () {
                        mapscontroller.animateCamera(CameraUpdate.zoomIn());
                      },
                      heroTag: 'zoomin',
                      child: const Icon(Icons.add),
                    ),
                    FloatingActionButton.small(
                      onPressed: () {
                        mapscontroller.animateCamera(CameraUpdate.zoomOut());
                      },
                      heroTag: 'zoomout',
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onmylocationpressed() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus ispermessionGuaranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("location service tidak ada");
        return;
      }
    }

    ispermessionGuaranted = await location.hasPermission();
    if (ispermessionGuaranted == PermissionStatus.denied) {
      ispermessionGuaranted = await location.requestPermission();
      if (ispermessionGuaranted != PermissionStatus.granted) {
        print("perizinan lokasi ditolak");
        return;
      }
    }

    locationData = await location.getLocation();
    final latlang = LatLng(locationData.latitude!, locationData.longitude!);
    definemarker(latlang);
    mapscontroller.animateCamera(
      CameraUpdate.newLatLng(latlang)
    );
  }

  void definemarker(LatLng latlang) {
    final marker = Marker(markerId: MarkerId("mylocation"), position: latlang,);
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void onLongPressGooglemaps(LatLng latlang)async{
    definemarker(latlang);
    mapscontroller.animateCamera(
      CameraUpdate.newLatLng(latlang)
    );
  }
}
