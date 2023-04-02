import 'dart:convert';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palacasa/Comida/Favoritos.dart';
import 'package:palacasa/Comida/MapsRestaurantCU.dart';
import 'package:palacasa/Comida/RestaurantScreen.dart';
import 'package:palacasa/Helper/CircularImage.dart';
import 'package:palacasa/Helper/ItemsFood.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:palacasa/HiddenDrawer/hidden_drawer.dart';
import 'package:palacasa/Perfil/Perfil.dart';
import 'package:palacasa/jsons/categoriesJson.dart';
import 'package:palacasa/my_flutter_app_icons.dart';
import 'package:http/http.dart' as http;
import 'Comida/TypeFood.dart';
import 'Helper/search_form.dart';
import 'Pedidos/Pedidos.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'database/PaLaCasaDB.dart';
import 'models/tabIcon_data.dart';

class PaLaCasaAppHomeScreen extends StatefulWidget {
  final VoidCallback menuCallBack;
  const PaLaCasaAppHomeScreen({Key? key, required this.menuCallBack}) : super(key: key);

  @override
  State<PaLaCasaAppHomeScreen> createState() => _PaLaCasaAppHomeScreenState();
}

class _PaLaCasaAppHomeScreenState extends State<PaLaCasaAppHomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  bool setRequest=true;
  bool showMap=false;
  bool showStore=true;
  bool showPerfil=false;
  bool showFavorite=false;
  bool isLoading=true;
  List<CafeteriasPopulares> _listPopulares=[];
  late List<ItemsFood> itemsFoods=
  [
    ItemsFood(name: 'Rápida',pathImage: 'https://cdn.icon-icons.com/icons2/2852/PNG/96/burger_fast_food_icon_181517.png', startColor: '#FA7D82', endColor: '#FFB295'),
    ItemsFood(name: 'Postres',pathImage: 'https://cdn.icon-icons.com/icons2/236/PNG/96/Cake_ChocolateCake_26374.png', startColor: '#738AE6', endColor: '#5C5EDD'),
    ItemsFood(name: 'Italiana',pathImage: 'https://cdn.icon-icons.com/icons2/281/PNG/96/Pizza-icon_30282.png', startColor: '#FE95B6', endColor: '#FF5287'),
    ItemsFood(name: 'Cubana',pathImage: 'https://cdn.icon-icons.com/icons2/2852/PNG/96/drumstick_chicken_leg_food_icon_181515.png', startColor: '#FA7D82', endColor: '#FFB295'),
    ItemsFood(name: 'Mariscos',pathImage: 'https://cdn.icon-icons.com/icons2/236/PNG/96/Cake_ChocolateCake_26374.png', startColor: '#f24f04', endColor: '#FFB295'),
    ItemsFood(name: 'Mexicana',pathImage: 'https://cdn.icon-icons.com/icons2/236/PNG/96/Cake_ChocolateCake_26374.png', startColor: '#FA7D82', endColor: '#FFB295'),
    ItemsFood(name: 'Española',pathImage: 'https://cdn.icon-icons.com/icons2/236/PNG/96/Cake_ChocolateCake_26374.png', startColor: '#FA7D82', endColor: '#FFB295'),
    ItemsFood(name: 'Asiática',pathImage: 'https://cdn.icon-icons.com/icons2/236/PNG/96/Cake_ChocolateCake_26374.png', startColor: '#FA7D82', endColor: '#FFB295'),
    ItemsFood(name: 'Peruana',pathImage: 'https://cdn.icon-icons.com/icons2/236/PNG/96/Cake_ChocolateCake_26374.png', startColor: '#FA7D82', endColor: '#FFB295'),
    ItemsFood(name: 'Bebidas',pathImage: 'https://cdn.icon-icons.com/icons2/2852/PNG/96/soda_can_drink_icon_181510.png', startColor: '#FA7D82', endColor: '#FFB295'),
    ItemsFood(name: 'Jugos',pathImage: 'https://cdn.icon-icons.com/icons2/2852/PNG/96/glass_drink_icon_181513.png', startColor: '#FA7D82', endColor: '#FFB295'),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double xOffset=0;
  double yOffset=0;
  double scaleFactor=1;
  bool isDrawerOpen = false;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    getCategories();
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
      key: _scaffoldKey,
      backgroundColor: PaLaCasaAppTheme.background,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                showStore?SafeArea(
                  child:
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ListTile(
                                leading: IconButton(
                                  onPressed: widget.menuCallBack,
                                  icon: SvgPicture.asset("assets/icons/paragraph.svg",color: PaLaCasaAppTheme.deepGRAY),
                                ),
                                title: Text("Pa' mi Casa",style: TextStyle(fontFamily: 'Poppinss',fontWeight: FontWeight.bold,fontSize: 18),),
                              ),
                            ),
                          )
                        ],
                      ),
                      setRequest?Shimmer.fromColors(
                        baseColor: PaLaCasaAppTheme.grey.withOpacity(0.2),
                        highlightColor: PaLaCasaAppTheme.grey.withOpacity(0.1),
                        enabled: setRequest,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8,left: 16,right: MediaQuery.of(context).size.width*0.6),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                height: 20.0,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15)
                                ),

                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8,left: 16,right: MediaQuery.of(context).size.width*0.3),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                height: 8.0,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15)
                                ),

                              ),
                            ),



                          ],
                        ),
                      ): Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
                            child: Text(
                              "Busca",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontFamily:'Poppinss',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16,right: 16),
                            child: Text(
                              "las mejores Opciones para tí",
                              style: TextStyle(fontFamily:'Poppinsr',fontSize: 15, color: PaLaCasaAppTheme.grey),
                            ),
                          ),



                        ],
                      ),
                    ],
                  ),
                ):Center(),
                showMap?MapsRestaurant():Center(),
                showFavorite?Favoritos():Center(),
                showPerfil?Perfil():Center(),
                showStore?(
                    setRequest
                    ?Shimmer.fromColors(
                      baseColor: PaLaCasaAppTheme.grey.withOpacity(0.2),
                      highlightColor: PaLaCasaAppTheme.grey.withOpacity(0.1),
                      enabled: setRequest,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 130.0),
                        child: SafeArea(
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 80),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 16),
                                      child: Form(
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 180,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 6,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: 130,
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 32, left: 8, right: 8, bottom: 16),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                            color: Colors.white
                                                                .withOpacity(0.01),
                                                            offset: const Offset(1.1, 4.0),
                                                            blurRadius: 8.0),
                                                      ],
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.white.withOpacity(0.5),
                                                          Colors.white
                                                        ],
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                      ),
                                                      borderRadius: const BorderRadius.only(
                                                        bottomRight: Radius.circular(8.0),
                                                        bottomLeft: Radius.circular(8.0),
                                                        topLeft: Radius.circular(8.0),
                                                        topRight: Radius.circular(54.0),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          top: 60, left: 16, right: 16, bottom: 8),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 50,
                                                            height: 8.0,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(15)
                                                            ),

                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.only(top: 8, bottom: 8),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Text(
                                                                    '',
                                                                    style: TextStyle(
                                                                      fontFamily: PaLaCasaAppTheme.fontName,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 10,
                                                                      letterSpacing: 0,
                                                                      color: PaLaCasaAppTheme.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 35,
                                                            height: 35,
                                                            decoration: BoxDecoration(
                                                              color: PaLaCasaAppTheme.nearlyWhite,
                                                              shape: BoxShape.circle,
                                                              boxShadow: <BoxShadow>[
                                                                BoxShadow(
                                                                    color: PaLaCasaAppTheme.nearlyBlack
                                                                        .withOpacity(0.4),
                                                                    offset: Offset(8.0, 8.0),
                                                                    blurRadius: 8.0),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    width: 84,
                                                    height: 84,
                                                    decoration: BoxDecoration(
                                                      color: PaLaCasaAppTheme.nearlyWhite.withOpacity(0.2),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  left: 8,
                                                  child: SizedBox(
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                                              child: Text(
                                                "Populares",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(fontFamily:'Poppinss',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 22,left: 16,right: 16),
                                              child: Text(
                                                "Ver más",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(fontFamily:'Poppinsr',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 12),
                                              ),
                                            ),

                                          ],
                                        ),
                                        Container(
                                          height: 250,
                                          child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 2,
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
                                                            IconButton(onPressed: (){}, icon: Icon(MyFlutterApp.heart_empty,color: Colors.red,size: 20,))
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

                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                                              child: Text(
                                                "Cercanos",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(fontFamily:'Poppinss',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 22,left: 16,right: 16),
                                              child: Text(
                                                "Ver más",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(fontFamily:'Poppinsr',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 12),
                                              ),
                                            ),

                                          ],
                                        ),
                                        Container(
                                          height: 250,
                                          child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 2,
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
                                                            IconButton(onPressed: (){}, icon: Icon(MyFlutterApp.heart_empty,color: Colors.red,size: 20,))
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


                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    :Padding(
                      padding: const EdgeInsets.only(top: 130.0),
                      child: SafeArea(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 80),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 16),
                                    child: SearchForm(name: 'Buscar',onSearch: _onSearch),
                                  ),

                                  Container(
                                    height: 180,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(
                                          parent: AlwaysScrollableScrollPhysics()),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: itemsFoods.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          width: 130,
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return TypeFood();
                                                  },
                                                ),
                                              );
                                            },
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 32, left: 8, right: 8, bottom: 16),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                            color: HexColor(itemsFoods[index].endColor)
                                                                .withOpacity(0.6),
                                                            offset: const Offset(1.1, 4.0),
                                                            blurRadius: 8.0),
                                                      ],
                                                      gradient: LinearGradient(
                                                        colors: <HexColor>[
                                                          HexColor(itemsFoods[index].startColor),
                                                          HexColor(itemsFoods[index].endColor),
                                                        ],
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                      ),
                                                      borderRadius: const BorderRadius.only(
                                                        bottomRight: Radius.circular(8.0),
                                                        bottomLeft: Radius.circular(8.0),
                                                        topLeft: Radius.circular(8.0),
                                                        topRight: Radius.circular(54.0),
                                                      ),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return TypeFood();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 60, left: 16, right: 16, bottom: 8),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              itemsFoods[index].name,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontFamily: PaLaCasaAppTheme.fontName,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                                letterSpacing: 0.2,
                                                                color: PaLaCasaAppTheme.white,
                                                              ),
                                                              maxLines:1,
                                                              overflow: TextOverflow.fade,
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets.only(top: 8, bottom: 8),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      '',
                                                                      style: TextStyle(
                                                                        fontFamily: PaLaCasaAppTheme.fontName,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 10,
                                                                        letterSpacing: 0,
                                                                        color: PaLaCasaAppTheme.white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: PaLaCasaAppTheme.nearlyWhite,
                                                                shape: BoxShape.circle,
                                                                boxShadow: <BoxShadow>[
                                                                  BoxShadow(
                                                                      color: PaLaCasaAppTheme.nearlyBlack
                                                                          .withOpacity(0.4),
                                                                      offset: Offset(8.0, 8.0),
                                                                      blurRadius: 8.0),
                                                                ],
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(6.0),
                                                                child: Icon(
                                                                  Icons.search,
                                                                  color: HexColor(itemsFoods[index].endColor),
                                                                  size: 24,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    width: 84,
                                                    height: 84,
                                                    decoration: BoxDecoration(
                                                      color: PaLaCasaAppTheme.nearlyWhite.withOpacity(0.2),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  left: 8,
                                                  child: SizedBox(
                                                    width: 80,
                                                    height: 80,
                                                    child:ClipRRect(
                                                      borderRadius: BorderRadius.circular(20.0),
                                                      child:CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl: itemsFoods[index].pathImage,
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
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                                            child: Text(
                                              "Populares",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(fontFamily:'Poppinss',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 20),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 22,left: 16,right: 16),
                                            child: Text(
                                              "Ver más",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(fontFamily:'Poppinsr',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 12),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Container(
                                        height: 250,
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(
                                              parent: AlwaysScrollableScrollPhysics()),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _listPopulares.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return RestaurantScreen();
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
                                                                    imageUrl: _listPopulares[index].photo!,
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
                                                                  child: Text(_listPopulares[index].name!,
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
                                                                          Text(_listPopulares[index].tiempoEntrega!+" Min",
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
                                                            IconButton(onPressed: (){}, icon: Icon(MyFlutterApp.heart_empty,color: Colors.red,size: 20,))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    _listPopulares[index].isOpen=='0'?Positioned(
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
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                                            child: Text(
                                              "Cercanos",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(fontFamily:'Poppinss',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 20),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 22,left: 16,right: 16),
                                            child: Text(
                                              "Ver más",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(fontFamily:'Poppinsr',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 12),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Container(
                                        height: 250,
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(
                                              parent: AlwaysScrollableScrollPhysics()),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: itemsFoods.length,
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
                                                            child:ClipRRect(
                                                              borderRadius: BorderRadius.circular(20.0),
                                                              child:CachedNetworkImage(
                                                                  fit: BoxFit.cover,
                                                                  height: 226,
                                                                  width:MediaQuery.of(context).size.width,
                                                                  imageUrl: 'https://i.pinimg.com/originals/2a/2d/8b/2a2d8b2e6465ea7dceae12fba63f9a53.jpg',
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
                                                                child: Text("Starbucks Coffee",
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
                                                                            fontFamily: 'Poppinss',
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
                                                                        Text("30-60 Min",
                                                                          style: TextStyle(
                                                                            fontFamily: 'Poppinss',
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
                                                          IconButton(onPressed: (){}, icon: Icon(MyFlutterApp.heart,color: Colors.red,size: 20,))
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


                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                ):Center(),


                bottomBar(),
              ],
            );
          }
        },
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  getListHorizontalFood(){
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()),
      itemCount: itemsFoods.length,
      padding: const EdgeInsets.only(top: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index)
      {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.5,
                  spreadRadius: 2.5,
                  offset: Offset(0, 1),
                )
              ]
          ),
          child: ListTile(
            title: Text(itemsFoods[index].name,style: TextStyle(fontFamily:'Poppinss'),),
          ),
        );
      },
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 ) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                showStore=true;
                showPerfil=false;
                showFavorite=false;
                showMap=false;
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
                showFavorite=false;
                showMap=true;

                setState(() {

                });
              });
            } else if (index == 2) {
              showStore=false;
              showPerfil=false;
              showMap=false;
              showFavorite=true;
              setState(() {

              });
            }else{
              showStore=false;
              showPerfil=true;
              showMap=false;
              showFavorite=false;

              setState(() {

              });

            }
          },
        ),
      ],
    );
  }

  getCategories() async {
    isLoading=true;
    setRequest=true;
    itemsFoods=[];

    setState(() {

    });
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
        _listPopulares.addAll(categories.cafeteriasPopulares!);
        int i = 1;
        for(var c in categories.categories!){
          if(i==1){
            itemsFoods.add(new ItemsFood(name: c.name!, pathImage: c.image!,  startColor: '#FA7D82', endColor: '#FFB295'));
            i=2;
          }else
          if(i==2){
            itemsFoods.add(new ItemsFood(name: c.name!, pathImage: c.image!,  startColor: '#738AE6', endColor: '#5C5EDD'));
            i=3;
          }else
          if(i==3){
            itemsFoods.add(new ItemsFood(name: c.name!, pathImage: c.image!,  startColor: '#FE95B6', endColor: '#FF5287'));
            i=1;
          }
        }
        setRequest=false;
        setState(() {

        });
      }catch(e){
        setRequest=false;
        //Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      }

    }else if (response.statusCode == 401){
      setRequest=false;
      print(401);
    } else {
      setRequest=false;
      print(response.reasonPhrase);
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
