import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palacasa/Administrator/Categorias/Categorias.dart';
import 'package:palacasa/Administrator/Categorias/Stores.dart';
import 'package:palacasa/Administrator/Categorias/Users.dart';
import 'package:palacasa/bottom_navigation_view/bottom_bar_viewad.dart';
import 'package:http/http.dart' as http;
import 'package:palacasa/jsons/CreateUserJson.dart';
import 'package:palacasa/jsons/categoriesJson.dart';
import 'package:palacasa/jsons/typeBusinessJson.dart';
import '../Helper/color_constant.dart';
import '../bottom_navigation_view/bottom_bar_view.dart';
import '../database/PaLaCasaDB.dart';
import '../models/tabIcon_data.dart';
import 'package:image_picker/image_picker.dart';
import 'Categorias/Estadisticas.dart';

class AdministratorScreen extends StatefulWidget {
  final VoidCallback menuCallBack;
  const AdministratorScreen({Key? key, required this.menuCallBack}) : super(key: key);

  @override
  State<AdministratorScreen> createState() => _AdministratorScreenState();
}

class _AdministratorScreenState extends State<AdministratorScreen> with SingleTickerProviderStateMixin{
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsListAdmin;
  bool showStore=true;
  bool showCategoria=false;
  bool showPerfil=false;
  bool favorite=false;
  late IconData icon;
  bool isCategory = true;
  String value='Negocio';
  late File imageFile;
  var items =['Negocio','Masculino','Femenino'];
  var _controllerNegocio = new TextEditingController();
  var _controllerCategoria = new TextEditingController();
  var _controllerImagen = TextEditingController();


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    icon = Icons.add;
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                showStore?Stores(menuCallBack: widget.menuCallBack,):Center(),
                showCategoria?Categorias(menuCallBack: widget.menuCallBack, isCategory: (){

                },):Center(),
                showPerfil?Estadisticas(menuCallBack: widget.menuCallBack,):Center(),
                favorite?Usuarios(menuCallBack: widget.menuCallBack,):Center(),
                bottomBar(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarViewAdmin(
          iconData: icon,
          tabIconsList: tabIconsList,
          addClick: () {
            if(showCategoria){
              _showDialogCategories(context);
            }
          },
          addLongClick:() {
            if(showCategoria){
              _showDialogNegocio(context);
            }
          },
          changeIndex: (int index) {
            if (index == 0 ) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                icon = Icons.add;
                showPerfil=false;
                favorite=false;
                showCategoria=false;
                showStore=true;
                setState(() {

                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                icon = Icons.add;
                showPerfil=false;
                favorite=false;
                showCategoria=true;
                showStore=false;
                setState(() {

                });
              });
            } else if (index == 2) {
              icon = Icons.search;
              showPerfil=false;
              showCategoria=false;
              favorite=true;
              showStore=false;
              setState(() {

              });
            }else{
              icon = Icons.paste;
              showPerfil=true;
              showCategoria=false;
              favorite=false;
              showStore=false;

              setState(() {

              });

            }
          },
        ),
      ],
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  _showDialogNegocio(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: PaLaCasaAppTheme.background,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Tipo de Negocio",
                        style: TextStyle(
                          fontFamily: PaLaCasaAppTheme.fontName,
                          color: PaLaCasaAppTheme.Gray,fontSize: 16.0),
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 45),
                    child: TextFormField(
                      style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                      cursorColor: PaLaCasaAppTheme.Orange,
                      controller: _controllerNegocio,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
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
                        hintText: 'Nombre',
                        hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(

                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            String name = _controllerNegocio.text;
                            if(name.isNotEmpty) {
                              addTypeBusiness(name,context);
                              _controllerNegocio.clear();
                            } else
                              Fluttertoast.showToast(msg: "Rellene los espacios en blanco",backgroundColor: Colors.grey,gravity: ToastGravity.BOTTOM);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: PaLaCasaAppTheme.Orange,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(32.0),
                                  bottomLeft: Radius.circular(32.0)),
                            ),
                            child: Text(
                              "Crear".toUpperCase(),
                              style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0,),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showDialogCategories(BuildContext context) {
    return showDialog(
        context: context,
        builder:(context)
          => StatefulBuilder(
            builder: (context, _setter)  {
              return AlertDialog(
                backgroundColor: PaLaCasaAppTheme.background,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Añadir Categoría",
                            style: TextStyle(
                                fontFamily: PaLaCasaAppTheme.fontName,
                                color: PaLaCasaAppTheme.Gray,fontSize: 16.0),
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                        height: 4.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20,left: 20,top: 15,bottom: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(color:PaLaCasaAppTheme.Gray.withOpacity(0.1),width: 1.0 )

                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0,left: 12.0,top: 2.5,bottom: 2.5),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                icon: Icon(Icons.arrow_drop_down,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                value: value,
                                style: TextStyle(color: Colors.black38, fontSize: 18,),
                                underline: Container(
                                  height: 1,
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.5),
                                ),
                                items: items.map(buildMenuItem).toList(),
                                onChanged: (value) =>setState(() {
                                  _setter(
                                        () {
                                      this.value = value!;
                                    },
                                  );
                                  _changeGrade(value);
                                }),

                              ),
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical:0),
                        child: TextFormField(
                          style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                          cursorColor: PaLaCasaAppTheme.Orange,
                          controller: _controllerCategoria,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
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
                            hintText: 'Nombre',
                            hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                           _getFromGallery();
                       },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: TextFormField(
                            style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                            cursorColor: PaLaCasaAppTheme.Orange,
                            enabled: false,
                            controller: _controllerImagen,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
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
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                                  width: 1.0,
                                ),
                              ),
                              focusedErrorBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintText: 'Imagen',
                              hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(

                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () async {

                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                decoration: BoxDecoration(
                                  color: PaLaCasaAppTheme.Orange,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(32.0),
                                      bottomLeft: Radius.circular(32.0)),
                                ),
                                child: Text(
                                  "Crear".toUpperCase(),
                                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0,),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),


    );
  }

  void _changeGrade(_newGrade) {
    setState(
          () {
        value = _newGrade;
      },
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    alignment: Alignment.center,
    value: item,
    child: Text(
      item,
      style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,fontSize: 16.0,color: PaLaCasaAppTheme.Gray.withOpacity(0.5)),
    ),
  );



  addTypeBusiness(String name,BuildContext context) async {

    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/business'));
    request.fields.addAll({
      'name': name
    });
    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var userJson = createUserJson.fromJson(a);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: userJson.message!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }catch(e){
        Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }

    }else if (response.statusCode == 401){

      print(401);
    } else {
      print(response.reasonPhrase);
    }

  }



  addCategory(String id_type,String name, String path) async {

    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/categories'))
      ..fields['id_type'] = id_type
      ..fields['name'] = name
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var userJson = createUserJson.fromJson(a);
        Fluttertoast.showToast(msg: userJson.message!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }catch(e){

      }

    }else if (response.statusCode == 401){

      print(401);
    } else {
      print(response.reasonPhrase);
    }

  }



  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _controllerImagen.text=imageFile.absolute.path.replaceAll("/data/user/0/com.essocarras.palacasa/cache/", "");

      });
    }
  }
}
