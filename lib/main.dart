import 'package:flutter/material.dart';
import 'screens/connexion.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import './fonctions/globals.dart';


final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();



Future<Color> _loadColor() async {
  final SharedPreferences prefs = await _prefs;
  final int color = (prefs.getInt('couleur') ?? 0xFF0288D1) ;
  colorBackground = (prefs.getBool('couleurDeFond') ?? false);
  borderColor = (prefs.getBool('bordureEnCouleur') ?? false);
  return Color(color);
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  c1 = await _loadColor();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppWidgetState();
}

class _MyAppWidgetState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
  return AdaptiveTheme(
    light: ThemeData(
    brightness: Brightness.light,
    primarySwatch: generateMaterialColor(color: c1),
    primaryColor: c1,
    //primaryColorLight: Colors.lightGreenAccent[100],
    //scaffoldBackgroundColor: c1,//const Color(0xFFE3F2FD),
    textTheme:
      Theme
          .of(context)
          .textTheme
          .apply(
      bodyColor: Colors.black54, //<-- SEE HERE
      displayColor: Colors.black54, //<-- SEE HERE


    ),

    cardColor: Theme.of(context).scaffoldBackgroundColor,

    iconTheme: IconThemeData(color: c1),
    listTileTheme: ListTileThemeData(iconColor: c1),
    bottomAppBarTheme: BottomAppBarTheme(color: c1),
    dividerColor: Colors.transparent,
    ),

    dark: ThemeData(
    brightness: Brightness.dark,
    primarySwatch: generateMaterialColor(color: c1),
    primaryColor: c1,
    textTheme:
    Theme
        .of(context)
        .textTheme
        .apply(
    bodyColor: Colors.white70, //<-- SEE HERE
    displayColor: Colors.white70, //<-- SEE HERE
    ),

  iconTheme: IconThemeData(color: c1),
  //listTileTheme: const ListTileThemeData(iconColor: Colors.orange),
  dividerColor: Colors.transparent,
  ),
  initial: AdaptiveThemeMode.light,
    builder: (theme, darkTheme) => MaterialApp(
      theme: theme,
      home: const MyConnexion(), /*Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/images/fond.png'),
          fit: BoxFit.cover,
          ),
          ),
        child: AnimatedSplashScreen(
              centered: true,
              duration: 1000,
              splash: 'assets/images/oiseau.gif',
              splashIconSize: 200,
          nextScreen: const MyAppC(),
    splashTransition: SplashTransition.slideTransition,
    pageTransitionType: PageTransitionType.rightToLeft,
  )
  )*/
  ),
  );


  }



}















