import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Helper/color_constant.dart';
import '../my_flutter_app_icons.dart';


const LatLng SOURCE_LOCATION = LatLng(42.7477863,-71.1699932);
const LatLng DEST_LOCATION = LatLng(42.743902,-71.170009);
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
  Completer<GoogleMapController> _controller =Completer();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;
  late LatLng destinationLocation;
  double pinPillinPosition = PIN_INVISIBLE_POSITION;
  @override
  void initState() {
   // this.setInitialLocation();
    currentLocation = LatLng(0,0);
    this.currentLocationUser();
    this.setSourceAndDestinationMarkerIcons();
    super.initState();


  }

  setSourceAndDestinationMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/fitness_app/glass.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/fitness_app/glass.png');
  }

  void setInitialLocation(){
    currentLocation = LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
    destinationLocation = LatLng(22.140548084396237, -80.44905435293913);
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
    CameraPosition initialCameraPosition =
    CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: currentLocation);
    return Scaffold(
      body: currentLocation!= LatLng(0,0)?Stack(
        children: [
          GoogleMap(
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            tiltGesturesEnabled: false,
            zoomControlsEnabled: false,
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onTap: (LatLng lg){
              setState(() {
                this.pinPillinPosition=PIN_INVISIBLE_POSITION;
              });
            },
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              showPinsOnMap();
            },
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            bottom: pinPillinPosition,
            left: 0,
            right: 0,

            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 245,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 2.5,
                            spreadRadius: 2.5,
                            offset: Offset(0, 1),
                          )
                        ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child:Blur(
                        blur: 10.5,
                        colorOpacity: 0.9,
                        blurColor: Colors.white,
                        child: Center(),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                      top: 30,
                      left: MediaQuery.of(context).size.width-100,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: PaLaCasaAppTheme.Orange,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: PaLaCasaAppTheme.Orange.withOpacity(0.2),
                                    blurRadius: 2.5,
                                    spreadRadius: 2.5,
                                    offset: Offset(0, 1),
                                  )
                                ]
                            ),
                            child: CircleAvatar(
                              backgroundColor: PaLaCasaAppTheme.Orange,
                              maxRadius: 25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child:Icon(MyFlutterApp.heart,color: Colors.white,size: 22,),

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 2.5,
                                      spreadRadius: 2.5,
                                      offset: Offset(0, 1),
                                    )
                                  ]
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                maxRadius: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child:CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: 77,
                                      width: 77,
                                      imageUrl: 'https://brandemia.org/contenido/subidas/2022/10/marca-mcdonalds-logo-1200x670.png',
                                      placeholder: (context, url) => CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        maxRadius: 30,
                                        child: CircularProgressIndicator(
                                          color: PaLaCasaAppTheme.grey,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => new Icon(Icons.image_not_supported_outlined,color: PaLaCasaAppTheme.grey,)
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              child: Text("McDonald's",
                                style: TextStyle(
                                    fontFamily:PaLaCasaAppTheme.fontName,
                                    color: PaLaCasaAppTheme.grey,
                                    fontSize: 25.0
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 60,right: 60),
                            child: Text("Avenida 25 e/ San Nicolás y San Carlos, Cienfuegos",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily:PaLaCasaAppTheme.fontNameRegular,
                                  color: PaLaCasaAppTheme.grey.withOpacity(0.5),
                                  fontSize: 14.0
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [

                                  Image(
                                    image: AssetImage('assets/fitness_app/star.png'),
                                    width: 22.0,
                                  ),
                                  Text(" 4.5",
                                    style: TextStyle(
                                      fontFamily: 'Poppinss',
                                      fontSize: 12,
                                      color: PaLaCasaAppTheme.grey,
                                    ),)
                                ],
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage('assets/fitness_app/carta.png'),
                                    width: 20.0,
                                  ),
                                  Text("  Ofertas",
                                    style: TextStyle(
                                      fontFamily: 'Poppinss',
                                      fontSize: 12,
                                      color: PaLaCasaAppTheme.grey,
                                    ),)
                                ],
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage('assets/fitness_app/gps.png'),
                                    width: 20.0,
                                  ),
                                  Text(" Ir",
                                    style: TextStyle(
                                      fontFamily: 'Poppinss',
                                      fontSize: 12,
                                      color: PaLaCasaAppTheme.grey,
                                    ),)
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: PaLaCasaAppTheme.grey.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(15)

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                  child: Text("Hamburguesas",
                                    style: TextStyle(
                                      fontFamily: 'Poppinss',
                                      fontSize: 10,
                                      color: PaLaCasaAppTheme.grey,
                                    ),),
                                ),
                              ),
                              SizedBox(
                                width: 17.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: PaLaCasaAppTheme.grey.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(15)

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                  child: Text("Pizzas",
                                    style: TextStyle(
                                      fontFamily: 'Poppinss',
                                      fontSize: 10,
                                      color: PaLaCasaAppTheme.grey,
                                    ),),
                                ),
                              ),
                              SizedBox(
                                width: 17.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: PaLaCasaAppTheme.grey.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(15)

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                  child: Text("Comida Rápida",
                                    style: TextStyle(
                                      fontFamily: 'Poppinss',
                                      fontSize: 10,
                                      color: PaLaCasaAppTheme.grey,
                                    ),),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                ),

              ],
            ),
          ),
        ],
      ):Center(),

    );
  }

  Future<void> showPinsOnMap() async {
    List<String> list=['https://assets.stickpng.com/images/6128ffece3a15c00041a8e44.png','https://assets.stickpng.com/images/6128ffece3a15c00041a8e44.png'];
    for(int i = 0 ; i<2;i++){
      final int targetWidth = 80;final File markerImageFile = await DefaultCacheManager().getSingleFile(list[i]);
      final Uint8List imageBytes = await markerImageFile.readAsBytes();
      final Codec markerImageCodec = await instantiateImageCodec(
        imageBytes,
        targetWidth: targetWidth,
      );
      final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ImageByteFormat.png,
      );
      final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
      if(i==0){
        _markers.add(
            Marker(
              markerId: MarkerId('sourcePin'),
              flat: true,
              position: currentLocation,
              icon: BitmapDescriptor.fromBytes(resizedMarkerImageBytes),
              onTap: () {
                setState(() {
                  this.pinPillinPosition=PIN_VISIBLE_POSITION;
                });
              },
            )
        );
      }else{
        _markers.add(
            Marker(
                markerId: MarkerId('destPin'),
                position: destinationLocation,
                icon: BitmapDescriptor.fromBytes(resizedMarkerImageBytes)
            )
        );
      }

    }


    setState(() {


    });
  }




      }
