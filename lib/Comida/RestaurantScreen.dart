import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palacasa/my_flutter_app_icons.dart';

import '../Helper/color_constant.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  
  List<String> items=['Hamburguesas','Pizzas','Tapas', 'Dulces','Bebidas'];

  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PaLaCasaAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Stack(
              children: [


                Positioned(
                  top:0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                    child:CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 300,
                        width:MediaQuery.of(context).size.width,
                        imageUrl: 'https://tb-static.uber.com/prod/image-proc/processed_images/580d59348bc7873923449bb8e7ee8391/357bb8cd86dabbaef837e6fb8fd17922.jpeg',
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
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 235,
                        ),

                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child:
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 240,
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
                                    blurColor: Colors.white,
                                    child: Center(),
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  top: 30,
                                  left: MediaQuery.of(context).size.width-100,
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: PaLaCasaAppTheme.Orange,
                                            borderRadius: BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                color: PaLaCasaAppTheme.Orange.withOpacity(0.2),
                                                blurRadius: 2.5,
                                                spreadRadius: 2.5,
                                                offset: Offset(0, 1),
                                              )
                                            ]
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: PaLaCasaAppTheme.Orange,
                                          maxRadius: 25,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(25),
                                            child:Icon(MyFlutterApp.heart,color: Colors.white,size: 22,),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                                        child: Text("Avenida 25 e/ San Nicolás y San Carlos, Cienfuegos",
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily:PaLaCasaAppTheme.fontNameRegular,
                                              color: PaLaCasaAppTheme.grey.withOpacity(0.5),
                                              fontSize: 14.0
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                                  fontSize: 12,
                                                  color: PaLaCasaAppTheme.grey,
                                                ),)
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30.0,
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
                                                  fontSize: 12,
                                                  color: PaLaCasaAppTheme.grey,
                                                ),)
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30.0,
                                          ),
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage('assets/fitness_app/delivery.png'),
                                                width: 30.0,
                                              ),
                                              Text(" Gratis",
                                                style: TextStyle(
                                                  fontFamily: 'Poppinss',
                                                  fontSize: 12,
                                                  color: PaLaCasaAppTheme.grey,
                                                ),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: PaLaCasaAppTheme.grey.withOpacity(0.05),
                                                borderRadius: BorderRadius.circular(15)

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                              child: Text("Hamburguesas",
                                                style: TextStyle(
                                                  fontFamily: 'Poppinss',
                                                  fontSize: 10,
                                                  color: PaLaCasaAppTheme.grey,
                                                ),),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 17.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: PaLaCasaAppTheme.grey.withOpacity(0.05),
                                                borderRadius: BorderRadius.circular(15)

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                              child: Text("Pizzas",
                                                style: TextStyle(
                                                  fontFamily: 'Poppinss',
                                                  fontSize: 10,
                                                  color: PaLaCasaAppTheme.grey,
                                                ),),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 17.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: PaLaCasaAppTheme.grey.withOpacity(0.05),
                                                borderRadius: BorderRadius.circular(15)

                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                              child: Text("Comida Rápida",
                                                style: TextStyle(
                                                  fontFamily: 'Poppinss',
                                                  fontSize: 10,
                                                  color: PaLaCasaAppTheme.grey,
                                                ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                              ],
                            ),

                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10,right: 90,left: 90),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: PaLaCasaAppTheme.Orange,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: PaLaCasaAppTheme.Orange.withOpacity(0.2)
                                              .withOpacity(0.1),
                                          offset: Offset(3.0, 5),
                                          blurRadius: 3.0),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20,left: 20,top: 15,bottom: 10),
                                    child: Center(
                                      child: Text('Ofertas',style: TextStyle(
                                        fontFamily: PaLaCasaAppTheme.fontName,
                                        color: PaLaCasaAppTheme.white,
                                      )
                                      ),
                                    ),
                                  ),
                                ),
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
                                  height: 170,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics()),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (){

                                        },
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width/2,
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
                                                              height: 145,
                                                              width:MediaQuery.of(context).size.width/2,
                                                              imageUrl: index==0?'https://www.verdictfoodservice.com/wp-content/uploads/sites/17/2019/04/McDonalds.png':'https://imageproxy.wolt.com/venue/61de9388adf9fa53f6e03e13/a51fc310-cc7a-11ec-818d-1611eb149b6d_mcd_hero_banner_1440x810_wolt__1_.png',
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
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Stack(
                                                    children:[
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: PaLaCasaAppTheme.Orange,
                                                            borderRadius: BorderRadius.circular(20.0)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 4,bottom: 4),
                                                          child: RichText(
                                                            overflow: TextOverflow.fade,
                                                            maxLines: 1,

                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                  fontFamily:PaLaCasaAppTheme.fontName,
                                                                  color: PaLaCasaAppTheme.nearlyWhite,
                                                                  fontSize: 15.0
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: index==0?"\$230.":"\$200.",
                                                                ),
                                                                TextSpan(
                                                                  text: "00",
                                                                  style: TextStyle(fontSize: 12),

                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                      ),


                                                    ]

                                                ),
                                              ),




                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top:40,
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
                              color: PaLaCasaAppTheme.nearlyBlack
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
                              blurColor: Colors.white,
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

          ],

        ),
      ),
    );
  }
}
