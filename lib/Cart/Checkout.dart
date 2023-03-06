import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/color_constant.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  int group=0;

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
                          child: Text("Checkout",
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
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0,top: 30,right: 25.0),
                            child: Text("Costo de Envío",
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
                                padding: const EdgeInsets.only(right: 25.0,top: 30),
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
                                        text: "\$100.",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0,top: 10,right: 25.0),
                            child: Text("Subtotal",
                              style: TextStyle(
                                  fontFamily: PaLaCasaAppTheme.fontName,
                                  fontSize: 15,
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
                                padding: const EdgeInsets.only(right: 25.0,top: 10),
                                child: RichText(
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,

                                  text: TextSpan(
                                    style: TextStyle(
                                        fontFamily:PaLaCasaAppTheme.fontName,
                                        color: PaLaCasaAppTheme.Gray,
                                        fontSize: 15.0
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "\$860.",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      TextSpan(
                                        text: "00",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      TextSpan(
                                        text: " CUP",
                                        style: TextStyle(fontSize: 15),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0,top: 10,right: 25.0),
                            child: Text("Total",
                              style: TextStyle(
                                  fontFamily: PaLaCasaAppTheme.fontName,
                                  fontSize: 17,
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
                                padding: const EdgeInsets.only(right: 25.0,top: 10),
                                child: RichText(
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,

                                  text: TextSpan(
                                    style: TextStyle(
                                        fontFamily:PaLaCasaAppTheme.fontName,
                                        color: PaLaCasaAppTheme.Gray,
                                        fontSize: 17.0
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "\$960.",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      TextSpan(
                                        text: "00",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      TextSpan(
                                        text: " CUP",
                                        style: TextStyle(fontSize: 17),
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

            Positioned(
              top: 90,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0,top: 16.0,bottom: 16.0,left: 20.0),
                      child: Center(
                        child: Text('Enviar a',
                          style: TextStyle(
                            fontFamily:PaLaCasaAppTheme.fontName,
                            color: PaLaCasaAppTheme.Gray,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow:TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 210,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50,left: 8.0,right: 8.0,top: 8.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: 280,
                                  height: 190,
                                  decoration: BoxDecoration(
                                    color: PaLaCasaAppTheme.nearlyWhite,
                                    borderRadius: BorderRadius.circular(35.0),
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
                                        print(value);
                                        group=index;
                                      });
                                    }),
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 22.0),
                                      child: Text('Home',
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
                                                child: Text('+53 5 447 1038',
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
                                              Icon(Icons.map,size: 15,),
                                              Container(
                                                width: 140,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 15.0,top: 10),
                                                  child: Text('Juan Franco 58 e/ David Díaz y Feliberto Arcia',
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
                                          )
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
                                        child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 15,color: PaLaCasaAppTheme.nearlyWhite,)))),

                              ],

                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0,top: 0.0,bottom: 0.0,left: 25.0),
                      child: Center(
                        child: Text('Método de Pago',
                          style: TextStyle(
                            fontFamily:PaLaCasaAppTheme.fontName,
                            color: PaLaCasaAppTheme.Gray,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow:TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: 3,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              group=index;
                              setState(() {

                              });
                            },
                            child: ListTile(
                              trailing: Radio(value: index,activeColor: PaLaCasaAppTheme.Orange, groupValue: group, onChanged: (value){
                                setState(() {
                                  print(value);
                                  group=index;
                                });
                              }),
                              title: Text('Efectivo',
                                style: TextStyle(
                                    fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                    color: PaLaCasaAppTheme.Gray,
                                    fontSize: 14.0
                                ),
                              ),
                            ),
                          ) ;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
