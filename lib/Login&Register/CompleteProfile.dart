import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palacasa/CustomInputFormatter.dart';
import 'package:palacasa/Helper/color_constant.dart';

import '../Helper/CalendatBirthday.dart';
import '../PaLaCasaAppHomeScreen.dart';
import '../my_flutter_app_icons.dart';

class CompleteProfile extends StatefulWidget {
  final String displayName;
  final String urlPhoto;
  const CompleteProfile({Key? key, required this.displayName, required this.urlPhoto}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState(displayName,urlPhoto);
}

class _CompleteProfileState extends State<CompleteProfile> {
  final String displayName;
  final String urlPhoto;
  late TextEditingController _controllerFirstName = new TextEditingController();
  late TextEditingController _controllerLastName= new TextEditingController();
  late TextEditingController _controllerBirthday= new TextEditingController();
  late TextEditingController _controllerGender= new TextEditingController();
  late TextEditingController _controllerPhone= new TextEditingController();
  var sexoItems=['Sexo','Masculino','Femenino'];
  String valueSexo ='Sexo';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));
  DateTime startDates = DateTime.now();
  DateTime endDates = DateTime.now().add(const Duration(days: 7));

  _CompleteProfileState(this.displayName,this.urlPhoto);

  @override
  void initState() {
    _controllerFirstName.text = displayName.split(" ").first;
    _controllerLastName.text = displayName.replaceAll(_controllerFirstName.text+" ", "");
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(75.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.1)
                                    .withOpacity(0.5),
                                offset: Offset(3.0, 5),
                                blurRadius: 15.0),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75.0),
                          child:CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 120,
                              width:120,
                              imageUrl: urlPhoto,
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
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: PaLaCasaAppTheme.Orange,
                          borderRadius: BorderRadius.circular(35)
                        ),
                        child: IconButton(onPressed: () {

                        }, icon: Icon(Icons.camera,color: PaLaCasaAppTheme.nearlyWhite,size: 30,)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35.0,left: 35.0,top: 25.0),
                child: Text("Completar Datos",
                  style: TextStyle(
                      fontFamily:PaLaCasaAppTheme.fontName,
                      color: PaLaCasaAppTheme.Gray,
                      fontSize: 16.0
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35.0,left: 35.0,top: 25.0),
                child: Text("Nombre",
                  style: TextStyle(
                      fontFamily:PaLaCasaAppTheme.fontName,
                      color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,right: 25,left: 25),
                child:  TextFormField(
                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                  cursorColor: PaLaCasaAppTheme.Orange,
                  controller: _controllerFirstName,
                  keyboardType: TextInputType.name,
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
                padding: const EdgeInsets.only(right: 35.0,left: 35.0,top: 8.0),
                child: Text("Apellidos",
                  style: TextStyle(
                      fontFamily:PaLaCasaAppTheme.fontName,
                      color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,right: 25,left: 25),
                child:  TextFormField(
                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                  cursorColor: PaLaCasaAppTheme.Orange,
                  controller: _controllerLastName,
                  keyboardType: TextInputType.name,
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
                    hintText: 'Apellidos',
                    hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35.0,left: 35.0,top: 8.0),
                child: Text("Teléfono",
                  style: TextStyle(
                      fontFamily:PaLaCasaAppTheme.fontName,
                      color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,right: 25,left: 25),
                child:  TextFormField(
                  style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                  cursorColor: PaLaCasaAppTheme.Orange,
                  controller: _controllerPhone,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    new LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    new CustomInputFormatter()
                  ],
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                      child: Container(
                        width: 70,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.phone,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
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
                    prefix: Text('+53 ',style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),fontSize: 15),),
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
                    hintText: 'Teléfono',
                    hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0,left: 35.0,top: 8.0),
                          child: Text("Sexo",
                            style: TextStyle(
                                fontFamily:PaLaCasaAppTheme.fontName,
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                                fontSize: 14.0
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,left: 25),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color:PaLaCasaAppTheme.Gray.withOpacity(0.3),width: 1.0 )

                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0,left: 12.0,top: 6,bottom: 6),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    icon: Icon(Icons.arrow_drop_down,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                    value: valueSexo,
                                    style: TextStyle(color: Colors.black38, fontSize: 16,),
                                    underline: Container(
                                      height: 1,
                                      color: PaLaCasaAppTheme.Gray.withOpacity(0.5),
                                    ),
                                    items: sexoItems.map(buildMenuItem).toList(),
                                    onChanged: (value) async{
                                      this.valueSexo = value!;
                                      setState(() {
                                      });
                                    }

                                ),
                              ),
                            ),

                          ),
                        )
                  ],)),
                  Expanded(
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 8),
                          child: Text("Fecha Nacimiento",
                            style: TextStyle(
                                fontFamily:PaLaCasaAppTheme.fontName,
                                color: PaLaCasaAppTheme.Gray.withOpacity(0.7),
                                fontSize: 14.0
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showCalendarBirthday(context: context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5,right: 25,left: 0),
                            child:  TextFormField(
                              style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                              cursorColor: PaLaCasaAppTheme.Orange,
                              controller: _controllerBirthday,
                              enabled: false,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: BorderSide(
                                    color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_month,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                                  onPressed: null,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: BorderSide(
                                    color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: InputBorder.none,
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: BorderSide(
                                    color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                                  ),
                                ),
                                focusedErrorBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: 'DD/MM/YYYY',
                                hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 12),

                              ),
                            ),
                          ),
                        ),
                      ],))
                ],
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PaLaCasaAppHomeScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                              color: PaLaCasaAppTheme.Orange,
                              borderRadius: BorderRadius.circular(35.0)
                          ),
                          child: Text(
                            "Completar".toUpperCase(),
                            style: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    alignment: Alignment.center,
    value: item,
    child: Text(
      item,
      style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,fontSize: 16.0,color: PaLaCasaAppTheme.Gray.withOpacity(0.5)),
    ),
  );


  void showCalendarBirthday({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarBirthday(
        controller:_controllerBirthday,
        barrierDismissible: false,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialStartDate: startDates,
        onApplyClick: (DateTime startData) {
          setState(() {
            startDates = startData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }
}
