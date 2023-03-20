
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palacasa/Helper/color_constant.dart';

import '../../my_flutter_app_icons.dart';


class Usuarios extends StatefulWidget {
  final VoidCallback menuCallBack;
  const Usuarios({Key? key, required this.menuCallBack}) : super(key: key);

  @override
  State<Usuarios> createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
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
                    leading: IconButton(
                      onPressed: widget.menuCallBack,
                      icon: SvgPicture.asset("assets/icons/paragraph.svg",color: PaLaCasaAppTheme.deepGRAY),
                    ),
                    title: Text("Usuarios",style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
