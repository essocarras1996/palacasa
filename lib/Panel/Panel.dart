import 'dart:convert';
import 'dart:io';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palacasa/Administrator/Categorias/Categorias.dart';
import 'package:palacasa/Administrator/Categorias/AsignarNegocio.dart';
import 'package:palacasa/Administrator/Categorias/Users.dart';
import 'package:palacasa/Administrator/Categorias/addNegocio.dart';
import 'package:palacasa/bottom_navigation_view/bottom_bar_viewad.dart';
import 'package:http/http.dart' as http;
import 'package:palacasa/jsons/CreateUserJson.dart';
import 'package:palacasa/jsons/categoriesJson.dart';
import 'package:palacasa/jsons/jsonPanelCafeteria.dart';
import 'package:shimmer/shimmer.dart';
import '../Helper/color_constant.dart';
import '../Helper/search_form.dart';
import '../bottom_navigation_view/bottom_bar_panel.dart';
import '../database/PaLaCasaDB.dart';

import '../models/tabIcon_data.dart';
import 'package:image_picker/image_picker.dart';

import 'CafeteriaPanel.dart';


class PanelScreen extends StatefulWidget {
  final VoidCallback menuCallBack;
  const PanelScreen({Key? key, required this.menuCallBack}) : super(key: key);

  @override
  State<PanelScreen> createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> with TickerProviderStateMixin{
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsListAdmin;
  List<TypeBusiness>_listBusiness=[];
  List<Categories>_listCategorias=[];
  bool setRequest=true;
  bool showStore=true;
  bool showCategoria=false;
  bool showPerfil=false;
  bool favorite=false;
  IconData icon = Icons.add;
  bool isCategory = true;
  String value='Negocio';
  late File imageFile;
  var items =['Negocio'];
  var _controllerNegocio = new TextEditingController();
  var _controllerCategoria = new TextEditingController();
  var _controllerImagen = TextEditingController();
  int itemsSelect = 0;
  int selectIndex=0;
  List<Cafeterias> _listCafeterias=[];

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    getPanel();

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
                showStore?SafeArea(child: Column(
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
                    setRequest?Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 16),
                      child: Shimmer.fromColors(
                        baseColor: PaLaCasaAppTheme.grey.withOpacity(0.2),
                        highlightColor: PaLaCasaAppTheme.grey.withOpacity(0.1),
                        enabled: setRequest,
                        child: Container(
                          height: 60,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: PaLaCasaAppTheme.background.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(18.0),
                                      border: Border.all(color:PaLaCasaAppTheme.Gray.withOpacity(0.2),),
                                      boxShadow: [
                                        BoxShadow(
                                            color:PaLaCasaAppTheme.Gray.withOpacity(0.2),
                                            offset: Offset(5.0, 5.0),
                                            blurRadius: 8.0
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15,right: 15.0,left: 15.0,bottom: 15),
                                    child: Container(
                                      width: 60.0,
                                      height: 1.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ):Container(
                      height: 60,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        itemCount: _listBusiness.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                itemsSelect=index;
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
                                  child: Text(_listBusiness[index].name!,
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
                    setRequest?Container(
                      height: MediaQuery.of(context).size.height*0.70,
                      child: Shimmer.fromColors(
                        baseColor: PaLaCasaAppTheme.grey.withOpacity(0.2),
                        highlightColor: PaLaCasaAppTheme.grey.withOpacity(0.1),
                        enabled: setRequest,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 8, right: 8, bottom: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.03),
                                              borderRadius: BorderRadius.circular(20.0)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(

                                                borderRadius: BorderRadius.circular(20.0),
                                                child:Container(
                                                  height: 226,
                                                  color: Colors.white.withOpacity(0.3),
                                                )

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8, right: 8,),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height:165,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(20.0)
                                          ),
                                        ),
                                        Stack(
                                            children:[
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                height:75,
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
                                              Positioned(
                                                top:10,
                                                left:20,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width*0.4,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:40,
                                                left:20,
                                                child: Row(
                                                  children: [
                                                    Row(
                                                      children: [

                                                        Image(
                                                          image: AssetImage('assets/fitness_app/star.png'),
                                                          width: 22.0,
                                                        ),
                                                        Container(
                                                          width: 20,
                                                          height: 8.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(15)
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image(
                                                          image: AssetImage('assets/fitness_app/clock.png'),
                                                          width: 30.0,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width*0.2,
                                                          height: 8.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(15)
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]

                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top:20,
                                    left:MediaQuery.of(context).size.width-60,
                                    child: Container(
                                      width:40,
                                      height:40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: PaLaCasaAppTheme.nearlyBlack
                                                  .withOpacity(0.2),
                                              offset: Offset(5.0, 5.0),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(35),
                                            child:Blur(
                                              blur: 3.5,
                                              blurColor: Colors.white,
                                              child: Center(),
                                            ),
                                          ),
                                          IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.red,size: 20,))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ):Container(
                      height: MediaQuery.of(context).size.height*0.70,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.vertical,
                        itemCount: _listCafeterias.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CafeteriaPanel(cafeteria: _listCafeterias[index]);
                                  },
                                ),
                              );
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 8, right: 8, bottom: 10),
                                    child: Column(
                                      children: [
                                        Container(

                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: PaLaCasaAppTheme.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(1.1, 4.0),
                                                    blurRadius: 8.0),
                                              ],

                                              borderRadius: BorderRadius.circular(20.0)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20.0),
                                              child:CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  height: 226,
                                                  width:MediaQuery.of(context).size.width,
                                                  imageUrl: _listCafeterias[index].photo!,
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
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8, right: 8,),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height:165,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(20.0)
                                          ),
                                        ),
                                        Stack(
                                            children:[
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                height:75,
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
                                              Positioned(
                                                top:10,
                                                left:20,
                                                child: Text(_listCafeterias[index].name!,
                                                  style: TextStyle(
                                                      fontFamily:PaLaCasaAppTheme.fontName,
                                                      color: PaLaCasaAppTheme.nearlyWhite,
                                                      fontSize: 20.0
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:40,
                                                left:20,
                                                child: Row(
                                                  children: [
                                                    Row(
                                                      children: [

                                                        Image(
                                                          image: AssetImage('assets/fitness_app/star.png'),
                                                          width: 22.0,
                                                        ),
                                                        Text(" 4.5",
                                                          style: TextStyle(
                                                            fontFamily: PaLaCasaAppTheme.fontName,
                                                            color: Colors.white,
                                                          ),)
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image(
                                                          image: AssetImage('assets/fitness_app/clock.png'),
                                                          width: 30.0,
                                                        ),
                                                        Text(_listCafeterias[index].tiempoEntrega!+" Min",
                                                          style: TextStyle(
                                                            fontFamily: PaLaCasaAppTheme.fontName,
                                                            color: Colors.white,
                                                          ),)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]

                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top:20,
                                    left:MediaQuery.of(context).size.width-60,
                                    child: Container(
                                      width:40,
                                      height:40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: PaLaCasaAppTheme.nearlyBlack
                                                  .withOpacity(0.2),
                                              offset: Offset(5.0, 5.0),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(35),
                                            child:Blur(
                                              blur: 3.5,
                                              blurColor: Colors.white,
                                              child: Center(),
                                            ),
                                          ),
                                          IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.red,size: 20,))
                                        ],
                                      ),
                                    ),
                                  ),
                                  _listCafeterias[index].isOpen=='0'?Positioned(
                                    top:20,
                                    left:20,
                                    child: Container(
                                      width:100,
                                      height:40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: PaLaCasaAppTheme.nearlyBlack
                                                  .withOpacity(0.2),
                                              offset: Offset(5.0, 5.0),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(35),
                                            child:Blur(
                                              blur: 3.5,
                                              blurColor: Colors.white,
                                              child: Center(),
                                            ),
                                          ),
                                          Center(child: Text("Cerrado".toUpperCase(),style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: Colors.redAccent),))
                                        ],
                                      ),
                                    ),
                                  ):Center(),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )):Center(),
                showCategoria?SafeArea(
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
                              Text('Categorías',
                                style: TextStyle(
                                    fontFamily: PaLaCasaAppTheme.fontName,
                                    color: PaLaCasaAppTheme.Gray,
                                    fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      setRequest
                          ?Container(
                        width:MediaQuery.of(context).size.width,
                        height:MediaQuery.of(context).size.height*0.78,
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
                          : (selectIndex==0
                          ?Container(
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
                                    CircleAvatar(
                                        backgroundColor: PaLaCasaAppTheme.grey.withOpacity(0.6),
                                        maxRadius: 15,
                                        child: Icon(Icons.delete,color: Colors.white,size: 15,)
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {

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
                          :Container(
                        width:MediaQuery.of(context).size.width ,
                        height:MediaQuery.of(context).size.height*0.78,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.vertical,
                          itemCount: _listCategorias.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading:CachedNetworkImage(
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  imageUrl: _listCategorias[index].image!,
                                  placeholder: (context, url) => CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    maxRadius: 30,
                                    child: CircularProgressIndicator(
                                      color: PaLaCasaAppTheme.grey,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => new Icon(Icons.image_not_supported_outlined,color: PaLaCasaAppTheme.grey,)
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
                                    GestureDetector(
                                      onTap: () {

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
                              title: Text(_listCategorias[index].name!,
                                style: TextStyle(
                                    fontFamily: PaLaCasaAppTheme.fontName,
                                    color: PaLaCasaAppTheme.Gray
                                ),
                              ),
                              subtitle: Text(getNameTypeBusiness(_listCategorias[index].idType!),
                                style: TextStyle(
                                    fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                    color: PaLaCasaAppTheme.Gray
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      ),
                    ],
                  ),
                ):Center(),


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
        BottomBarPanel(
          iconData: icon,
          tabIconsList: tabIconsList,
          addClick: () {

          },
          changeIndex: (int index) {
            if (index == 0 ) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                showStore=true;
                showPerfil=false;
                showCategoria=false;
                favorite=false;
                setState(() {

                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                showStore=false;
                showPerfil=false;
                showCategoria=true;
                favorite=false;
                setState(() {

                });
              });
            } else if (index == 2) {
              showStore=false;
              showPerfil=false;
              showCategoria=false;
              favorite=true;
              setState(() {

              });
            }else{
              showStore=false;
              showPerfil=true;
              showCategoria=false;
              favorite=false;

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






  String getNameTypeBusiness(String s) {
    String name = "";
    for(var a in _listBusiness){
      if(a.id.toString()==s){
        return a.name!;
      }
    }
    return name;
  }

  String getIdBusiness(String value) {
    for(var b in _listBusiness){
      if(b.name.toString()==value ){
        print('${b.id!} ${b.name}');
        return b.id!.toString();
      }
    }
    return "";
  }

  getPanel() async {
    _listCafeterias=[];
    setRequest =true;
    setState(() {

    });
    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/panel'));

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
        var cafeterias = jsonPanelCafeteria.fromJson(a);
        _listCafeterias.addAll(cafeterias.cafeterias!);
        _listBusiness.clear();
        _listBusiness.addAll(cafeterias.typeBusiness!);
        setRequest=false;
        setState(() {

        });
      }catch(e){
        setRequest=false;
        setState(() {

        });
        Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }

    }else if (response.statusCode == 401){

      print(401);
      setRequest=false;
      setState(() {

      });
    } else {
      print(response.reasonPhrase);
      setRequest=false;
      setState(() {

      });
    }

  }

  String _searchText = '';
  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });
    print('Texto ingresado: $_searchText');
  }
}
