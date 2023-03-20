import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palacasa/Helper/DrawerItem.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:palacasa/database/PaLaCasaDB.dart';
import 'package:palacasa/database/SessionObject.dart';
import 'package:palacasa/jsons/User.dart';

import '../PaLaCasaAppHomeScreen.dart';

class HiddenDrawer extends StatefulWidget {
  final Function(int) menuCallBack;
  const HiddenDrawer({Key? key,required this.menuCallBack}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  late SessionObject user;
  bool load=true;
  int selectedMenuIndex = 0;

  late List<String> menuItems=[];

  late List<String> icons=[];


  @override
  void initState() {
    getDB();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return load?Center():Container(
      color: PaLaCasaAppTheme.nearlyWhite,
      padding: EdgeInsets.only(top: 50,bottom: 70,left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Padding(
           padding: EdgeInsets.only(left: 0),
           child: Row(
             children: [
               CircleAvatar(
                 maxRadius: 35,
                 backgroundColor: PaLaCasaAppTheme.Orange,
                 child: CachedNetworkImage(
                     fit: BoxFit.cover,
                     imageUrl: user.photo,
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
               SizedBox(
                 width: 10,
               ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     user.name+" "+user.lastname,
                     style: TextStyle(fontFamily:PaLaCasaAppTheme.fontName,fontSize: 15, color: PaLaCasaAppTheme.grey),
                   ),
                   Text(
                     user.email,
                     style: TextStyle(fontFamily:PaLaCasaAppTheme.fontNameRegular,fontSize: 10, color: PaLaCasaAppTheme.grey),
                   ),
                 ],
               ),

             ],
           ),
         ),
          Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: menuItems
              .asMap()
              .entries
              .map((mapEntry) => buildMenuRow(mapEntry.key))
              .toList(),
          ),
         Center()
        ],
      ),
    );
  }

  Widget buildMenuRow(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedMenuIndex = index;
          widget.menuCallBack(index);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(icons[index],
                color: selectedMenuIndex == index
                ? PaLaCasaAppTheme.Gray
                    : PaLaCasaAppTheme.Gray.withOpacity(0.5),
              height: 25),
            SizedBox(
              width: 16.0,
            ),
            Text(
              menuItems[index],
              style: TextStyle(
                color: selectedMenuIndex == index
                    ? PaLaCasaAppTheme.Gray
                    : PaLaCasaAppTheme.Gray.withOpacity(0.5),
                fontFamily: selectedMenuIndex == index
                    ? PaLaCasaAppTheme.fontName
                    :PaLaCasaAppTheme.fontNameRegular,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getDB() async{
    var db = await PaLaCasaDB.instance.readAllSesion();
    user = db!.first!;
    load=false;
    switch(int.parse(user.id_role)){
      case 1:{
        icons =drawerItemAdmin.map((e) => e['icon'].toString()).toList();
        menuItems =drawerItemAdmin.map((e) => e['title'].toString()).toList();
        break;
      }
      case 2:{
        icons =drawerItemManager.map((e) => e['icon'].toString()).toList();
        menuItems =drawerItemManager.map((e) => e['title'].toString()).toList();
        break;
      }
      case 3:{
        icons =drawerItem.map((e) => e['icon'].toString()).toList();
        menuItems =drawerItem.map((e) => e['title'].toString()).toList();
        break;
      }
    }

    setState(() {

    });
  }
}
