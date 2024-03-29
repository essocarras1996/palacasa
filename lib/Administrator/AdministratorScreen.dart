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
import 'package:palacasa/jsons/businessAdminJson.dart';
import 'package:shimmer/shimmer.dart';
import '../Helper/color_constant.dart';
import '../Helper/search_form.dart';
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

class _AdministratorScreenState extends State<AdministratorScreen> with TickerProviderStateMixin{
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
  int selectIndex=0;
  List<Data> _listCafeterias=[];

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    getCafeterias();

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
                        child: Form(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                    ):Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 16),
                      child: SearchForm(name: 'Nombre',onSearch: _onSearch),
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
                              Navigator.push(context,  MaterialPageRoute(
                                builder: (context) {
                                  return AsignarNegocio(cafeteria: _listCafeterias[index]);
                                },
                              ),);
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
                              GestureDetector(
                                onTap: () => setState(() {
                                  selectIndex=0;
                                }),
                                child: Text('Negocios',
                                  style: TextStyle(
                                      fontFamily: selectIndex==0?PaLaCasaAppTheme.fontName:PaLaCasaAppTheme.fontNameRegular,
                                      color: PaLaCasaAppTheme.Gray,
                                      fontSize: 16
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
                                }),
                                child: Text('Categorías',
                                  style: TextStyle(
                                      fontFamily: selectIndex==1?PaLaCasaAppTheme.fontName:PaLaCasaAppTheme.fontNameRegular,
                                      color: PaLaCasaAppTheme.Gray,
                                      fontSize: 16
                                  ),
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
                                        value = items.first;
                                        _controllerCategoria.text=_listCategorias[index].name!;
                                        value = getNameTypeBusiness(_listCategorias[index].idType!);
                                        setState(() {

                                        });
                                        _showDialogEditCategories(context, _listCategorias[index].id.toString());
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

  /*Widget bottomBar() {
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
              if(selectIndex==1){
                _showDialogCategories(context);
              }else{
                _showDialogNegocio(context);
              }
            }

            if(showStore){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return addNegocio(listBusiness: _listBusiness);
                  },
                ),
              );
            }

          },
          changeIndex: (int index) {
            if (index == 0 ) {
              animationController?.reverse().then<dynamic>((data) {

                icon = Icons.add;
                showPerfil=false;
                favorite=false;
                showCategoria=false;
                showStore=true;
                getCafeterias();
                setState(() {

                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {

                getTypeBusiness();
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
  }*/

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
              if(selectIndex==0){
                _showDialogNegocio(context);
              }else{
                _showDialogCategories(context);
              }
            }
             else if(showStore){
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) {
                     return addNegocio(listBusiness: _listBusiness);
                   },
                 ),
               );
             }
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
                getTypeBusiness();
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
                              String name = _controllerCategoria.text;
                              String pathI = _controllerImagen.text;
                              String negocioID = getIdBusiness(value);

                              if(name.isEmpty||pathI.isEmpty){
                                Fluttertoast.showToast(msg: "Rellene los espacios en blanco",backgroundColor: Colors.grey,gravity: ToastGravity.SNACKBAR);
                              }else{
                                value=="Negocio"
                                    ?Fluttertoast.showToast(msg: "Seleccione un negocio",backgroundColor: Colors.grey,gravity: ToastGravity.SNACKBAR)
                                    :addCategory(negocioID, name,);
                              }

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

  _showDialogEditCategories(BuildContext context,String id) {
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
                          "Modificar Categoría",
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

                    SizedBox(
                      height: 20.0,
                    ),
                    Row(

                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              String name = _controllerCategoria.text;
                              String negocioID = getIdBusiness(value);

                              if(name.isEmpty){
                                Fluttertoast.showToast(msg: "Rellene los espacios en blanco",backgroundColor: Colors.grey,gravity: ToastGravity.SNACKBAR);
                              }else{
                                value=="Negocio"
                                    ?Fluttertoast.showToast(msg: "Seleccione un negocio",backgroundColor: Colors.grey,gravity: ToastGravity.SNACKBAR)
                                    :editCategory(id,negocioID, name,);
                              }

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
        getTypeBusiness();
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

    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/editTypeBusiness'));
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
        getTypeBusiness();
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



  addCategory(String id_type,String name) async {
    print("Sdf");
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var userJson = createUserJson.fromJson(a);
        getTypeBusiness();
        Navigator.pop(context);
        Fluttertoast.showToast(msg: userJson.message!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }catch(e){

      }

    }else if (response.statusCode == 401){

      print(401);
    } else {
      print(response.reasonPhrase);
    }

  }

  editCategory(String id,String id_type,String name) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/editCategories'))
      ..fields['id'] = id
      ..fields['id_type'] = id_type
      ..fields['name'] = name;

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
        var userJson = createUserJson.fromJson(a);
        getTypeBusiness();
        Navigator.pop(context);
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
    _listBusiness=[];
    _listCategorias=[];
    items=['Negocio'];
    setRequest=true;
    setState(() {

    });
    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/acategories'));

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
        var typeBusiness = businessAdminJson.fromJson(a);
        _listBusiness.addAll(typeBusiness.typeBusiness!);
        var categories = categoriesJson.fromJson(a);
        _listCategorias.addAll(categories.categories!);
        for(var n in _listBusiness){
          items.add(n.name!);
        }
        setState(() {

        });
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
    setRequest=false;
    setState(() {

    });
  }

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

  getCafeterias() async {
    _listCafeterias=[];
    setRequest =true;
    setState(() {

    });
    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/acafeterias'));

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
        var cafeterias = businessAdminJson.fromJson(a);
        _listCafeterias.addAll(cafeterias.cafeterias!.data!);
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
