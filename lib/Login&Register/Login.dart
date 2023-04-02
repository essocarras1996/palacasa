import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:palacasa/database/PaLaCasaDB.dart';
import 'package:palacasa/database/SessionObject.dart';
import 'package:palacasa/jsons/CreateUserJson.dart';
import 'package:flutter_svg/svg.dart';
import '../Helper/color_constant.dart';
import 'package:palacasa/my_flutter_app_icons.dart';
import '../HomePage.dart';
import 'CompleteProfile.dart';
import 'GoogleSignInApi.dart';
import 'package:http/http.dart' as http;
import '../PaLaCasaAppHomeScreen.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loginUser= true;
  var _controllerName = TextEditingController();
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _controllerUser = TextEditingController();
  var _controllerPasswordLogin = TextEditingController();
  bool showPassword = true;
  bool showPassword1 = true;
  bool setRequest=false;

  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  @override
  void initState() {
    getUserDB();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: loginUser?SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Padding(
                padding: EdgeInsets.only(right: 25,left: 25,top: 50),
                child: Text("Autenticar",
                  style: TextStyle(
                      fontFamily:PaLaCasaAppTheme.fontName,
                      color: PaLaCasaAppTheme.Gray,
                      fontSize: 25.0
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0,left: 25.0),
                child: Text("Introduce su usuario y contraseña.",
                  style: TextStyle(
                      fontFamily:PaLaCasaAppTheme.fontNameRegular,
                      color: PaLaCasaAppTheme.Gray.withOpacity(0.5),
                      fontSize: 13.0
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                child:  TextFormField(
                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                  cursorColor: PaLaCasaAppTheme.Orange,
                  controller: _controllerUser,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                      child: Container(
                        width: 70,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.email,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                onPressed: null,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: VerticalDivider(
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 0.0),
                child:  TextFormField(
                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                  cursorColor: PaLaCasaAppTheme.Orange,
                  controller: _controllerPasswordLogin,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                      child: Container(
                        width: 70,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.key,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                onPressed: null,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: VerticalDivider(
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                      child:  IconButton(
                        icon: Icon(showPassword?Icons.visibility_rounded:Icons.visibility_off,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                        onPressed: (){
                          setState(() {
                            showPassword=!showPassword;
                          });
                        },
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(right: 35,left: 35,top: 8),
                  child: Text("¿Olvidó su contraseña?",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontFamily:PaLaCasaAppTheme.fontName,
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                        fontSize: 13.0
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35.0,horizontal: 35.0),
                child: Row(

                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                         String user = _controllerUser.text;
                         String password =_controllerPasswordLogin.text;
                         if(user.isEmpty||password.isEmpty){
                           Fluttertoast.showToast(msg: 'Rellene los espacios en blanco',gravity: ToastGravity.BOTTOM,backgroundColor: Colors.grey);
                         }else if (user.contains("@")){
                           if(!setRequest)login(user, password);
                         }else{
                           Fluttertoast.showToast(msg: 'Email incorrecto',gravity: ToastGravity.BOTTOM,backgroundColor: Colors.grey);
                         }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: setRequest?14:20.0, bottom: setRequest?14:20.0),
                          decoration: BoxDecoration(
                              color: PaLaCasaAppTheme.Orange,
                              borderRadius: BorderRadius.circular(35.0)
                          ),
                          child: setRequest?Center(child: CircularProgressIndicator(color: PaLaCasaAppTheme.nearlyWhite,strokeWidth: 2,)):Text(
                            "Autenticar".toUpperCase(),
                            style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: RichText(
                  overflow: TextOverflow.fade,
                  maxLines: 1,

                  text: TextSpan(
                    style: TextStyle(
                        fontFamily:PaLaCasaAppTheme.fontName,
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                        fontSize: 15.0
                    ),
                    children: [
                      TextSpan(
                        text:"¿No tienes cuenta?",
                      ),
                      TextSpan(
                        text: " Registrar",
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              loginUser = false;
                            });
                          },
                        style: TextStyle(
                            color: PaLaCasaAppTheme.Orange
                        ),

                      ),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( left: 55.0,right: 55.0,top: 10.0,bottom: 10.0),
                child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                            thickness: 1,
                          )
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 15,left: 15),
                        child: Text("O",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily:PaLaCasaAppTheme.fontName,
                              color: PaLaCasaAppTheme.Gray.withOpacity(0.5),
                              fontSize: 15.0
                          ),
                        ),
                      ),

                      Expanded(
                          child: Divider(
                            thickness: 1,
                          )
                      ),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:(){
                        FacebookAuth.instance.login(
                            permissions: ["email"]
                        ).then((value) {
                          FacebookAuth.instance.getUserData().then((userData) {
                            print(userData);
                          });
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        maxRadius: 20.0,
                        child: Image(
                          image: AssetImage('assets/fitness_app/facebook.png'),
                          width: 50.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        try{
                          _googleSignIn.disconnect();
                        }catch(s){}
                        
                        //try {
                          var user = await _googleSignIn.signIn();
                          String photo="";
                          try{
                            photo=user!.photoUrl!;
                          }catch(a){}
                          register(user!.email!,'mnbvcxzasdfghjkl',photo, user!.displayName!);
                        /*} catch (error) {
                          print(error);
                        }*/
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 20.0,
                        child: Image(
                          image: AssetImage('assets/fitness_app/google.png'),
                          width: 50.0,
                        ),
                      ),
                    ),
                  ],
                ),
              )


            ],
          ),
        ),
      ):SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Padding(
                padding: EdgeInsets.only(right: 25,left: 25,top: 50),
                child: Text("Registrar",
                  style: TextStyle(
                      fontFamily:PaLaCasaAppTheme.fontName,
                      color: PaLaCasaAppTheme.Gray,
                      fontSize: 25.0
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0,left: 25.0),
                child: Text("Introduce su nombre, usuario y contraseña.",
                  style: TextStyle(
                      fontFamily:PaLaCasaAppTheme.fontNameRegular,
                      color: PaLaCasaAppTheme.Gray.withOpacity(0.5),
                      fontSize: 13.0
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25,right: 25,left: 25),
                child:  TextFormField(
                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                  cursorColor: PaLaCasaAppTheme.Orange,
                  controller: _controllerName,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                      child: Container(
                        width: 70,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(MyFlutterApp.user,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                onPressed: null,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: VerticalDivider(
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Nombre',
                    hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                child:  TextFormField(
                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                  cursorColor: PaLaCasaAppTheme.Orange,
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                      child: Container(
                        width: 70,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.email,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                onPressed: null,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: VerticalDivider(
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 0.0),
                child:  TextFormField(
                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                  cursorColor: PaLaCasaAppTheme.Orange,
                  controller: _controllerPassword,
                  obscureText: showPassword1,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                      child: Container(
                        width: 70,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.key,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                onPressed: null,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: VerticalDivider(
                                  color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                      child:  IconButton(
                        icon: Icon(showPassword1?Icons.visibility_rounded:Icons.visibility_off,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                        onPressed: (){
                          setState(() {
                            showPassword1=!showPassword1;
                          });
                        },
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 45.0,horizontal: 35.0),
                child: Row(

                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          String name = _controllerName.text;
                          String email = _controllerEmail.text;
                          String password = _controllerPassword.text;

                          if(name.isEmpty||email.isEmpty||password.isEmpty){
                            Fluttertoast.showToast(msg: 'Rellene los espacios en blanco',gravity: ToastGravity.BOTTOM,backgroundColor: Colors.grey);
                          }else if(email.contains("@")){
                            register(email,password,'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Photos.png', name);
                          }
                          else{
                            Fluttertoast.showToast(msg: 'El email no es correcto',gravity: ToastGravity.BOTTOM,backgroundColor: Colors.grey);

                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                              color: PaLaCasaAppTheme.Orange,
                              borderRadius: BorderRadius.circular(35.0)
                          ),
                          child: Text(
                            "Registrar".toUpperCase(),
                            style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: RichText(
                  overflow: TextOverflow.fade,
                  maxLines: 1,

                  text: TextSpan(
                    style: TextStyle(
                        fontFamily:PaLaCasaAppTheme.fontName,
                        color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                        fontSize: 15.0
                    ),
                    children: [
                      TextSpan(
                        text:"¿No tienes cuenta?",
                      ),
                      TextSpan(
                        text: " Autenticar",
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              loginUser = true;
                            });
                          },
                        style: TextStyle(
                            color: PaLaCasaAppTheme.Orange
                        ),

                      ),

                    ],
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }

  login(String email,String password) async {
    setState(() {
      setRequest= true;
    });
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/login'));
    request.fields.addAll({
      'email': email,
      'password': password
    });

try{
  http.StreamedResponse response = await request.send();
  print("Mando el request");
  if (response.statusCode == 200) {
    setState(() {
      setRequest= false;
    });
    try{
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
          token: userJson.token!
      );
      await PaLaCasaDB.instance.createSession(session);

      if('${userJson.user!.phone}'.length==10){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
              (route) => false,
        );
      }else{
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CompleteProfile(displayName:userJson.user!.name!,urlPhoto:userJson.user!.photo==null?'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Photos.png':userJson.user!.photo!,);
            },
          ),
              (route) => false,
        );
      }


    }catch(e){
      Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
    }

  }else if (response.statusCode == 401){
    setState(() {
      setRequest= false;
    });
    Fluttertoast.showToast(msg: "Credenciales no válidas",backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
    print(401);
  } else {
    setState(() {
      setRequest= false;
    });
    Fluttertoast.showToast(msg: response.reasonPhrase!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
  }
}catch(error){
  Fluttertoast.showToast(msg: error.toString(),backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
  setState(() {
    setRequest= false;
  });
}


  }
  register(String email,String password, String photo, String name) async {
    print("Entro al request");
    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/register'));
    request.fields.addAll({
      'email': email,
      'password': password,
      'photo': photo,
      'name': name
    });


    http.StreamedResponse response = await request.send();
    print("Mando el request");
    if (response.statusCode == 200) {
      //try{
      String d =await response.stream.bytesToString();
      var a = json.decode(d);
      var userJson = createUserJson.fromJson(a);
      print(userJson.user!.email!);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CompleteProfile(displayName:userJson.user!.name!,urlPhoto:userJson.user!.photo==null?'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Photos.png':userJson.user!.photo!,);
          },
        ),
            (route) => false,
      );
      /*}catch(e){
        
      }*/

    }else if (response.statusCode == 401){
      try{
        _googleSignIn.disconnect();
      }catch(a){}

      print(401);
    } else {
      print(response.reasonPhrase);
    }

  }

  void getUserDB() async{
    var db=await PaLaCasaDB.instance.readAllSesion();
    if(db.isNotEmpty){
      SessionObject sessionObject =db.first;
      print(sessionObject.phone);
      if('${sessionObject.phone}'.length==10){
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PaLaCasaAppHomeScreen();
            },
          ),
        );*/
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CompleteProfile(displayName:sessionObject.name!,urlPhoto:sessionObject.photo==null?'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Photos.png':sessionObject.photo!,);
            },
          ),
        );
      }
    }


  }
}
