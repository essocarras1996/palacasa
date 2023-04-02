
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:palacasa/jsons/jsonPanelCafeteria.dart';

import '../../my_flutter_app_icons.dart';
import 'AddressBusiness.dart';
import 'CategoriesScreen.dart';
import 'DatosBusiness.dart';

class CafeteriaPanel extends StatefulWidget {
  final Cafeterias cafeteria;
  const CafeteriaPanel({Key? key, required this.cafeteria}) : super(key: key);

  @override
  State<CafeteriaPanel> createState() => _CafeteriaPanelState();
}

class _CafeteriaPanelState extends State<CafeteriaPanel> {

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
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(75.0),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: PaLaCasaAppTheme.Gray.withOpacity(0.1)
                                            .withOpacity(0.5),
                                        offset: Offset(3.0, 5),
                                        blurRadius: 15.0),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(75.0),
                                  child:CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width:80,
                                      imageUrl: widget.cafeteria.logo!,
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
                      Center(child: Column(
                        children: [
                          Text(widget.cafeteria.name!,
                            style: TextStyle(
                                fontFamily:PaLaCasaAppTheme.fontName,
                                color: PaLaCasaAppTheme.Gray,
                                fontSize: 15.0
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(widget.cafeteria.description!,
                              style: TextStyle(
                                  fontFamily:PaLaCasaAppTheme.fontNameRegular,
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.5),
                                  fontSize: 13.0
                              ),

                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CategoriesScreen(id_cafeteria: '${widget.cafeteria.id!}',);
                                    },
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: PaLaCasaAppTheme.Orange,
                                  maxRadius: 25,
                                  child: Icon(MyFlutterApp.tag,color: Colors.white,size: 20,),
                                ),
                                title: Text(
                                  "Categorías",
                                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: PaLaCasaAppTheme.Gray,fontSize: 16.0,),
                                  textAlign: TextAlign.left,
                                ),
                                subtitle: Text(
                                  "Añadir categorías a su negocio",
                                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray,fontSize: 12.0,),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: PaLaCasaAppTheme.Orange,
                                maxRadius: 25,
                                child: Icon(MyFlutterApp.feather_alt,color: Colors.white,size: 20,),
                              ),
                              title: Text(
                                "Ofertas",
                                style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: PaLaCasaAppTheme.Gray,fontSize: 16.0,),
                                textAlign: TextAlign.left,
                              ),
                              subtitle: Text(
                                "Añadir ofertas a su negocio",
                                style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray,fontSize: 12.0,),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: PaLaCasaAppTheme.Orange,
                                maxRadius: 25,
                                child: Icon(Icons.stacked_bar_chart,color: Colors.white,),
                              ),
                              title: Text(
                                "Estadísticas",
                                style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: PaLaCasaAppTheme.Gray,fontSize: 16.0,),
                                textAlign: TextAlign.left,
                              ),
                              subtitle: Text(
                                "LLeve el control de su negocio",
                                style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray,fontSize: 12.0,),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return AddressUser();
                                    },
                                  ),
                                );*/
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DatosBusiness(cafeteria:widget.cafeteria);
                                    },
                                  ),
                                );
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: PaLaCasaAppTheme.Orange,
                                    maxRadius: 25,
                                    child: Icon(Icons.business_center,color: Colors.white,),
                                  ),
                                  title: Text(
                                    "Datos del Negocio",
                                    style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: PaLaCasaAppTheme.Gray,fontSize: 16.0,),
                                    textAlign: TextAlign.left,
                                  ),
                                  subtitle: Text(
                                    "Editar datos del negocio",
                                    style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray,fontSize: 12.0,),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AddressBusiness(id_cafeteria: '${widget.cafeteria.id!}',);
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: PaLaCasaAppTheme.Orange,
                                    maxRadius: 25,
                                    child: Icon(Icons.location_on_rounded,color: Colors.white,),
                                  ),
                                  title: Text(
                                    "Dirección",
                                    style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: PaLaCasaAppTheme.Gray,fontSize: 16.0,),
                                    textAlign: TextAlign.left,
                                  ),
                                  subtitle: Text(
                                    "Añadir dirección del negocio",
                                    style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray,fontSize: 12.0,),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
                    title: Text("Detalles del Negocio",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
