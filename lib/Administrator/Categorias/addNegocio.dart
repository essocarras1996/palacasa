import 'dart:convert';
import 'dart:io';

import 'package:blur/blur.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:palacasa/Administrator/Categorias/SelectAddress.dart';
import 'package:palacasa/CustomInputFormatter.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:palacasa/database/PaLaCasaDB.dart';
import 'package:palacasa/jsons/CreateUserJson.dart';
import 'package:palacasa/jsons/businessAdminJson.dart';
import 'package:palacasa/my_flutter_app_icons.dart';
import 'package:http/http.dart' as http;

class addNegocio extends StatefulWidget {
  final List<TypeBusiness> listBusiness;
  const addNegocio( {Key? key,required this.listBusiness}) : super(key: key);

  @override
  State<addNegocio> createState() => _addNegocioState();
}

class _addNegocioState extends State<addNegocio> {
  String value='Negocio';
  var items =['Negocio'];
  var _controllerName = TextEditingController();
  var _controllerTimeStart = TextEditingController();
  var _controllerTimeEnd = TextEditingController();
  var _controllerLogo = TextEditingController();
  var _controllerImagen = TextEditingController();
  var _controllerTimeDelivery = TextEditingController();
  var _controllerFacebook = TextEditingController();
  var _controllerInstagram = TextEditingController();
  var _controllerWhatsapp = TextEditingController();
  var _controllerDescripcion = TextEditingController();
  late File imagenLogo;
  late File imageFile;
  bool isAvailable=false;
  bool isOpen=false;
  bool reserva=false;
  bool freeDelivery=false;
  bool setRequest=false;
  
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  @override
  void initState() {
    items.addAll(widget.listBusiness.map((e) => e.name!));
    super.initState();
  }

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaLaCasaAppTheme.background,
      body: Stack(
        children: [

          Positioned(
            top:40,
            left:15,
            child: GestureDetector(
              onTap: () =>  Navigator.pop(context),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: Text("Añadir Negocio",
                            style: TextStyle(
                                fontFamily: PaLaCasaAppTheme.fontName,
                                fontSize: 20,
                                color: PaLaCasaAppTheme.Gray
                            ),),
                        ),

                      ],
                    ),
                  ),
                ],
              )
            ),
          ),
          
          Positioned(
            top: 100,
            bottom: 0,
            right: 0,
            left: 0,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 00.0,right: 25,left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isAvailable?'Disponible':'No Disponible',
                            style: TextStyle(color: PaLaCasaAppTheme.Gray,fontSize: 16.0,fontFamily: PaLaCasaAppTheme.fontName),
                          ),
                        ),
                        CupertinoSwitch(
                          activeColor: isAvailable
                              ? PaLaCasaAppTheme.Orange
                              : Colors.grey.withOpacity(0.6),
                          onChanged: (bool value) {
                            setState(() {
                              isAvailable =!isAvailable;
                            });
                          },
                          value: isAvailable,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,right: 25,left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isOpen?'Negocio Abierto':'Negocio Cerrado',
                            style: TextStyle(color: PaLaCasaAppTheme.Gray,fontSize: 16.0,fontFamily: PaLaCasaAppTheme.fontName),
                          ),
                        ),
                        CupertinoSwitch(
                          activeColor: isOpen
                              ? PaLaCasaAppTheme.Orange
                              : Colors.grey.withOpacity(0.6),
                          onChanged: (bool value) {
                            setState(() {
                              isOpen =!isOpen;
                            });
                          },
                          value: isOpen,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,right: 25,left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reserva?'Permite Reserva':'No Permite Reserva',
                            style: TextStyle(color: PaLaCasaAppTheme.Gray,fontSize: 16.0,fontFamily: PaLaCasaAppTheme.fontName),
                          ),
                        ),
                        CupertinoSwitch(
                          activeColor: reserva
                              ? PaLaCasaAppTheme.Orange
                              : Colors.grey.withOpacity(0.6),
                          onChanged: (bool value) {
                            setState(() {
                              reserva =!reserva;
                            });
                          },
                          value: reserva,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,right: 25,left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            freeDelivery?'Entrega Gratis':'Entrega con Costo',
                            style: TextStyle(color: PaLaCasaAppTheme.Gray,fontSize: 16.0,fontFamily: PaLaCasaAppTheme.fontName),
                          ),
                        ),
                        CupertinoSwitch(
                          activeColor: freeDelivery
                              ? PaLaCasaAppTheme.Orange
                              : Colors.grey.withOpacity(0.6),
                          onChanged: (bool value) {
                            setState(() {
                              freeDelivery =!freeDelivery;
                            });
                          },
                          value: freeDelivery,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,top: 5,bottom: 5),
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
                                    icon: Icon(MyFlutterApp.store,color: PaLaCasaAppTheme.Gray.withOpacity(0.5), size: 20,),
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
                    padding: const EdgeInsets.only(right: 25,left: 25,top: 5,bottom: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color:PaLaCasaAppTheme.Gray.withOpacity(0.1),width: 1.0 )

                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0,left: 12.0,top: 4,bottom: 4),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            icon: Icon(Icons.arrow_drop_down,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
                            value: value,
                            style: TextStyle(color: Colors.black38, fontSize: 18,),
                            underline: Container(
                              height: 1,
                              color: PaLaCasaAppTheme.Gray.withOpacity(0.5),
                            ),
                            items: items.map(buildMenuItem).toList(),
                            onChanged: (value) =>setState(() {
                              _changeGrade(value);
                            }),

                          ),
                        ),
                      ),

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,top: 5,bottom: 5),
                    child:  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          showPicker(
                            showSecondSelector: false,
                            context: context,
                            value: _time,
                            onChange: onTimeChanged,
                            minuteInterval: TimePickerInterval.FIVE,
                            // Optional onChange to receive value as DateTime
                            onChangeDateTime: (DateTime dateTime) {
                              DateTime tempDate = DateFormat("hh:mm").parse(
                                  dateTime!.hour.toString() +
                                      ":" + dateTime!.minute.toString());
                              var dateFormat = DateFormat("h:mm a");
                              _controllerTimeStart.text=dateFormat.format(tempDate);
                            },
                          ),
                        );
                      },
                      child: TextFormField(
                        style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                        cursorColor: PaLaCasaAppTheme.Orange,
                        enabled: false,
                        controller: _controllerTimeStart,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                            child: Container(
                              width: 70,
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(MyFlutterApp.clock,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),size: 20),
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
                          disabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: BorderSide(
                              color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Horario Inicio',
                          hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,top: 5,bottom: 5),
                    child:  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          showPicker(
                            showSecondSelector: false,
                            context: context,
                            value: _time,
                            onChange: onTimeChanged,
                            minuteInterval: TimePickerInterval.FIVE,
                            // Optional onChange to receive value as DateTime
                            onChangeDateTime: (DateTime dateTime) {
                              DateTime tempDate = DateFormat("hh:mm").parse(
                                  dateTime!.hour.toString() +
                                      ":" + dateTime!.minute.toString());
                              var dateFormat = DateFormat("h:mm a");
                              _controllerTimeEnd.text=dateFormat.format(tempDate);
                            },
                          ),
                        );
                      },
                      child: TextFormField(
                        style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                        cursorColor: PaLaCasaAppTheme.Orange,
                        enabled: false,
                        controller: _controllerTimeEnd,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                            child: Container(
                              width: 70,
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(MyFlutterApp.clock,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),size: 20),
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
                          disabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: BorderSide(
                              color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Horario Fin',
                          hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,top: 5,bottom: 5),
                    child:  GestureDetector(
                      onTap: () {
                        _getFromGalleryLogo();
                      },
                      child: TextFormField(
                        style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                        cursorColor: PaLaCasaAppTheme.Orange,
                        controller: _controllerLogo,
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                            child: Container(
                              width: 70,
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(MyFlutterApp.tag,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),size: 20,),
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
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: BorderSide(
                              color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Logo',
                          hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,top: 5,bottom: 5),
                    child:  GestureDetector(
                      onTap: () {
                        _getFromGallery();
                      },
                      child: TextFormField(
                        style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                        cursorColor: PaLaCasaAppTheme.Orange,
                        controller: _controllerImagen,
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                            child: Container(
                              width: 70,
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.image,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: BorderSide(
                              color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                              width: 1.0,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: BorderSide(
                              color: PaLaCasaAppTheme.Gray.withOpacity(0.1),
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Imagen',
                          hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,top: 5,bottom: 5),
                    child:  TextFormField(
                      style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                      cursorColor: PaLaCasaAppTheme.Orange,
                      controller: _controllerTimeDelivery,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                          child: Container(
                            width: 70,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(MyFlutterApp.clock,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),size: 20,),
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
                        hintText: 'Tiempo de entrega (min)',
                        hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,top: 5,bottom: 5),
                    child:  TextFormField(
                      style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                      cursorColor: PaLaCasaAppTheme.Orange,
                      controller: _controllerFacebook,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                          child: Container(
                            width: 70,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.facebook,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
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
                        hintText: 'Facebook',
                        hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,top: 5,bottom: 5),
                    child:  TextFormField(
                      style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                      cursorColor: PaLaCasaAppTheme.Orange,
                      controller: _controllerInstagram,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                          child: Container(
                            width: 70,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(MyFlutterApp.instagram,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
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
                        hintText: 'Instagram',
                        hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,top: 5,bottom: 0),
                    child:  TextFormField(
                      style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,color: PaLaCasaAppTheme.Gray.withOpacity(0.6),fontSize: 14),
                      cursorColor: PaLaCasaAppTheme.Orange,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        new LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        new CustomInputFormatter()
                      ],
                      controller: _controllerWhatsapp,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                          child: Container(
                            width: 70,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(MyFlutterApp.whatsapp,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),),
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
                        hintText: 'Whatsapp',
                        hintStyle: TextStyle(fontFamily: PaLaCasaAppTheme.fontName,color: PaLaCasaAppTheme.Gray.withOpacity(0.4),fontSize: 14),

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.0,left: 25.0,bottom: 5),
                    child: _buildComposer(),
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
                              String name = _controllerName.text;
                              String description = _controllerDescripcion.text;
                              String horarioStart = _controllerTimeStart.text;
                              String horarioEnd = _controllerTimeEnd.text;
                              String preserva = '0';
                              if(reserva){
                                preserva = '1';
                              }
                              String pfreeDelivery = '0';
                              if(freeDelivery){
                                pfreeDelivery = '1';
                              }
                              String pisAvailable = '0';
                              if(isAvailable){
                                pisAvailable = '1';
                              }
                              String pisOpen = '0';
                              if(isOpen){
                                pisOpen = '1';
                              }
                              String facebook = _controllerFacebook.text;
                              String instagram = _controllerInstagram.text;
                              String whatsapp = _controllerWhatsapp.text;
                              String tiempo_entrega = _controllerTimeDelivery.text;
                              String id_typeBusiness =getIdBusiness(value);
                              if(name.isEmpty||description.isEmpty||horarioStart.isEmpty||horarioEnd.isEmpty||tiempo_entrega.isEmpty||whatsapp.isEmpty||_controllerImagen.text.isEmpty||_controllerLogo.text.isEmpty)
                                Fluttertoast.showToast(msg: "Rellene los espacios en blanco",backgroundColor: Colors.grey,gravity: ToastGravity.BOTTOM);
                              else
                                addCafeteria(name, description, horarioStart, horarioEnd, preserva, pfreeDelivery, tiempo_entrega, pisAvailable, pisOpen, facebook, instagram, whatsapp,id_typeBusiness);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: setRequest?14:20.0, bottom: setRequest?14:20.0),
                              decoration: BoxDecoration(
                                  color: PaLaCasaAppTheme.Orange,
                                  borderRadius: BorderRadius.circular(35.0)
                              ),
                              child: setRequest?Center(child: CircularProgressIndicator(color: PaLaCasaAppTheme.nearlyWhite,strokeWidth: 2,)):Text(
                                "Añadir".toUpperCase(),
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
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: PaLaCasaAppTheme.nearlyWhite,
        borderRadius: BorderRadius.circular(25),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26.withOpacity(0.1),
              offset: const Offset(2, 2),
              blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          constraints: const BoxConstraints(minHeight: 100, maxHeight: 160),
          color: PaLaCasaAppTheme.nearlyWhite,
          child: SingleChildScrollView(
            child: TextField(
              controller:_controllerDescripcion,
              maxLines: null,
              onChanged: (String txt) {},
              style: TextStyle(
                fontFamily: PaLaCasaAppTheme.fontNameRegular,
                fontSize: 16,
                color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
              ),
              cursorColor: PaLaCasaAppTheme.Gray,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: PaLaCasaAppTheme.fontName,
                    fontSize: 16,
                    color: PaLaCasaAppTheme.Gray.withOpacity(0.3),
                  ),
                  border: InputBorder.none,
                  prefixIcon:Icon(Icons.description_outlined,color: PaLaCasaAppTheme.Gray.withOpacity(0.5),) ,
                  hintText: 'Descripción'),
            ),
          ),
        ),
      ),
    );
  }

  _getFromGalleryLogo() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imagenLogo = File(pickedFile.path);
        _controllerLogo.text=imagenLogo.absolute.path.replaceAll("/data/user/0/com.essocarras.palacasa/cache/", "");

      });
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _controllerImagen.text=imageFile.absolute.path.replaceAll("/data/user/0/com.essocarras.palacasa/cache/", "");

      });
    }
  }

  addCafeteria(String name,String description,String horarioStart,String horarioEnd,String reserva,String free_delivery,String tiempo_entrega,String disponible,String is_open,String facebook,String instagram,String whatsapp, String id_typeBusiness) async {

    var request = http.MultipartRequest('POST', Uri.parse('https://palacasa.whizzlyshop.com/api/cafeteria'))
      ..fields['name'] = name
      ..fields['id_typeBusiness'] = id_typeBusiness
      ..fields['description'] = description
      ..fields['horarioStart'] = horarioStart
      ..fields['horarioEnd'] = horarioEnd
      ..fields['reserva'] = reserva
      ..fields['free_delivery'] = free_delivery
      ..fields['tiempo_entrega'] = tiempo_entrega
      ..fields['disponible'] = disponible
      ..fields['is_open'] = is_open
      ..fields['facebook'] = facebook
      ..fields['instagram'] = instagram
      ..fields['whatsapp'] = whatsapp
      ..files.add(await http.MultipartFile.fromPath('logo', imagenLogo.path))
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var db = await PaLaCasaDB.instance.readAllSesion();
    String token = db.first.token;
    var headers = {
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      try {
        String d =await response.stream.bytesToString();
        var a = json.decode(d);
        var userJson = createUserJson.fromJson(a);
        Fluttertoast.showToast(msg: userJson.message!,backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
        Navigator.pop(context);
      }catch(e){

      }

    }else if (response.statusCode == 401){

      print(401);
    } else {
      print(response.reasonPhrase);
    }

  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    alignment: Alignment.center,
    value: item,
    child: Text(
      item,
      style: TextStyle(fontFamily: PaLaCasaAppTheme.fontNameRegular,fontSize: 16.0,color: PaLaCasaAppTheme.Gray.withOpacity(0.5)),
    ),
  );

  void _changeGrade(_newGrade) {
    setState(
          () {
        value = _newGrade;
      },
    );
  }

  String getIdBusiness(String value) {
    for(var b in widget.listBusiness){
      if(b.name.toString()==value ){
        print('${b.id!} ${b.name}');
        return b.id!.toString();
      }
    }
    return "";
  }
}
