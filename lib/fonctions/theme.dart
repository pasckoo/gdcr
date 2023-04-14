
import 'dart:async';
import 'dart:ffi';
import 'globals.dart';
import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:ui';
import 'package:string_to_color/string_to_color.dart';
import 'dart:io';
import 'dart:ui' as ui;


//Color c1 = const Color(0xFF1B5E20); // vert 900
//Color c1 = const Color(0xFFB71C1C); // rouge 900
//Color c1 = const Color(0xFFE64A19);  // orange 700
//Color c1 = const Color(0xFF0288D1); // bleu 700
//Color c1 = const Color(0xFF00E5FF); //bleu turquoise
//int toto = 4284955319;

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<Color> _loadColor() async {
  final SharedPreferences prefs = await _prefs;
  final int color = (prefs.getInt('couleur') ?? 0xFF0288D1) ;

  return Color(color);
}


class ThemeCouleur extends StatefulWidget {
  const ThemeCouleur({Key? key}) : super(key: key);

  @override
  State<ThemeCouleur> createState() => _ThemeCouleurWidgetState();
}

class _ThemeCouleurWidgetState extends State<ThemeCouleur> {
  Color c1 = const Color(0xFF0288D1); // bleu 700

  themeLight(context) {
  Future<Color> c2 = _loadColor();
  c2.then((value){
    setState((){
      c1 = value;
    });
  });

  return ThemeData(
  brightness: Brightness.light,
  primarySwatch: generateMaterialColor(color: c1),
  primaryColor: c1,
  //primaryColorLight: Colors.lightGreenAccent[100],
  //scaffoldBackgroundColor: const Color(0xFFE3F2FD),
  textTheme:
  Theme
      .of(context)
      .textTheme
      .apply(
  bodyColor: Colors.black54, //<-- SEE HERE
  displayColor: Colors.black54, //<-- SEE HERE
  ),

  iconTheme: IconThemeData(color: c1),
  listTileTheme: ListTileThemeData(iconColor: c1),
  bottomAppBarTheme: BottomAppBarTheme(color: c1),
  dividerColor: Colors.transparent,
  );
  }

  themeDark(context) {

  return ThemeData(
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
  );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


  }








