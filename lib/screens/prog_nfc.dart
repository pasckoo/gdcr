
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gdcr/fonctions/globals.dart';
import '../../screens/materiel_detail.dart';
import '../classes/menu.dart';
import '../classes/dialogs.dart';
import '../fonctions/nfc.dart';
import 'accueil.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';



ValueNotifier<dynamic> result = ValueNotifier(null);

class MyConf_NFC extends StatefulWidget {
  const MyConf_NFC({Key? key}) : super(key: key);
  // this allows us to access the TextField text

  @override
  createState() => _MyAppState();

}

class _MyAppState extends State <MyConf_NFC>{
  String scanTag = '';

  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  bool _isButtonDisabled = false;



  // Read a tag record first
  Future<void> recRead() async{
    WidgetsFlutterBinding.ensureInitialized();
    bool nfcConnect = await NfcManager.instance.isAvailable();
    if(nfcConnect == false && mounted){
      showDialog(
          context: context,
          builder: (context){
            return const DialogNonNFC();
          }
      );
      return;
    }else{
      showDialog(
          context: context,
          builder: (context) {
            return DialogAfficheNFC(texte: globalLireDialog,);
          });
    }

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final ndefTag = Ndef.from(tag);
      var ndefMessage = ndefTag?.cachedMessage!;
      final wellKnownRecord = ndefMessage?.records.first;
      //skip(1) pour enlever le "en"
      final languageCodeAndContentBytes = wellKnownRecord?.payload.skip(1)
          .toList(); // for remove 2 first caracters
      final languageCodeAndContentText = utf8.decode(
          languageCodeAndContentBytes!);
      final payload = languageCodeAndContentText.substring(
          2); // for remove 2 first caracters
      result.value = payload;
      NfcManager.instance.stopSession();
      setState(() {
        _isButtonDisabled = false;
        _navigateToMaterielScreen(context, result.value);
      });
    });

  }

  // Effacer le tag
  Future<void> effacerTag() async {
    bool nfcConnect = await NfcManager.instance.isAvailable();
    if(nfcConnect == false && mounted){
      showDialog(
          context: context,
          builder: (context){
            return const DialogNonNFC();
          }
      );
      return;
    }else{
      showDialog(
          context: context,
          builder: (context){
            return DialogAfficheNFC(texte: globalEffaceDialog,);
          }
      );
    }
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText(''),   // Here is reference for the tag
        /*NdefRecord.createUri(Uri.parse('')),
      NdefRecord.createMime(
          '', Uint8List.fromList(''.codeUnits)),
      NdefRecord.createExternal(
          '', '', Uint8List.fromList(''.codeUnits)),*/
      ]);

      try {

        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
        if(mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return const DialogEffaceNFC();
              }

          );
        }
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });

  }

  // Ecrire dans le tag
  Future<void> ecrireTag(String ref) async {
    bool nfcConnect = await NfcManager.instance.isAvailable();
    if(nfcConnect == false && mounted){
      showDialog(
          context: context,
          builder: (context){
            return const DialogNonNFC();
          }
      );
      return;
    }
    if(ref != '' && mounted){
      showDialog(
          context: context,
          builder: (context){
            return DialogAfficheNFC(texte: globalEcrireDialog);
          }
      );
      //return;
    }

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText(ref),   // Here is reference for the tag
        /*NdefRecord.createUri(Uri.parse('http://code-un-peu.fr')),
      NdefRecord.createMime(
          'text/plain', Uint8List.fromList('Bonjour'.codeUnits)),
      NdefRecord.createExternal(
          'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),*/
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
        if(mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return const DialogTaggerNFC();
              }

          );
        }
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });

  }

  @override

  Widget build(BuildContext context) {
    home: return Scaffold(
      appBar: AppBar(
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
          ],
          title: const Text('Programmation puce NFC')
      ),
      drawer: const MyDrawer(),
      body: Builder(builder: (BuildContext context) {
        return Container(
            margin: const EdgeInsets.only(left:10.0,top:10.0,right:10.0,bottom:0.0),
            alignment: Alignment.center,

            child: ListView(

              //direction: Axis.vertical,
              //mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Card(
                    elevation: 10.0,
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
                    color: globalBackgroundColor(context, colorBackground),
                    shape: RoundedRectangleBorder( //<-- SEE HERE
                      side: BorderSide(
                        color: globalBorderColor(context, borderColor),
                      ),
                    ),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,

                      children: const [
                        Text('NFC ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                        Icon(Icons.nfc_rounded, size: 55,),
                        Text('La puce NFC contient le repère du matériel\n'),

                      ],
                    )//const Icon(Icons.nfc_rounded, size: 60,),

                  ),

                  const Divider(height: 50.0,),

                  ElevatedButton(
                      onPressed: () {
                        effacerTag();
                      },
                      child:const Text('Effacer la puce NFC')),

                  const SizedBox(
                    height: 20,
                  ) ,

                  ElevatedButton(
                      child: const Text('Ecrire / Modifier puce NFC'),
                    onPressed: () async {
                      _controller.clear();
                      showDialog(
                        barrierDismissible: false,
                        // l'utilisateur doit presser un bouton pour sortir! (modale)
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),

                            title: const Text('Ecrire un nouveau repère',
                              textAlign: TextAlign.center,),

                            content: TextField(
                                controller: _controller,
                                style: const TextStyle(fontSize: 20),
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                ],
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear_rounded),
                                    onPressed: () {
                                      _controller.clear();
                                    },
                                  ),
                                  label: const Text('Nouveau repère', style: TextStyle(fontSize: 16.0),),
                                ),
                                textAlign: TextAlign.center,
                                onChanged: (value){
                                  //scanTag = value;
                                }),

                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Annuler'),
                              ),


                              TextButton(
                                onPressed:() {
                                  if(_controller.text != '') {
                                    Navigator.pop(context, _controller.text);
                                  }
                                },
                                child: const Text('Ecrire'),
                              ),

                            ],
                          );
                        }
                      ).then((val){
                        setState(() {
                          scanTag = val;
                          ecrireTag(scanTag);
                        });
                      });
                    } // onPressed
                  ),


                  /*TextField(
                      controller: _controller,
                      style: const TextStyle(fontSize: 20),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                              FocusScope.of(context).unfocus();
                            });
                          },
                        ),
                        label: const Text('Nouveau repère'),
                        /*enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Theme.of(context)
                              .colorScheme.primary),
                          borderRadius: BorderRadius.circular(15),

                        ),*/
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Theme.of(context)
                              .colorScheme.primary),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      onChanged: (value){
                        scanTag = value;
                        /*setState(() {
                          if(scanTag != ''){texte = true;}
                          else{texte = false;}
                        });*/
                      }),*/

                  const Divider(),



                  const SizedBox(
                    height: 50,
                  ) ,

                  const Divider(),

                ]

            )


        );
      }),
    );


  }

  initialValue(val){
    return TextEditingController(text: val);
  }

  void _navigateToMaterielScreen(BuildContext context,String repe) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyMaterielDetailPage(rep:repe)));
  }

/*void _navigateToCBScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappTag()));
  }*/

}

