import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palacasa/Cart/Checkout.dart';
import 'package:palacasa/Helper/color_constant.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: Stack(
        children: [
          Column(
            children: [
              Column(children: [
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding: const EdgeInsets.only(left: 15.0,top: 5),
                        child: Text("Mi Carrito",
                          style: TextStyle(
                              fontFamily: PaLaCasaAppTheme.fontName,
                              fontSize: 20,
                              color: PaLaCasaAppTheme.Gray
                          ),),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.shopping_bag_outlined,
                                        color: PaLaCasaAppTheme.Gray,
                                        size: 27,
                                      ),
                                      onPressed: () async {
                                      }),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 22, top: 3.0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.5, horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: PaLaCasaAppTheme.Orange.withOpacity(0.8),
                                  ),
                                  child: Center(
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500),
                                      )
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],),

              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.vertical,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){

                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 15.0,left: 15.0,bottom: 15),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                                  blurRadius: 20.5,
                                  spreadRadius: 0.5,
                                  offset: Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(30.0),
                                          child:CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width:150,
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
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 20.0,top: 8.0,bottom: 2.0,left: 20.0),
                                                child: Text('Combo McBigBurger',
                                                  style: TextStyle(
                                                    fontFamily:PaLaCasaAppTheme.fontName,
                                                    color: PaLaCasaAppTheme.deepGRAY,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 2,),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 20.0,top: 0.0,bottom: 8.0,left: 20.0),
                                                child: Text('Dos Hamburguesas de cerdo con Queso Gouda y Vegetales, más batido de helado',
                                                  style: TextStyle(
                                                    fontFamily:PaLaCasaAppTheme.fontNameRegular,
                                                    color: PaLaCasaAppTheme.deepGRAY.withOpacity(0.5),
                                                    fontSize: 10.0,
                                                  ),
                                                  overflow:TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 3,),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(right: 20.0,top: 0.0,bottom: 8.0,left: 20.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [

                                                    Row(
                                                      children: [
                                                        Container(
                                                          width:35,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(25.0),
                                                              border: Border.all(color: Colors.black)
                                                          ),
                                                          child: IconButton(onPressed: (){}, icon: Icon(Icons.remove, size: 15,)),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 10.0,top: 0.0,bottom: 0.0,left: 10.0),
                                                          child: Text('2',
                                                            style: TextStyle(
                                                              fontFamily:PaLaCasaAppTheme.fontName,
                                                              color: PaLaCasaAppTheme.deepGRAY,
                                                              fontSize: 12.0,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                            overflow:TextOverflow.ellipsis,
                                                            softWrap: true,
                                                            maxLines: 1,),
                                                        ),
                                                        Container(
                                                          width:35,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(25.0),
                                                              border: Border.all(color: PaLaCasaAppTheme.Orange)
                                                          ),
                                                          child: IconButton(onPressed: (){}, icon: Icon(Icons.add,color: PaLaCasaAppTheme.Orange,size: 15,)),
                                                        ),


                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        )
                                      ],

                                    )
                                  ],
                                ),

                              ],

                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 55,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: PaLaCasaAppTheme.Orange,
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 8,bottom: 8),
                                child: RichText(
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,

                                  text: TextSpan(
                                    style: TextStyle(
                                        fontFamily:PaLaCasaAppTheme.fontName,
                                        color: PaLaCasaAppTheme.nearlyWhite,
                                        fontSize: 13.0
                                    ),
                                    children: [
                                      TextSpan(
                                        text: index==0?"\$230.":"\$200.",
                                      ),
                                      TextSpan(
                                        text: "00",
                                        style: TextStyle(fontSize: 11),

                                      ),

                                    ],
                                  ),
                                ),
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
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                    blurRadius: 20.5,
                    spreadRadius: 5.5,
                    offset: Offset(-5, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex:2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0,top: 20,right: 25.0),
                          child: Text("Posee 4 elementos en su carrito",
                            style: TextStyle(
                                fontFamily: PaLaCasaAppTheme.fontName,
                                fontSize: 14,
                                color: PaLaCasaAppTheme.Gray
                            ),
                          maxLines: 3,),
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 25.0,top: 20),
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
                                      text: "Monto Total:\n",
                                    ),
                                    TextSpan(
                                      text: "\$860.",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    TextSpan(
                                      text: "00",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    TextSpan(
                                      text: " CUP",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Checkout();
                          },
                        ),
                      );
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
                          padding: const EdgeInsets.only(right: 20.0,top: 16.0,bottom: 16.0,left: 20.0),
                          child: Center(
                            child: Text('Checkout',
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
