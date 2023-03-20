import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Helper/color_constant.dart';

class BaresScreen extends StatefulWidget {
  final VoidCallback menuCallBack;
  const BaresScreen({Key? key, required this.menuCallBack}) : super(key: key);

  @override
  State<BaresScreen> createState() => _BaresScreenState();
}

class _BaresScreenState extends State<BaresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ListTile(
                                leading: IconButton(
                                  onPressed: widget.menuCallBack,
                                  icon: SvgPicture.asset("assets/icons/paragraph.svg",color: PaLaCasaAppTheme.deepGRAY),
                                ),
                                title: Text("Bares",style: TextStyle(fontFamily: 'Poppinss',fontWeight: FontWeight.bold,fontSize: 18),),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
                            child: Text(
                              "Busca",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontFamily:'Poppinss',fontWeight: FontWeight.w500, color: PaLaCasaAppTheme.grey,fontSize: 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16,right: 16),
                            child: Text(
                              "los mejores Bares para compartir con amigos",
                              style: TextStyle(fontFamily:'Poppinsr',fontSize: 15, color: PaLaCasaAppTheme.grey),
                            ),
                          ),



                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }


  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
