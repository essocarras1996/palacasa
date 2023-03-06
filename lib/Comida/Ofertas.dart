import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palacasa/Helper/color_constant.dart';

import '../Cart/Cart.dart';
import '../Helper/ItemsFood.dart';
import '../my_flutter_app_icons.dart';
import 'OfertDetails.dart';

class Ofertas extends StatefulWidget {
  const Ofertas({Key? key}) : super(key: key);

  @override
  State<Ofertas> createState() => _OfertasState();
}

class _OfertasState extends State<Ofertas> {


  final ScrollController _controller = ScrollController();
  late List<String> items=['Hamburguesas','Pizzas','Tapas', 'Dulces','Bebidas'];
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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: PaLaCasaAppTheme.background,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),),
                  boxShadow: [
                    BoxShadow(
                      color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                      blurRadius: 5.5,
                      spreadRadius: 5.5,
                      offset: Offset(3, 2),
                    )
                  ]
              ),
              child: Column(
                children: [
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
                          child: Text("McDonald's",
                            style: TextStyle(
                                fontFamily: PaLaCasaAppTheme.fontName,
                                fontSize: 20,
                                color: PaLaCasaAppTheme.Gray
                            ),),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Cart();
                                },
                              ),
                            );
                          },
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
                                          '0',
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
                  Container(
                    height: 60,

                    child: ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            _controller.animateTo(
                              230+(index*2)*180,//3 es la cantidad de elementos en la categoria seleccionada
                              duration: Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn,
                            );
                             setState(() {

                             });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 10),
                            child: Container(

                              decoration: BoxDecoration(
                                  color: index==0?PaLaCasaAppTheme.Orange:PaLaCasaAppTheme.Gray.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(18.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: index==0?PaLaCasaAppTheme.Orange.withOpacity(0.2):PaLaCasaAppTheme.grey.withOpacity(0.2),
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 8.0
                                    )
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12,right: 15.0,left: 15.0),
                                child: Text(items[index],
                                  style: TextStyle(
                                    fontFamily: PaLaCasaAppTheme.fontName,
                                    color: PaLaCasaAppTheme.nearlyWhite,
                                  ),),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ),
          Expanded(
            flex: 7,
            child: ListView(
              controller: _controller,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                  width:MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.0,right: 25.0,bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Especialidades:",
                          style: TextStyle(
                              fontFamily: PaLaCasaAppTheme.fontName,
                              fontSize: 12,
                              color: PaLaCasaAppTheme.Gray
                          ),),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Cafetería Especializada en Comida Rápida, ofertamos ricas Pizzas y sabrosas Hamburguesas",
                            style: TextStyle(
                                fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                fontSize: 12,
                                color: PaLaCasaAppTheme.Gray
                            ),
                            textAlign: TextAlign.justify,),
                        ),
                        Text("Horario:",
                          style: TextStyle(
                              fontFamily: PaLaCasaAppTheme.fontName,
                              fontSize: 12,
                              color: PaLaCasaAppTheme.Gray
                          ),),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0,right: 2.0,left: 2.0),
                          child: Text("Todos los días",
                            style: TextStyle(
                                fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                fontSize: 12,
                                color: PaLaCasaAppTheme.Gray
                            ),
                            textAlign: TextAlign.justify,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0,right: 2.0),
                          child: Text("9:00 AM - 11:00 PM",
                            style: TextStyle(
                                fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                fontSize: 12,
                                color: PaLaCasaAppTheme.Gray
                            ),
                            textAlign: TextAlign.justify,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0,right: 2.0),
                          child: Text("Acepta Reservas",
                            style: TextStyle(
                                fontFamily: PaLaCasaAppTheme.fontNameRegular,
                                fontSize: 12,
                                color: PaLaCasaAppTheme.Gray
                            ),
                            textAlign: TextAlign.justify,),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  physics: ClampingScrollPhysics(),

                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 25.0,right:25.0,top: 0),
                          child: Text(items[index],
                            style: TextStyle(
                                fontFamily: PaLaCasaAppTheme.fontName,
                                fontSize: 18,
                                color: PaLaCasaAppTheme.Gray
                            ),),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return OfertDetails();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15.0,left: 15.0,top: 10.0,bottom: 10),
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
                                child: Column(
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
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
