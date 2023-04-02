import 'dart:convert';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:palacasa/jsons/CreateUserJson.dart';
import 'package:palacasa/my_flutter_app_icons.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shimmer/shimmer.dart';
import '../Helper/GeoProvinces.dart';
import '../Helper/color_constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../jsons/inverseGeolocationJson.dart';
import '../database/PaLaCasaDB.dart';
import '../jsons/businessAdminJson.dart';
import '../jsons/jsonAddressCafeteria.dart';

class AddressBusiness extends StatefulWidget {
  final String id_cafeteria;
  const AddressBusiness( {Key? key, required this.id_cafeteria}) : super(key: key);

  @override
  State<AddressBusiness> createState() => _AddressBusinessState();
}

class _AddressBusinessState extends State<AddressBusiness> {
  List<GeoProvinces> items=[];
  late String id_municipality;
  String id="";
  bool setRequest=false;
  int itemsSelect=-1;
  MapController _controllerMap = new MapController();
  double height =250;
  LatLng currentLocation=LatLng(0, 0);
  TextEditingController _controllerDescripcion= new TextEditingController();

  @override
  void initState() {
    getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: height==250
                    ?BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics())
                    :NeverScrollableScrollPhysics(),
                child:Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text("Establezca la dirección de su negocio aquí. Marque en el mapa su localización y complete correctamente la dirección.",
                          style: TextStyle(
                              fontFamily:PaLaCasaAppTheme.fontNameRegular,
                              color: PaLaCasaAppTheme.Gray.withOpacity(0.5),
                              fontSize: 16.0
                          ),

                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
                              child: Text("Ubicación",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color:PaLaCasaAppTheme.Gray,fontWeight: FontWeight.bold,fontSize: 14),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
                              child: GestureDetector(
                                  onTap: () => setState(() {
                                    height==250
                                        ?height=MediaQuery.of(context).size.height*0.5
                                        :height=250;
                                  }),
                                  child: height==250
                                      ?Text("Agrandar Mapa",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color:PaLaCasaAppTheme.Gray,fontWeight: FontWeight.bold,fontSize: 12),)
                                      :Text("Disminuir Mapa",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color:PaLaCasaAppTheme.Gray,fontWeight: FontWeight.bold,fontSize: 12),)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  itemsSelect=index;
                                  _controllerMap.move(LatLng(items[index].latituded, items[index].longituded), 12);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 10),
                                child: Container(

                                  decoration: BoxDecoration(
                                      color: PaLaCasaAppTheme.background,
                                      borderRadius: BorderRadius.circular(18.0),
                                      border: Border.all(color: itemsSelect==index
                                          ?PaLaCasaAppTheme.Orange.withOpacity(0.2)
                                          :PaLaCasaAppTheme.Gray.withOpacity(0.2),),
                                      boxShadow: [
                                        BoxShadow(
                                            color: itemsSelect==index
                                                ?PaLaCasaAppTheme.Orange.withOpacity(0.2)
                                                :PaLaCasaAppTheme.Gray.withOpacity(0.2),
                                            offset: Offset(5.0, 5.0),
                                            blurRadius: 8.0
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12,right: 15.0,left: 15.0),
                                    child: Text(items[index].name,
                                      style: TextStyle(
                                          fontFamily: PaLaCasaAppTheme.fontName,
                                          fontSize: 12,
                                          color: itemsSelect==index
                                              ?PaLaCasaAppTheme.Orange.withOpacity(0.5)
                                              :PaLaCasaAppTheme.Gray.withOpacity(0.5)
                                      ),),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          height: height,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: FlutterMap(
                              mapController: _controllerMap,

                              options: MapOptions(
                                center: LatLng(23.113592, -82.366592),
                                zoom: 10.0,
                                onTap: (tapPosition, p) => setState(() {
                                  currentLocation = LatLng( p.latitude, p.longitude);
                                  getAddressByLocation(currentLocation);
                                }),
                              ),
                              layers: [
                                TileLayerOptions(
                                  urlTemplate:
                                  'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                                  subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                                  tileProvider: NonCachingNetworkTileProvider(),
                                ),
                                MarkerLayerOptions(
                                  markers: [
                                    Marker(
                                      width: 80.0,
                                      height: 80.0,
                                      point:currentLocation,
                                      builder: (ctx) =>
                                          Container(
                                            child: Icon(MyFlutterApp.location,color: PaLaCasaAppTheme.Gray,size: 30,),
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: _buildComposer(),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 10.0,bottom: 100),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () async {
                                  String street = _controllerDescripcion.text;
                                  if(id!=""){
                                    editAddress(id,id_municipality, street,
                                        currentLocation.longitude.toString(),
                                        currentLocation.latitude.toString());
                                  }else {
                                    if (street.isNotEmpty) {
                                      addAddress(id_municipality, street,
                                          currentLocation.longitude.toString(),
                                          currentLocation.latitude.toString());
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Rellene los espacios en blanco',
                                          backgroundColor: Colors.grey,
                                          gravity: ToastGravity.BOTTOM);
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: setRequest?14:20.0, bottom: setRequest?14:20.0),
                                  decoration: BoxDecoration(
                                      color: PaLaCasaAppTheme.Orange,
                                      borderRadius: BorderRadius.circular(35.0)
                                  ),
                                  child: setRequest?Center(child: CircularProgressIndicator(color: PaLaCasaAppTheme.nearlyWhite,strokeWidth: 2,)):Text(
                                    "Guardar".toUpperCase(),
                                    style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0,),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 25,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () =>  Navigator.pop(context),
                      child: Container(
                        width:40,
                        height:40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: PaLaCasaAppTheme.Orange
                                    .withOpacity(0.2),
                                offset: Offset(5.0, 5.0),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:Blur(
                                blur: 0.5,
                                colorOpacity: 1,
                                blurColor: PaLaCasaAppTheme.Orange,
                                child: Center(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: IconButton(onPressed: (){
                                print('');
                                Navigator.pop(context);
                              }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,)),
                            )
                          ],
                        ),
                      ),
                    ),
                    title: Text("Dirección del Negocio",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
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
        borderRadius: BorderRadius.circular(18),
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
                color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
              ),
              cursorColor: PaLaCasaAppTheme.Gray,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: PaLaCasaAppTheme.fontName,
                    fontSize: 16,
                    color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                  ),
                  border: InputBorder.none,
                  prefixIcon:Icon(Icons.description_outlined,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),) ,
                  hintText: 'Detalles de la Dirección'),
            ),
          ),
        ),
      ),
    );
  }

  getAddressByLocation(LatLng coordenadas) async {

    var request = http.MultipartRequest('GET', Uri.parse('https://api.andariego.cu/address/location_inverse/${coordenadas.longitude}%20${coordenadas.latitude}'));


    try{
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        try{
          String d =await response.stream.bytesToString();
          print(d);
          var a = json.decode(d);
          var geolocation= inverseGeolocationJson.fromJson(a);
          id_municipality = geolocation.municipality!.id!.toString();
          _controllerDescripcion.text='${geolocation.street!.name} e/ ${geolocation.firstStreet!.name}.';
          setState(() {

          });



        }catch(e){
          Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
        }

      }else if (response.statusCode == 401){

      } else {

        Fluttertoast.showToast(msg: response.reasonPhrase!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }
    }catch(error){
      Fluttertoast.showToast(msg: error.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);

    }
  }

  getInit(){
    items.add(new GeoProvinces(name: "Pinar del Río", latituded: 22.41667, longituded: -83.69667));
    items.add(new GeoProvinces(name: "Artemisa ", latituded: 22.81667, longituded: -82.75944));
    items.add(new GeoProvinces(name: "La Habana", latituded: 23.13302, longituded: -82.38304));
    items.add(new GeoProvinces(name: "Mayabeque", latituded: 22.96139, longituded: -82.15111));
    items.add(new GeoProvinces(name: "Matanzas", latituded: 23.04111, longituded: -81.5775));
    items.add(new GeoProvinces(name: "Cienfuegos", latituded: 22.14957, longituded: -80.44662));
    items.add(new GeoProvinces(name: "Villa Clara", latituded: 22.40694, longituded: -79.96472));
    items.add(new GeoProvinces(name: "Sancti Spíritus", latituded: 21.92972, longituded: -79.4425));
    items.add(new GeoProvinces(name: "Ciego de Ávila", latituded: 21.8400000, longituded: -78.7619400));
    items.add(new GeoProvinces(name: "Camagüey", latituded:21.3808300 , longituded: -77.9169400));
    items.add(new GeoProvinces(name: "Las Tunas", latituded: 20.96167, longituded: -76.95111));
    items.add(new GeoProvinces(name: "Granma", latituded: 20.37417, longituded: -76.64361));
    items.add(new GeoProvinces(name: "Santiago de Cuba", latituded: 20.02083, longituded: -75.82667));
    items.add(new GeoProvinces(name: "Guatánamo", latituded: 20.14444, longituded: -75.20917));
    items.add(new GeoProvinces(name: "Isla de la Juventud", latituded: 21.69109755, longituded: -82.815585555677));

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
    _controllerMap.move(currentLocation, 16.5);

    setState(() {

    });

  }

  addAddress(String id_municipality,String street, String longituded,String latituded) async {
    setState(() {
      setRequest=true;
    });
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/addressBusiness'))
      ..fields['id_municipality'] = id_municipality
      ..fields['street'] = street
      ..fields['longituded'] = longituded
      ..fields['latituded'] = latituded
      ..fields['id_cafeteria'] = widget.id_cafeteria!;


    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        setRequest=false;
      });
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var userJson = createUserJson.fromJson(a);
        Fluttertoast.showToast(msg: userJson.message!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
        Navigator.pop(context);
      }catch(e){

      }

    }else if (response.statusCode == 401){
      setState(() {
        setRequest=false;
      });
      print(401);
    } else {
      setState(() {
        setRequest=false;
      });
      print(response.reasonPhrase);
    }

  }

  editAddress(String id,String id_municipality,String street, String longituded,String latituded) async {
    setState(() {
      setRequest=true;
    });
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/editAddressBusiness'))
      ..fields['id'] = id
      ..fields['id_municipality'] = id_municipality
      ..fields['street'] = street
      ..fields['longituded'] = longituded
      ..fields['latituded'] = latituded;


    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        setRequest=false;
      });
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var userJson = createUserJson.fromJson(a);
        Fluttertoast.showToast(msg: userJson.message!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
        Navigator.pop(context);
      }catch(e){

      }

    }else if (response.statusCode == 401){
      setState(() {
        setRequest=false;
      });
      print(401);
    } else {
      setState(() {
        setRequest=false;
      });
      print(response.reasonPhrase);
    }

  }

  getAddress() async {
    getInit();
    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/addressBusiness/${widget.id_cafeteria}'));


    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        setRequest=false;
      });
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var addressJson = jsonAddressCafeteria.fromJson(a);
        if(addressJson.address!.isNotEmpty){
          currentLocation = new LatLng(addressJson.address!.first.latituded!, addressJson.address!.first.longituded!);
          id_municipality = addressJson.address!.first.idMunicipality!.toString();
          _controllerDescripcion.text = addressJson.address!.first.street!;
          id = addressJson.address!.first.id.toString();
          _controllerMap.move(LatLng(currentLocation.latitude, currentLocation.longitude), 18);

          setState(() {

          });
        }else{
          currentLocationUser();
        }


      }catch(e){

      }

    }else if (response.statusCode == 401){
      setState(() {
        setRequest=false;
      });
      print(401);
    } else {
      setState(() {
        setRequest=false;
      });
      print(response.reasonPhrase);
    }

  }
}
