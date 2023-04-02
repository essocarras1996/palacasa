import 'dart:convert';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:palacasa/Perfil/EditAddress.dart';
import 'package:palacasa/database/PaLaCasaDB.dart';
import 'package:palacasa/jsons/CreateUserJson.dart';
import 'package:palacasa/my_flutter_app_icons.dart';
import 'AddAddress.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../jsons/AddressJson.dart';
class AddressUser extends StatefulWidget {
  const AddressUser({Key? key}) : super(key: key);

  @override
  State<AddressUser> createState() => _AddressUserState();
}

class _AddressUserState extends State<AddressUser> {
  bool setRequest=false;
  int group=-1;
  List<Data>_listAddress=[];

  @override
  void initState() {
    getAddressUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddAddress();
              },
            ),
          ).then((value){
            getAddressUser();
          });
        },
        backgroundColor: PaLaCasaAppTheme.Orange,
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: Stack(
        children: [



          Positioned(
            top: 100,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              child:SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    setRequest?Container(
                      width: MediaQuery.of(context).size.width,
                      child: Shimmer.fromColors(
                        baseColor: PaLaCasaAppTheme.grey.withOpacity(0.2),
                        highlightColor: PaLaCasaAppTheme.grey.withOpacity(0.1),
                        enabled: setRequest,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10,left: 8.0,right: 8.0,top: 8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(30.0),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: PaLaCasaAppTheme.Gray
                                                .withOpacity(0.13),
                                            offset: Offset(10.0, 15.0),
                                            blurRadius: 18.0),
                                      ],

                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10,left: 15),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          maxRadius: 12,
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.only(top: 22.0,right: 55.0),
                                          child: Container(
                                            width: 10,
                                            height: 8.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15)
                                            ),

                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 10),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      maxRadius: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width *0.3,
                                                        height: 8.0,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(15)
                                                        ),

                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 10),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      maxRadius: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width *0.5,
                                                        height: 8.0,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(15)
                                                        ),

                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 10,bottom: 20),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      maxRadius: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width *0.4,
                                                        height: 8.0,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(15)
                                                        ),

                                                      ),
                                                    )
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
                                      top:12,
                                      right: 12,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          maxRadius: 17,
                                         )),

                                ],

                              ),
                            )
                          ),
                          itemCount: 6,
                        ),
                      ),
                    ):Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _listAddress.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10,left: 8.0,right: 8.0,top: 8.0),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: PaLaCasaAppTheme.nearlyWhite,
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: PaLaCasaAppTheme.Gray
                                              .withOpacity(0.13),
                                          offset: Offset(10.0, 15.0),
                                          blurRadius: 18.0),
                                    ],

                                  ),
                                  child: ListTile(
                                    leading: Radio(activeColor: PaLaCasaAppTheme.Orange,value: index, groupValue: group, onChanged: (value){
                                      setState(() {
                                        selectAddressUser(_listAddress[index].id_select!.toString());
                                        group=index;
                                      });
                                    }),
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 22.0),
                                      child: Text(_listAddress[index].alias!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: PaLaCasaAppTheme.fontName,
                                            color: PaLaCasaAppTheme.Gray
                                        ),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.phone,size: 15,),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15.0),
                                                child: Text('+53 ${_listAddress[index].phone}',
                                                  style: TextStyle(
                                                      fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                                      color: PaLaCasaAppTheme.Gray,
                                                      fontSize: 12.0
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(MyFlutterApp.map_marked_alt,size: 15,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.6,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 15.0,top: 10),
                                                  child: Text(_listAddress[index].street!,
                                                    style: TextStyle(
                                                        fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                                        color: PaLaCasaAppTheme.Gray,
                                                        fontSize: 12.0
                                                    ),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10,bottom: 20),
                                            child: Row(
                                              children: [
                                                Icon(MyFlutterApp.location,size: 15,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15.0),
                                                  child: Text('${_listAddress[index].municipality}, ${_listAddress[index].province}',
                                                    style: TextStyle(
                                                        fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                                        color: PaLaCasaAppTheme.Gray,
                                                        fontSize: 12.0
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top:12,
                                    right: 12,
                                    child: CircleAvatar(
                                        backgroundColor: PaLaCasaAppTheme.Orange,
                                        maxRadius: 17,
                                        child: setRequest?(index==group?Container(
                                            width: 10,
                                            height:10,
                                            child: CircularProgressIndicator(color: PaLaCasaAppTheme.nearlyWhite, strokeWidth: 2,)):IconButton(onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return EditAddress(address: _listAddress[index],);
                                              },
                                            )
                                          ).then((value){
                                            getAddressUser();
                                          });
                                        }, icon: Icon(Icons.edit,size: 15,color: PaLaCasaAppTheme.nearlyWhite,))):IconButton(onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return EditAddress(address: _listAddress[index]);
                                              },
                                            ),
                                          ).then((value){
                                            getAddressUser();
                                          });
                                        }, icon: Icon(Icons.edit,size: 15,color: PaLaCasaAppTheme.nearlyWhite,)))),

                              ],

                            ),
                          );
                        },
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
                      title: Text("Mis Direcciones",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,fontSize: 18),),
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

  getAddressUser() async {
    _listAddress=[];
    setState(() {
      setRequest=true;
    });
    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/address'));


    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    //print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      setState(() {
        setRequest=false;
      });
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var addressJson = AddressJson.fromJson(a);
        _listAddress.addAll(addressJson!.addresses!.data!);

        for(int i = 0; i<_listAddress.length;i++ ){
          if(_listAddress[i].defaultAddress==1){
            group=i;
          }
        }
        setState(() {
          setRequest=false;
        });
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

  selectAddressUser(String id) async {
    setState(() {
      setRequest=true;
    });
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/selectAddress'))
      ..fields['id'] = id;


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
