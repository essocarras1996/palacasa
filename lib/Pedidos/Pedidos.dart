import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palacasa/Helper/color_constant.dart';

class Pedidos extends StatefulWidget {
  const Pedidos({Key? key}) : super(key: key);

  @override
  State<Pedidos> createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: Column(
        children: [
          Column(
            children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 5,left: 35.0),
                    child: Text("Pedidos",
                      style: TextStyle(
                          fontFamily: PaLaCasaAppTheme.fontName,
                          fontSize: 23,
                          color: PaLaCasaAppTheme.Gray
                      ),),
                  ),
                  Center()
                ],
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 5),
                    child: Text("En Proceso",
                      style: TextStyle(
                          fontFamily: PaLaCasaAppTheme.fontName,
                          fontSize: 13,
                          color: PaLaCasaAppTheme.Orange
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 5),
                    child: Text("|",
                      style: TextStyle(
                          fontFamily: PaLaCasaAppTheme.fontName,
                          fontSize: 18,
                          color: PaLaCasaAppTheme.Gray.withOpacity(0.5)
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 5),
                    child: Text("Realizados",
                      style: TextStyle(
                          fontFamily: PaLaCasaAppTheme.fontName,
                          fontSize: 13,
                          color: PaLaCasaAppTheme.Gray.withOpacity(0.5)
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 5),
                    child: Text("|",
                      style: TextStyle(
                          fontFamily: PaLaCasaAppTheme.fontName,
                          fontSize: 18,
                          color: PaLaCasaAppTheme.Gray.withOpacity(0.5)
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 5,right: 15),
                    child: Text("Reservas",
                      style: TextStyle(
                          fontFamily: PaLaCasaAppTheme.fontName,
                          fontSize: 13,
                          color: PaLaCasaAppTheme.Gray.withOpacity(0.5)
                      ),),
                  ),
                ],
              ),
          ],),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child:
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 2.5,
                                spreadRadius: 2.5,
                                offset: Offset(0, 1),
                              )
                            ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child:Blur(
                            blur: 10.5,
                            colorOpacity: 0.7,
                            blurColor: PaLaCasaAppTheme.nearlyWhite,
                            child: Center(),
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 35,
                          left: MediaQuery.of(context).size.width-130,
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Text('En Proceso',
                                style: TextStyle(
                                  fontFamily: PaLaCasaAppTheme.fontName,
                                  fontSize: 12,
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.5)
                                ),

                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Column(
                              children: [

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              blurRadius: 2.5,
                                              spreadRadius: 2.5,
                                              offset: Offset(0, 1),
                                            )
                                          ]
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        maxRadius: 50,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child:CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 77,
                                              width: 77,
                                              imageUrl: 'https://brandemia.org/contenido/subidas/2022/10/marca-mcdonalds-logo-1200x670.png',
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
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                      child: Text("McDonald's",
                                        style: TextStyle(
                                            fontFamily:PaLaCasaAppTheme.fontName,
                                            color: PaLaCasaAppTheme.grey,
                                            fontSize: 25.0
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 60,right: 60),
                                    child: Center(
                                      child: RichText(
                                        overflow: TextOverflow.fade,
                                        maxLines: 3,
                                        text: TextSpan(
                                          style: TextStyle(
                                              fontFamily:PaLaCasaAppTheme.fontName,
                                              color: PaLaCasaAppTheme.Gray,
                                              fontSize: 14.0
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "\$860.",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            TextSpan(
                                              text: "00",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            TextSpan(
                                              text: " CUP",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                      child: Text("Elementos: 4",
                                        style: TextStyle(
                                            fontFamily:PaLaCasaAppTheme.fontNameRegular,
                                            color: PaLaCasaAppTheme.grey,
                                            fontSize: 15.0
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                      child: Text("1 marzo 2023",
                                        style: TextStyle(
                                            fontFamily:PaLaCasaAppTheme.fontNameRegular,
                                            color: PaLaCasaAppTheme.grey,
                                            fontSize: 15.0
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Checkout();
                                    },
                                  ),
                                );*/
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: PaLaCasaAppTheme.Orange,
                                    borderRadius: BorderRadius.circular(35.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: PaLaCasaAppTheme.Orange.withOpacity(0.3),
                                        blurRadius: 10.5,
                                        spreadRadius: 0.5,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0,top: 12.0,bottom: 12.0,left: 10.0),
                                    child: Center(
                                      child: Text('Rastrear Orden',
                                        style: TextStyle(
                                          fontFamily:PaLaCasaAppTheme.fontName,
                                          color: PaLaCasaAppTheme.nearlyWhite,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow:TextOverflow.ellipsis,
                                        softWrap: true,
                                        maxLines: 1,),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
