import 'package:flutter/material.dart';
import 'package:palacasa/my_flutter_app_icons.dart';

class TabIconData {
  TabIconData({
    required this.imagePath,
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  IconData imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: MyFlutterApp.home,
      selectedImagePath: 'homes',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: MyFlutterApp.location,
      selectedImagePath: 'notifys',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: MyFlutterApp.heart,
      selectedImagePath: 'encantas',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: MyFlutterApp.user,
      selectedImagePath: 'profiles',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
  static List<TabIconData> tabIconsListAdmin = <TabIconData>[
    TabIconData(
      imagePath: MyFlutterApp.drafting_compass,
      selectedImagePath: 'stores',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: MyFlutterApp.layer_group,
      selectedImagePath: 'categories',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: MyFlutterApp.users,
      selectedImagePath: 'profiles',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: MyFlutterApp.leaf,
      selectedImagePath: 'stadistics',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
  ];
}

