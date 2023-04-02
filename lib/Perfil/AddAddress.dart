import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:blur/blur.dart';
import 'package:palacasa/database/PaLaCasaDB.dart';
import 'package:palacasa/jsons/CreateUserJson.dart';
import '../CustomInputFormatter.dart';
import '../Helper/GeoProvinces.dart';
import 'AnimatedToggle.dart';
import 'package:palacasa/my_flutter_app_icons.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../jsons/inverseGeolocationJson.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  LatLng currentLocation=LatLng(0, 0);
  bool setRequest=false;
  proj4.Point point = proj4.Point(x: 21.994783424811867, y: -79.23204385581882);
  MapController _controllerMap = new MapController();
  TextEditingController _controllerDescripcion= new TextEditingController();
  TextEditingController _controllerAlias= new TextEditingController();
  TextEditingController _controllerName= new TextEditingController();
  TextEditingController _controllerPhone= new TextEditingController();
  List<GeoProvinces> items=[];
  bool parami=true;
  double height =250;
  int itemsSelect=-1;
  bool isLoading=true;
  late String id_municipality;
  late String street;
  late String firstStreet;

  @override
  void initState() {
    currentLocationUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: Stack(
        children: [

          Positioned(
            top: 80,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              child: SingleChildScrollView(
                physics: height==250
                    ?BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics())
                    :NeverScrollableScrollPhysics(),
                child: Column(
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
                      child: AnimatedToggle(
                        position: parami,
                        values: ['Para mi', 'Para otro'],
                        onToggleCallback: (value) {
                          setState(() {
                            parami=!parami;
                          });
                        },
                        buttonColor: const Color(0xFF0A3157),
                        backgroundColor: const Color(0xFFB5C1CC),
                        textColor: const Color(0xFFFFFFFF),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0,right: 25,left: 25),
                      child:  Container(
                        decoration: BoxDecoration(
                          color: PaLaCasaAppTheme.nearlyWhite,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.1),
                                offset: const Offset(2, 2),
                                blurRadius: 5),
                          ],
                        ),
                        child: TextFormField(
                          style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                          cursorColor: PaLaCasaAppTheme.Orange,
                          controller: _controllerAlias,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                              child: Container(
                                width: 70,
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(MyFlutterApp.map_marked_alt,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                        onPressed: null,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        child: VerticalDivider(
                                          color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.2),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                                width: 1.0,
                              ),
                            ),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: 'Nombre Dirección',
                            hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                          ),
                        ),
                      ),
                    ),
                    !parami
                        ?Padding(
                      padding: const EdgeInsets.only(top: 10,right: 25,left: 25),
                      child:  Container(
                        decoration: BoxDecoration(
                          color: PaLaCasaAppTheme.nearlyWhite,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.1),
                                offset: const Offset(2, 2),
                                blurRadius: 5),
                          ],
                        ),
                        child: TextFormField(
                          style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                          cursorColor: PaLaCasaAppTheme.Orange,
                          controller: _controllerName,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                              child: Container(
                                width: 70,
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(MyFlutterApp.user,color: PaLaCasaAppTheme.Gray.withOpacity(0.5), size: 20,),
                                        onPressed: null,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        child: VerticalDivider(
                                          color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.2),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                                width: 1.0,
                              ),
                            ),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: 'Nombre Beneficiario',
                            hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),
                          ),
                        ),
                      ),
                    )
                        :Center(),
                    !parami
                        ?Padding(
                      padding: const EdgeInsets.only(top: 10,right: 25,left: 25,bottom: 10),
                      child:  Container(
                        decoration: BoxDecoration(
                          color: PaLaCasaAppTheme.nearlyWhite,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.1),
                                offset: const Offset(2, 2),
                                blurRadius: 5),
                          ],
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            new LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            new CustomInputFormatter()
                          ],
                          style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                          cursorColor: PaLaCasaAppTheme.Orange,
                          controller: _controllerPhone,
                          decoration: InputDecoration(
                            prefix: Text('+53 ',style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),fontSize: 15),),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                              child: Container(
                                width: 70,
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.phone,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                        onPressed: null,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        child: VerticalDivider(
                                          color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.2),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                                width: 1.0,
                              ),
                            ),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: 'Teléfono',
                            hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                          ),
                        ),
                      ),
                    )
                        :Center(),
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
                    !parami
                        ?Container(
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
                    )
                        :Center(),

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
                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 35.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () async {
                                String street = _controllerDescripcion.text;
                                String alias = _controllerAlias.text;
                                String name = _controllerName.text;
                                String phone = _controllerPhone.text;
                                if(street.isNotEmpty) {
                                  if(parami){
                                    addAddressUser(
                                        id_municipality,street,alias, "", "",
                                        currentLocation.longitude.toString(),
                                        currentLocation.latitude.toString());
                                  }else{
                                  if(phone.isNotEmpty&&name.isNotEmpty){
                                    addAddressUser(
                                        id_municipality, street,alias,name, phone,
                                        currentLocation.longitude.toString(),
                                        currentLocation.latitude.toString());
                                  }else{
                                    Fluttertoast.showToast(msg: 'Rellene los espacios en blanco',backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
                                  }

                                  }
                                }else{
                                  Fluttertoast.showToast(msg: 'Rellene los espacios en blanco',backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
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
          Positioned(
            top: 30,
            child: Container(
              height: 70,
              color: PaLaCasaAppTheme.background,
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
                      title: Text("Añadir Dirección",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,fontSize: 18),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void currentLocationUser() async{
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

  addAddressUser(String id_municipality,String street,String name,String beneficiario,String phone,String longituded,String latituded) async {
      setState(() {
        setRequest=true;
      });
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/address'))
      ..fields['id_municipality'] = id_municipality
      ..fields['default_address'] = "0"
      ..fields['street'] = street
      ..fields['name'] = name
      ..fields['beneficiario'] = beneficiario
      ..fields['phone'] = phone
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

}
