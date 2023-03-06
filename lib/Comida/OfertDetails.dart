import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/color_constant.dart';

class OfertDetails extends StatefulWidget {
  const OfertDetails({Key? key}) : super(key: key);

  @override
  State<OfertDetails> createState() => _OfertDetailsState();
}

class _OfertDetailsState extends State<OfertDetails> {

  var _controllerDescripcion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 300,
                  width:MediaQuery.of(context).size.width,
                  imageUrl: 'https://imageproxy.wolt.com/venue/61de9388adf9fa53f6e03e13/a51fc310-cc7a-11ec-818d-1611eb149b6d_mcd_hero_banner_1440x810_wolt__1_.png',
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
          Positioned(
            top: 250,
            right: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0),topRight: Radius.circular(45.0)),
                boxShadow: [
                  BoxShadow(
                    color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                    blurRadius: 20.5,
                    spreadRadius: 0.5,
                    offset: Offset(-3, -3),
                  ),
                ],

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0,top: 45.0,bottom: 2.0,left: 25.0),
                        child: Text('Combo McBigBurger',
                          style: TextStyle(
                            fontFamily:PaLaCasaAppTheme.fontName,
                            color: PaLaCasaAppTheme.deepGRAY,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow:TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0,top: 0.0,bottom: 8.0,left: 25.0),
                        child: Text('Dos Hamburguesas de cerdo con Queso Gouda y Vegetales, más batido de helado.',
                          style: TextStyle(
                            fontFamily:PaLaCasaAppTheme.fontNameRegular,
                            color: PaLaCasaAppTheme.deepGRAY.withOpacity(0.5),
                            fontSize: 12.0,
                          ),
                          overflow:TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0,right: 0.0,top: 20,bottom: 4),
                            child: RichText(
                              overflow: TextOverflow.fade,
                              maxLines: 1,

                              text: TextSpan(
                                style: TextStyle(
                                    fontFamily:PaLaCasaAppTheme.fontName,
                                    color: PaLaCasaAppTheme.Gray,
                                    fontSize: 30.0
                                ),
                                children: [
                                  TextSpan(
                                    text: "\$230.",
                                  ),
                                  TextSpan(
                                    text: "00",
                                    style: TextStyle(fontSize: 22),

                                  ),

                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0,right: 25.0,top: 20,bottom: 4),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: IconButton(onPressed: (){}, icon: Icon(Icons.remove,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0,top: 0.0,bottom: 0.0,left: 20.0),
                                  child: Text('2',
                                    style: TextStyle(
                                      fontFamily:PaLaCasaAppTheme.fontName,
                                      color: PaLaCasaAppTheme.deepGRAY,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow:TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 1,),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      border: Border.all(color: PaLaCasaAppTheme.Orange)
                                  ),
                                  child: IconButton(onPressed: (){}, icon: Icon(Icons.add,color: PaLaCasaAppTheme.Orange,)),
                                ),


                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0,top: 30.0,bottom: 8.0,left: 25.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Información:',
                                style: TextStyle(
                                  fontFamily:PaLaCasaAppTheme.fontName,
                                  color: PaLaCasaAppTheme.deepGRAY.withOpacity(0.5),
                                  fontSize: 14.0,
                                ),
                                overflow:TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 3,),
                              Text('Puede adjuntar una nota para perfeccionar su pedido ( sin vinagre, poca sal ...)',
                                style: TextStyle(
                                  fontFamily:PaLaCasaAppTheme.fontNameRegular,
                                  color: PaLaCasaAppTheme.deepGRAY.withOpacity(0.5),
                                  fontSize: 12.0,
                                ),
                                overflow:TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 3,),
                              _buildComposer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
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
                        padding: const EdgeInsets.only(right: 20.0,top: 16.0,bottom: 16.0,left: 20.0),
                        child: Center(
                          child: Text('Añadir al carrito',
                            style: TextStyle(
                              fontFamily:PaLaCasaAppTheme.fontName,
                              color: PaLaCasaAppTheme.nearlyWhite,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow:TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 225,
            right: 50,
            left: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                        blurRadius: 20.5,
                        spreadRadius: 5.5,
                        offset: Offset(5, 5),
                      ),
                    ],

                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/fitness_app/star.png'),
                        width: 22.0,
                      ),
                      Text(" 4.8  ",
                        style: TextStyle(
                          fontFamily: 'Poppinss',
                          fontSize: 12,
                          color: PaLaCasaAppTheme.grey,
                        ),)
                    ],
                  ),
                ),
              ],

            ),
          ),
          Positioned(
            top: 225,
            right: 50,
            left: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                        blurRadius: 20.5,
                        spreadRadius: 5.5,
                        offset: Offset(5, 5),
                      ),
                    ],

                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.share,color: PaLaCasaAppTheme.deepGRAY,)),
                      Text(" Compartir      ",
                        style: TextStyle(
                          fontFamily: 'Poppinss',
                          fontSize: 12,
                          color: PaLaCasaAppTheme.grey,
                        ),)
                    ],
                  ),
                ),
              ],

            ),
          ),
          Positioned(
            top:50,
            left:15,
            child: GestureDetector(
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
          ),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: PaLaCasaAppTheme.nearlyWhite,
        borderRadius: BorderRadius.circular(25),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26.withOpacity(0.1),
              offset: const Offset(2, 2),
              blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          constraints: const BoxConstraints(minHeight: 100, maxHeight: 160),
          color: PaLaCasaAppTheme.nearlyWhite,
          child: SingleChildScrollView(
            child: TextField(
              controller:_controllerDescripcion,
              maxLines: null,
              onChanged: (String txt) {},
              style: TextStyle(
                fontFamily: PaLaCasaAppTheme.fontNameRegular,
                fontSize: 16,
                color: PaLaCasaAppTheme.Gray,
              ),
              cursorColor: PaLaCasaAppTheme.Gray,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: PaLaCasaAppTheme.fontNameRegular,
                    fontSize: 16,
                    color: PaLaCasaAppTheme.Gray,
                  ),
                  border: InputBorder.none,
                  prefixIcon:Icon(Icons.description_outlined,color: PaLaCasaAppTheme.Gray,) ,
                  hintText: 'Nota'),
            ),
          ),
        ),
      ),
    );
  }
}
