import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:latlong2/latlong.dart';
import 'package:palacasa/my_flutter_app_icons.dart';
import 'package:http/http.dart' as http;
import '../../jsons/inverseGeolocationJson.dart';
import '../../Helper/color_constant.dart';

const double CAMERA_ZOOM=16;
const double CAMERA_TILT=0;
const double CAMERA_BEARING=30;
const double PIN_VISIBLE_POSITION=85;
const double PIN_INVISIBLE_POSITION=-320;

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key? key}) : super(key: key);

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  var _controllerDescripcion = TextEditingController();
  var resolutions = <double>[32768, 16384, 8192, 4096, 2048, 1024, 512, 256, 128];
  proj4.Point point = proj4.Point(x: 21.994783424811867, y: -79.23204385581882);
  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;

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
    getAddressByLocation(currentLocation);
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
                    zoom: 18.0,
                    onTap: (tapPosition, p) => setState(() {
                      point = proj4.Point(x: p.latitude, y: p.longitude);
                      currentLocation = LatLng(p.latitude, p.longitude);
                      getAddressByLocation(currentLocation);
                    }),
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                      'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                      subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],

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
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point:currentLocation,
                          builder: (ctx) =>
                              Container(
                                child: Icon(MyFlutterApp.location,color: Colors.red,),
                              ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child:
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                    width: MediaQuery.of(context).size.width*0.92,
                    height: 130,
                    decoration: BoxDecoration(
                    ),
                    child: Center(
                      child: _buildComposer()
                    )
                ),
              ))
        ],

      ):Center(),

    );
  }


  getAddressByLocation(LatLng coordenadas) async {

    var request = http.MultipartRequest('GET', Uri.parse('https://api.andariego.cu/address/location_inverse/${coordenadas.longitude}%20${coordenadas.latitude}'));


    try{
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
       // try{
          String d =await response.stream.bytesToString();
          print(d);
          var a = json.decode(d);
          var geolocation= inverseGeolocationJson.fromJson(a);
          _controllerDescripcion.text='${geolocation.street!.name} e/ ${geolocation.firstStreet!.name},${geolocation.municipality!.name},${geolocation.province!.name}';
          setState(() {

          });



        //}catch(e){
         // Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
        //}

      }else if (response.statusCode == 401){

      } else {

        Fluttertoast.showToast(msg: response.reasonPhrase!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }
    }catch(error){
      Fluttertoast.showToast(msg: error.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);

    }
  }

  Widget _buildComposer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: PaLaCasaAppTheme.nearlyWhite,
        borderRadius: BorderRadius.circular(25),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26.withOpacity(0.1),
              offset: const Offset(2, 2),
              blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          constraints: const BoxConstraints(minHeight: 100, maxHeight: 160),
          color: PaLaCasaAppTheme.nearlyWhite,
          child: SingleChildScrollView(
            child: TextField(
              controller:_controllerDescripcion,
              maxLines: null,
              onChanged: (String txt) {},
              style: TextStyle(
                fontFamily: PaLaCasaAppTheme.fontNameRegular,
                fontSize: 16,
                color: PaLaCasaAppTheme.Gray.withOpacity(0.6),
              ),
              cursorColor: PaLaCasaAppTheme.Gray,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: PaLaCasaAppTheme.fontNameRegular,
                    fontSize: 16,
                    color: PaLaCasaAppTheme.Gray,
                  ),
                  border: InputBorder.none,
                  prefixIcon:Icon(MyFlutterApp.map_marked_alt,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),) ,
                  hintText: 'Dirección'),
            ),
          ),
        ),
      ),
    );
  }

 }
