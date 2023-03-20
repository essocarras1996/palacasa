import 'package:flutter/material.dart';
import 'package:palacasa/Administrator/AdministratorScreen.dart';
import 'package:palacasa/Bares/Bares.dart';
import 'package:palacasa/Helper/color_constant.dart';
import 'package:palacasa/HiddenDrawer/hidden_drawer.dart';
import 'package:palacasa/PaLaCasaAppHomeScreen.dart';
import 'package:palacasa/database/PaLaCasaDB.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> scaleAnimation, smallerScaleAnimation;
  late List<Animation<double>>scaleAnimations;
  Duration duration = Duration(milliseconds: 200);
  bool menuOpen = false;
  int id_role=3;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.7).animate(_animationController);
    smallerScaleAnimation =
        Tween<double>(begin: 1.0, end: 0.6).animate(_animationController);
    scaleAnimations = [
      Tween<double>(begin: 1.0, end: 0.7).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.6).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.5).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.4).animate(_animationController),
    ];

    screenSnapshot = getScreen().toList();
    getUser();
  }

  showMenu(){
          setState(() {
        menuOpen = true;
        _animationController.forward();
      });
  }


  getScreen(){
    switch(id_role){
      case 1:{
        return [
          AdministratorScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
          PaLaCasaAppHomeScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
          BaresScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
          PaLaCasaAppHomeScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
        ];

      }
      case 2:{
        return [
          PaLaCasaAppHomeScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
          PaLaCasaAppHomeScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
          BaresScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
          PaLaCasaAppHomeScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
        ];
      }
      case 3:{
        return [
          PaLaCasaAppHomeScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
          PaLaCasaAppHomeScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
          BaresScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
          PaLaCasaAppHomeScreen(menuCallBack: (){
            setState(() {
              menuOpen = true;
              _animationController.forward();
            });
          },),
        ];
      }
    }

  }





  Widget buildScreenStack(int position) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: menuOpen ? deviceWidth * 0.55 - (position * 30) : 0.0,
      right: menuOpen ? deviceWidth * -0.45 + (position * 20) : 0.0,
      child: ScaleTransition(
        scale: scaleAnimations[position],
        child: GestureDetector(
          onTap: () {
            if (menuOpen) {
              setState(() {
                menuOpen = false;
                _animationController.reverse();
              });
            }
          },
          child: AbsorbPointer(
            absorbing: menuOpen,
            child: Stack(
              children: <Widget>[
                Material(
                  animationDuration: duration,
                  borderRadius: BorderRadius.circular(menuOpen ? 40.0 : 0.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(menuOpen?40:0),
                      child: position==0?screenSnapshot[position]:Stack(children: [screenSnapshot[position],Container(color: PaLaCasaAppTheme.Gray.withOpacity(0.1*position/2),)]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  late List<Widget> screenSnapshot;

  List<Widget> finalStack() {
    List<Widget> stackToReturn = [];
    stackToReturn.add(HiddenDrawer(
      menuCallBack: (selectedIndex) {
        setState(() {
          screenSnapshot = getScreen().toList();
          final selectedWidget = screenSnapshot.removeAt(selectedIndex);
          screenSnapshot.insert(0, selectedWidget);
        });
      },
    ));

    screenSnapshot
        .asMap()
        .entries
        .map((screenEntry) => buildScreenStack(screenEntry.key))
        .toList()
        .reversed
      ..forEach((screen) {
        stackToReturn.add(screen);
      });

    return stackToReturn;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: finalStack()
      ),
    );
  }

  void getUser() async{
    var db = await PaLaCasaDB.instance.readAllSesion();
    id_role = int.parse(db.first.id_role);
    screenSnapshot = getScreen().toList();
    setState(() {

    });
  }
}
