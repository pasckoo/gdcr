
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:gdcr/fonctions/globals.dart';
import 'package:gdcr/screens/prog_nfc.dart';
import '../main.dart';
import 'CB.dart';
import 'accueil.dart';
import '../classes/menu.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../classes/dialogs.dart';
import 'tag.dart';




class MyModePage extends StatefulWidget {
  const MyModePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyModePage> createState() => _MyModePageState();
}

class _MyModePageState extends State<MyModePage> {
  bool darkmode = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _couleur;
  dynamic savedThemeMode;
  Color currentColor = Colors.amber;
  bool isListTileEnable = false;

  List<Color> currentColors = [Colors.yellow, Colors.green];
  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
    _loadColor();
  }

  Future<void> _saveColor() async {
    final SharedPreferences prefs = await _prefs;
    //final String couleur = (prefs.getString('couleur') ?? '');
    prefs.setInt('couleur', currentColor.value);
    prefs.setBool('couleurDeFond', colorBackground);
    prefs.setBool('bordureEnCouleur', borderColor);

    //final int color = (prefs.getInt('couleur') ?? 0xFF0288D1 ) ;
   // print(color);
  }

  Future<void> _loadColor() async {
    final SharedPreferences prefs = await _prefs;
    final int color = (prefs.getInt('couleur') ?? 0xFF0288D1) ;
    currentColor = Color(color);

  }

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      setState(() {
        darkmode = true;
      });
    } else {
      setState(() {
        darkmode = false;
        _loadColor();

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Color newColor = currentColor;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
            actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder:
              (context) => const Home())),

            icon: const Icon(
            Icons.home,
            color: Colors.white70,
            size: 35.0,

            ),
          ),

          IconButton(
            onPressed: ()=>_navigateToCBScreen(context),

            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white70,
              size: 35.0,

            ),
          )
          ]
        ),

        drawer: const MyDrawer(),

        body: Center(



          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                  margin: globalMargin(),
                  decoration: BoxDecoration(
                    color: globalBackgroundColor(context, colorBackground),
                    border:  Border.all(color: globalBorderColor(context, borderColor),),
                    boxShadow: globalContainerShadow(),
                  ),
                //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SwitchListTile(
                  activeColor: Theme.of(context).colorScheme.primary,
                  title: const Text('Mode sombre'),
                  secondary: const Icon(Icons.nightlight_round),
                  value: darkmode,
                  onChanged: (bool value){
                    if(value == true){
                      AdaptiveTheme.of(context).setDark();
                    }else{
                      AdaptiveTheme.of(context).setLight();
                    }
                    setState((){
                      darkmode = value;

                    });

                  },
                )
              ),

              const Divider(),

              Container(
                  margin: globalMargin(),
                  decoration: BoxDecoration(
                    color: globalBackgroundColor(context, colorBackground),
                    border:  Border.all(color: globalBorderColor(context, borderColor),),
                    boxShadow: globalContainerShadow(),
                  ),
                  //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SwitchListTile(
                    activeColor: Theme.of(context).colorScheme.primary,
                    title: const Text('Fonds colorés'),
                    secondary: const Icon(Icons.format_color_fill_rounded),
                    value: colorBackground,
                    onChanged: (bool value){
                      if(value == true){
                        globalBackgroundColor(context, colorBackground);
                      }else{
                        globalBackgroundColor(context, colorBackground);
                      }
                      setState((){
                        colorBackground = value;
                      });
                      _saveColor();

                    },
                  )
              ),

              const Divider(),

              Container(
                  margin: globalMargin(),
                  decoration: BoxDecoration(
                    color: globalBackgroundColor(context, colorBackground),
                    border:  Border.all(color: globalBorderColor(context, borderColor),),
                    boxShadow: globalContainerShadow(),
                  ),
                  //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SwitchListTile(
                    activeColor: Theme.of(context).colorScheme.primary,
                    title: const Text('Bordures visibles'),
                    secondary: const Icon(Icons.rectangle_outlined),
                    value: borderColor,
                    onChanged: (bool value){
                      if(value == true){
                        globalBorderColor(context, borderColor);
                      }else{
                        globalBorderColor(context, borderColor);
                      }
                      setState((){
                        borderColor = value;
                      });
                      _saveColor();

                    },
                  )
              ),

              const Divider(),

              Container(
                margin: globalMargin(),
                decoration: BoxDecoration(
                  color: globalBackgroundColor(context, colorBackground),
                  border:  Border.all(color: globalBorderColor(context, borderColor),),
                  boxShadow: globalContainerShadow(),
                ),
                //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ListTile(
                  leading: const Icon(Icons.color_lens_rounded),
                  title: const Text('Couleur de l\'application'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: globalBorderColor(context, borderColor),),
                  ),
                  trailing: ElevatedButton(

                    onPressed: () {
                      _loadColor();
                      showDialog(
                        barrierDismissible: false,
                        // l'utilisateur doit presser un bouton pour sortir! (modale)
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: const Text('Choisir une couleur'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: currentColor,
                                onColorChanged: (color) {
                                  setState((){
                                    currentColor = color;
                                    c1 = currentColor;

                                  });
                                }
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Annuler'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text('Valider'),
                                onPressed: () {
                                  _saveColor();
                                  getCurrentTheme();
                                  Navigator.pop(context);
                                  _navigateToAppScreen(context);
                                  /*if(newColor != currentColor) {
                                    showDialog(
                                    barrierDismissible: false,
                                    // l'utilisateur doit presser un bouton pour sortir! (modale)
                                    context: context,
                                    builder: (context) => const DialogChangeColor(),

                                  );
                                  }*/
                                },
                              ),
                            ],
                          );
                        },
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Text(''),
                  ),
                )
              ),

              const Divider(),

              Container(
                margin: globalMargin(),
                decoration: BoxDecoration(
                  color: globalBackgroundColor(context, colorBackground),
                  border:  Border.all(color: globalBorderColor(context, borderColor),),
                  boxShadow: globalContainerShadow(),
                ),
                  child: ListTile(
                    enabled: globalsLogin != null && globalsActive!?true:false,
                      leading: const Icon(Icons.nfc_rounded),
                      title: const Text('Programmation puce NFC'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: globalBorderColor(context, borderColor),),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () => _navigateToAppTagScreen(context),

                  ),
                ),
            ],
          ),
        ),
    );
  }

}

void _navigateToCBScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
}

void _navigateToAppScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyApp()));
}

void _navigateToAppTagScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyConf_NFC()));
}


