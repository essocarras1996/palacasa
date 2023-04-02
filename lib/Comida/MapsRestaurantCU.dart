import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:latlong2/latlong.dart';
import '../Helper/color_constant.dart';
import '../my_flutter_app_icons.dart';

const double CAMERA_ZOOM=16;
const double CAMERA_TILT=0;
const double CAMERA_BEARING=30;
const double PIN_VISIBLE_POSITION=85;
const double PIN_INVISIBLE_POSITION=-320;

class MapsRestaurant extends StatefulWidget {
  const MapsRestaurant({Key? key}) : super(key: key);

  @override
  State<MapsRestaurant> createState() => _MapsRestaurantState();
}

class _MapsRestaurantState extends State<MapsRestaurant> {
  var resolutions = <double>[32768, 16384, 8192, 4096, 2048, 1024, 512, 256, 128];
  proj4.Point point = proj4.Point(x: 21.994783424811867, y: -79.23204385581882);
  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;
  late LatLng destinationLocation;
  double pinPillinPosition = PIN_INVISIBLE_POSITION;
  @override
  void initState() {
   // this.setInitialLocation();
    currentLocation = LatLng(0,0);
    this.currentLocationUser();
    super.initState();


  }

  void currentLocationUser() async{
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async{
      await Geolocator.requestPermission();
      print("Error" +error.toString());
    });
    var currentLoc = await Geolocator.getCurrentPosition();
    currentLocation = LatLng(currentLoc.latitude, currentLoc.longitude);
    destinationLocation = LatLng(22.140548084396237, -80.44905435293913);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: currentLocation!= LatLng(0,0)?Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(currentLocation.latitude, currentLocation.longitude, ),
                    zoom: 16.0,
                    onTap: (tapPosition, p) => setState(() {
                      point = proj4.Point(x: p.latitude, y: p.longitude);


                    }),
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                      'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                      subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                      tileProvider: NonCachingNetworkTileProvider(),
                    ),
                    /*TileLayerOptions(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),*/
                   /* TileLayerOptions(
                      wmsOptions: WMSTileLayerOptions(
                        baseUrl: 'https://cache.andariego.cu/wms?',
                        format: 'image/png',
                        version: '1.1.1',
                        layers: ['osm'],
                        transparent: true,
                      ),
                      subdomains: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
                    ),*/
                    MarkerLayerOptions(),
                  ],
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child:
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Container(
                    width: MediaQuery.of(context).size.width*0.92,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).cardColor.withOpacity(0.8),
                    ),
                    child: Center(
                      child: Text('Marque su geolocalización',style: TextStyle(fontFamily: 'Ubuntu',fontWeight: FontWeight.bold ,color: Theme.of(context).buttonColor),),

                    )
                ),
              ))
        ],

      ):Center(),

    );
  }


  getAddressByLocation(LatLng coordenadas){

  }


 }
