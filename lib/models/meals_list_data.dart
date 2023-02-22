class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/plimonada.png',
      titleTxt: 'Piñata',
      kacl: 150,
      meals: <String>['Sabor:', 'Limonada'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/acondicionadorr.png',
      titleTxt: 'Sedal',
      kacl: 600,
      meals: <String>['Acondicionador' ,'Anti-nudos'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/shampoo.png',
      titleTxt: 'Sedal',
      kacl: 600,
      meals: <String>['Shampoo', 'Anti-nudos'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/colcha.png',
      titleTxt: 'Frasada',
      kacl: 100,
      meals: <String>['Para piso'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
