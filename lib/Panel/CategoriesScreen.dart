
import 'dart:convert';

import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:palacasa/jsons/CreateUserJson.dart';
import 'package:palacasa/jsons/jsonPanelCafeteria.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import '../../my_flutter_app_icons.dart';
import '../database/PaLaCasaDB.dart';
import '../jsons/jsonCategoriasBusiness.dart';


class CategoriesScreen extends StatefulWidget {
  final String id_cafeteria;
  const CategoriesScreen({Key? key, required this.id_cafeteria}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool setRequest=true;
  var _controllerNegocio = new TextEditingController();
  List<Categories> _listBusiness=[];


  @override
  void initState() {
    getCafeteria();// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          _showDialogNegocio(context);
        },
        backgroundColor: PaLaCasaAppTheme.Orange,
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20,right: 15,left: 15),
                            child: Text("Adicione las categorías de su negocio aquí. El orden en que añada las categorías será el mismo a mostrar a los clientes",
                              style: TextStyle(
                                  fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                  color: PaLaCasaAppTheme.Gray
                              ),
                              maxLines: 6,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          setRequest
                              ?Container(
                            width:MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height*0.8,
                            child: Shimmer.fromColors(
                              baseColor: PaLaCasaAppTheme.grey.withOpacity(0.2),
                              highlightColor: PaLaCasaAppTheme.grey.withOpacity(0.1),
                              enabled: setRequest,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (_, __) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: PaLaCasaAppTheme.Orange,
                                    maxRadius: 15,
                                  ),
                                  trailing: Container(
                                    width: 80,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            backgroundColor: PaLaCasaAppTheme.grey.withOpacity(0.6),
                                            maxRadius: 15,
                                            child: Icon(Icons.delete,color: Colors.white,size: 15,)
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CircleAvatar(
                                            backgroundColor: Colors.green.withOpacity(0.5),
                                            maxRadius: 15,
                                            child: Icon(Icons.edit,color: Colors.white,size: 15,)
                                        ),
                                      ],
                                    ),
                                  ),
                                  title:Container(
                                    width: MediaQuery.of(context).size.width*0.8,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15)
                                    ),

                                  ),
                                ),
                                itemCount: 20,
                              ),
                            ),
                          )
                              :Container(
                            width:MediaQuery.of(context).size.width ,
                            height:MediaQuery.of(context).size.height*0.78,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              scrollDirection: Axis.vertical,
                              itemCount: _listBusiness.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: PaLaCasaAppTheme.Orange,
                                    maxRadius: 15,
                                    child: Text((index+1).toString(),
                                      style: TextStyle(
                                          fontFamily: PaLaCasaAppTheme.fontName,
                                          color: PaLaCasaAppTheme.white
                                      ),
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 80,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap:(){
                                          _showDialogDeleteNegocio(context, _listBusiness[index].name!,_listBusiness[index].id!.toString());
                                          },
                                          child: CircleAvatar(
                                              backgroundColor: PaLaCasaAppTheme.grey.withOpacity(0.6),
                                              maxRadius: 15,
                                              child: Icon(Icons.delete,color: Colors.white,size: 15,)
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _controllerNegocio.clear();
                                            _controllerNegocio.text= _listBusiness[index].name!;
                                            _showDialogEditNegocio(context, _listBusiness[index].id!.toString());
                                          },
                                          child: CircleAvatar(
                                              backgroundColor: Colors.green,
                                              maxRadius: 15,
                                              child: Icon(Icons.edit,color: Colors.white,size: 15,)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(_listBusiness[index].name!,
                                    style: TextStyle(
                                        fontFamily: PaLaCasaAppTheme.fontName,
                                        color: PaLaCasaAppTheme.Gray
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
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
                    title: Text("Categorias",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  getCafeteria() async {
    setState(() {
      setRequest=true;
    });
    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/categoriaByBusiness/${widget.id_cafeteria}'));
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
        var userJson = jsonCategoriasBusiness.fromJson(a);
        _listBusiness=[];
        _listBusiness.addAll(userJson.categories!);
        setRequest=false;
        setState(() {

        });
      }catch(e){
        Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }

    }else if (response.statusCode == 401){

      print(401);
    } else {
      print(response.reasonPhrase);
    }

  }

  addTypeBusiness(String id_cafeteria,String name,BuildContext context) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/categoriaByBusiness'));
    request.fields.addAll({
      'name': name,
      'id_cafeteria': id_cafeteria,
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
        _controllerNegocio.clear();
        Navigator.pop(context);
        getCafeteria();
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

  editTypeBusiness(String id, String name) async {

    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/editCategoriaByBusiness'));
    request.fields.addAll({
      'id': id,
      'name': name,
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
        _controllerNegocio.clear();
        Navigator.pop(context);
        getCafeteria();
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

  deleteTypeBusiness(String id) async {

    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/deleteCategoriaByBusiness/$id'));

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
        getCafeteria();
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
                        "Categoría",
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
                        hintText: 'Nombre categoría',
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
                              addTypeBusiness(widget.id_cafeteria,name,context);
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

  _showDialogDeleteNegocio(BuildContext context, String name, String id) {
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
                        "Eliminar Categoría",
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
                    child: Text("¿Desea eliminar la categoría $name?",
                      style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                    )
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
                          Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: PaLaCasaAppTheme.Orange.withOpacity(0.9),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0)),
                            ),
                            child: Text(
                              "No".toUpperCase(),
                              style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0,),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                           deleteTypeBusiness(id);
                            },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: PaLaCasaAppTheme.Orange,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(32.0),
                                  ),
                            ),
                            child: Text(
                              "Si".toUpperCase(),
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

  _showDialogEditNegocio(BuildContext context, String id) {
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
                        "Editar de Negocio",
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
                              editTypeBusiness(id,name);
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
                              "Modificar".toUpperCase(),
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
}
