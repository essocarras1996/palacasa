
import 'dart:convert';

import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:http/http.dart' as http;
import 'package:palacasa/jsons/CreateUserJson.dart';
import 'package:palacasa/jsons/categoriesJson.dart';
import 'package:palacasa/jsons/typeBusinessJson.dart';
import '../../database/PaLaCasaDB.dart';
import '../../my_flutter_app_icons.dart';


class Categorias extends StatefulWidget {
  final VoidCallback menuCallBack;
  final VoidCallback isCategory;
  const Categorias({Key? key,required this.menuCallBack,required this.isCategory}) : super(key: key);

  @override
  State<Categorias> createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {

  int selectIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      /*floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: (){},
          child: Icon(
            Icons.add,
            color: PaLaCasaAppTheme.nearlyWhite,
          ),
          backgroundColor: PaLaCasaAppTheme.Orange,
        ),
      ),*/
      body: SafeArea(
        child:
        Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListTile(
                    leading: IconButton(
                      onPressed: widget.menuCallBack,
                      icon: SvgPicture.asset("assets/icons/paragraph.svg",color: PaLaCasaAppTheme.deepGRAY),
                    ),
                    title: Text("Administración",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => widget.isCategory,
                      child: Text('Negocios',
                      style: TextStyle(
                        fontFamily: selectIndex==0?PaLaCasaAppTheme.fontName:PaLaCasaAppTheme.fontNameRegular,
                        color: PaLaCasaAppTheme.Gray
                      ),
                      ),
                    ),
                    VerticalDivider(
                      color: PaLaCasaAppTheme.Gray,
                      thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        selectIndex=1;
                        widget.isCategory;
                      }),
                      child: Text('Categorías',
                        style: TextStyle(
                            fontFamily: selectIndex==1?PaLaCasaAppTheme.fontName:PaLaCasaAppTheme.fontNameRegular,
                            color: PaLaCasaAppTheme.Gray
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  getCategories() async {

    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/categories'));

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
        var categories = categoriesJson.fromJson(a);
      }catch(e){
        Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }

    }else if (response.statusCode == 401){

      print(401);
    } else {
      print(response.reasonPhrase);
    }

  }

  getTypeBusiness() async {

    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/business'));

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
        var typeBusiness = typeBusinessJson.fromJson(a);
      }catch(e){
        Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }

    }else if (response.statusCode == 401){

      print(401);
    } else {
      print(response.reasonPhrase);
    }

  }

}
