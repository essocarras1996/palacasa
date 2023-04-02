
import 'dart:convert';

import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:palacasa/Helper/search_form.dart';
import 'package:palacasa/database/PaLaCasaDB.dart';
import 'package:palacasa/jsons/businessAdminJson.dart';
import 'package:palacasa/jsons/jsonSearchUser.dart' as search;
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import '../../my_flutter_app_icons.dart';


class AsignarNegocio extends StatefulWidget {
  final Data cafeteria;
  const AsignarNegocio({Key? key,required this.cafeteria}) : super(key: key);

  @override
  State<AsignarNegocio> createState() => _AsignarNegocioState();
}

class _AsignarNegocioState extends State<AsignarNegocio> {
  bool setRequest=false;
  List<search.Data>_listUser=[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              height: MediaQuery.of(context).size.height*0.9,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5,bottom: 10,right: 20,left: 20),
                    child: RichText(
                      textAlign: TextAlign.justify,
                        text: new TextSpan(
                          children: [
                            new TextSpan(
                              text: 'Asigne la persona encargada de administrar ',
                              style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,fontSize: 15,color: PaLaCasaAppTheme.Gray),
                            ),
                            new TextSpan(
                              text: '${widget.cafeteria.name}. ',
                              style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontSize: 15,color: PaLaCasaAppTheme.Gray),
                            ),
                            new TextSpan(
                              text: 'Recuerde que esta persona es la mayor responsable de este negocio.',
                              style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,fontSize: 15,color: PaLaCasaAppTheme.Gray),
                            ),
                          ],
                            )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                    child: SearchForm(name: 'Email',onSearch: _onSearch),
                  ),
                  setRequest?Container(
                    height: MediaQuery.of(context).size.height*0.66,
                    child: Shimmer.fromColors(
                      baseColor: PaLaCasaAppTheme.grey.withOpacity(0.2),
                      highlightColor: PaLaCasaAppTheme.grey.withOpacity(0.1),
                      enabled: setRequest,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 20,left: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                maxRadius: 50,
                              ),
                              title:  Container(
                                width: MediaQuery.of(context).size.width,
                                height:15.0,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Blur(
                                      blur: 3.5,
                                      blurColor: Colors.white,
                                      child: Center(),
                                    ),
                                  ),
                                ),

                              ),
                              subtitle: Container(
                                width: MediaQuery.of(context).size.width,
                                height:12.0,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Blur(
                                      blur: 3.5,
                                      blurColor: Colors.white,
                                      child: Center(),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ):Container(
                    height: MediaQuery.of(context).size.height*0.66,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      scrollDirection: Axis.vertical,
                      itemCount: _listUser.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                         _showDialogAsignar(context,_listUser[index].name! +" "+ _listUser[index].lastname!,_listUser[index].id.toString());
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 20,left: 20),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child:CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 50,
                                    width: 50,
                                    imageUrl: _listUser[index].photo!,
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
                              title: Text(
                                _listUser[index].name! +" "+ _listUser[index].lastname!,
                                style: TextStyle(
                                  fontFamily: PaLaCasaAppTheme.fontName,
                                  fontSize: 15
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                _listUser[index].email!,
                                style: TextStyle(
                                  fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                    fontSize: 12
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
                    title: Text("Asignar Negocio",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _searchText = '';
  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });
    searchUser(_searchText);
  }

  searchUser(String filter) async {
    setRequest=true;
    _listUser.clear();
    setState(() {

    });
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/user'))
      ..fields['filter'] = filter;

    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var userJson = search.jsonSearchUser.fromJson(a);
        _listUser.addAll(userJson.user!.data!);
        setState(() {
          setRequest=false;
        });
        Fluttertoast.showToast(msg: userJson.message!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }catch(e){

      }

    }else if (response.statusCode == 401){

      print(401);
    } else {
      print(response.reasonPhrase);
    }
    setState(() {
      setRequest=false;
    });

  }

  asignar(String id_user) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/asignar'))
      ..fields['id_user'] = id_user
      ..fields['id_cafeteria'] = widget.cafeteria!.id!.toString();

    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var userJson = search.jsonSearchUser.fromJson(a);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: userJson.message!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }catch(e){

      }

    }else if (response.statusCode == 401){

      print(401);
    } else {
      print(response.reasonPhrase);
    }
    setState(() {
      setRequest=false;
    });

  }

  _showDialogAsignar(BuildContext context,String name,String id_user) {
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
                        "Asignar Negocio",
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
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 45),
                    child: Text('¿Desea asignar a $name como propietario de ${widget.cafeteria.name}?',
                      style: TextStyle(
                          fontFamily: PaLaCasaAppTheme.fontNameRegular,
                          fontSize: 15
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
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
                            Navigator.pop(context);
                         },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: PaLaCasaAppTheme.Orange.withOpacity(0.85),
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
                            asignar(id_user);
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

}
