import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Helper/color_constant.dart';
import '../Helper/search_form.dart';
import '../my_flutter_app_icons.dart';
import 'RestaurantScreen.dart';

class TypeFood extends StatefulWidget {
  const TypeFood({Key? key}) : super(key: key);

  @override
  State<TypeFood> createState() => _TypeFoodState();
}

class _TypeFoodState extends State<TypeFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: SafeArea(
        child:
        Column(
          children: [
            Row(
              children: [
                Container(
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
                    title: Text("Comida Asiática",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal:25),
              child: SearchForm(name: 'Buscar',onSearch: _onSearch,),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 80.0),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.vertical,
                itemCount: 8,
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
                                        child: Text("McDonald's",
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
                                  IconButton(onPressed: (){}, icon: Icon(MyFlutterApp.heart_empty,color: Colors.red,size: 20,))
                                ],
                              ),
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
      ),
    );
  }
  String _searchText = '';
  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });
    print('Texto ingresado: $_searchText');
  }
}
