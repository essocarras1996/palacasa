import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palacasa/HomePage.dart';
import 'package:palacasa/Login&Register/Login.dart';
import 'package:palacasa/database/PaLaCasaDB.dart';
import 'package:http/http.dart' as http;
import 'Helper/color_constant.dart';
import 'PaLaCasaAppHomeScreen.dart';
import 'database/SessionObject.dart';
import 'package:palacasa/jsons/CreateUserJson.dart';
class LoadingDataNetwork extends StatefulWidget {
  const LoadingDataNetwork({Key? key}) : super(key: key);

  @override
  State<LoadingDataNetwork> createState() => _LoadingDataNetworkState();
}

class _LoadingDataNetworkState extends State<LoadingDataNetwork> {


  @override
  void initState() {
    getDB();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Image.asset('assets/fitness_app/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              Center(
                child: Text("Pa' la Casa",
                  style: TextStyle(
                      fontFamily:PaLaCasaAppTheme.fontName,
                      color: PaLaCasaAppTheme.Gray,
                      fontSize: 25.0
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 25.0,left: 25.0),
                  child: Text("Servicio de comida a domicilio y mucho más",
                    style: TextStyle(
                        fontFamily:PaLaCasaAppTheme.fontNameRegular,
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.5),
                        fontSize: 13.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: CircularProgressIndicator(
              color: PaLaCasaAppTheme.Orange,
            ),
          ),
        ],
      ),
    );
  }

  void getDB() async{
    var user = await PaLaCasaDB.instance.readAllSesion();
    if(user.isNotEmpty){
      getPerfil();
    }else{
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ),
              (route) => false
      );
    }
  }

  getPerfil() async {
    print("Entro al request");
    var request = http.MultipartRequest('GET', Uri.parse('https://palacasa.whizzlyshop.com/api/perfil'));
    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("Mando el request");
    if (response.statusCode == 200) {
      String d =await response.stream.bytesToString();
      var a = json.decode(d);
      var userJson = createUserJson.fromJson(a);

      SessionObject session = new SessionObject(
          id: int.parse('${userJson.user!.id}'),
          name: '${userJson.user!.name}',
          lastname: '${userJson.user!.lastname}',
          email: '${userJson.user!.email}',
          phone: '${userJson.user!.phone}',
          photo: '${userJson.user!.photo}',
          id_role: '${userJson.user!.id_role}',
          birthday: '${userJson.user!.birthday}',
          gender: '${userJson.user!.gender}',
          token: token
      );
      await PaLaCasaDB.instance.updateSession(session);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
              (route) => false
      );

    }else if (response.statusCode == 401){
      Fluttertoast.showToast(msg: "Logout",backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      print(401);
    } else {
      Fluttertoast.showToast(msg: "Ha ocurrido un error",backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
      print(response.reasonPhrase);
    }

  }
}
