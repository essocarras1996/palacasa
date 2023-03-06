import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Helper/color_constant.dart';
import 'GoogleSignInApi.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: PaLaCasaAppTheme.Orange.withOpacity(0.2)
                                .withOpacity(0.5),
                            offset: Offset(3.0, 5),
                            blurRadius: 3.0),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child:CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 80,
                          width:80,
                          imageUrl: 'https://play-lh.googleusercontent.com/ukx-YgnZIsDgIX6s__8Ont11r5OzMvBNGS8PwO_NUR0FmXNSPkYoCm8DCncjaXbSPw',
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
                child: Text("Login",
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
                        icon: Icon(Icons.visibility_off,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                        onPressed: null,
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
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: PaLaCasaAppTheme.Orange,
                            borderRadius: BorderRadius.circular(35.0)
                          ),
                          child: Text(
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
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      maxRadius: 20.0,
                      child: Image(
                        image: AssetImage('assets/fitness_app/facebook.png'),
                        width: 50.0,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          await GoogleSignInApi.login();
                        } catch (error) {
                          print(error);
                        }
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
      ),
    );
  }
}
