
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gdcr/fonctions/globals.dart';
import 'package:gdcr/screens/qrviewer.dart';
import '../../screens/materiel_detail.dart';
import '../classes/menu.dart';
import '../classes/dialogs.dart';
import 'accueil.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';



ValueNotifier<dynamic> result = ValueNotifier(null);

class MyappCB extends StatefulWidget {
  const MyappCB({Key? key}) : super(key: key);
  // this allows us to access the TextField text

  @override
  createState() => _MyAppState();

}

class _MyAppState extends State <MyappCB> {
  String _scanBarcode = '';
  String scanTag = '';
  bool texte = false;
  String _platformVersion = 'Unknown';

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Annuler', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Annuler', true, ScanMode.QR);
      //print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Erreur';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      texte = false;
      if (_scanBarcode != '-1') {
        navigateToMaterielScreen(context, _scanBarcode);
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Annuler', true, ScanMode.BARCODE);
      //print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }



  bool _isButtonDisabled = false;

  void _handleButtonTap() {
   // if (!_isButtonDisabled) {
      setState(() {
        _isButtonDisabled = false;
        nfcRead();
      });
      // Perform the action that the button triggers here

      /*Future.delayed(const Duration(seconds: 10), () {
        setState(() {
          _isButtonDisabled = false;
          NfcManager.instance.stopSession();
        });
      });*/
   // }
  }

  // Read a tag record first
  Future<void> nfcRead() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool nfcConnect = await NfcManager.instance.isAvailable();
    if (nfcConnect == false && mounted) {
      await showDialog(
          context: context,
          builder: (context) {
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
        _scanBarcode = result.value;
        navigateToMaterielScreen(context, _scanBarcode);
      });
    });
  }
    @override
    Widget build(BuildContext context) {
      home:
      return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder:
                        (context) => const Home())),

                icon: const Icon(
                  Icons.home,
                  color: Colors.white70,
                  size: 35.0,

                ),
              ),
            ],
            title: const Text('Chercher un matériel')
        ),
        drawer: const MyDrawer(),
        body: Builder(builder: (BuildContext context) {
          return Container(
              margin: const EdgeInsets.only(
                  left: 10.0, top: 90.0, right: 10.0, bottom: 0.0),
              alignment: Alignment.center,

              child: ListView(

                //direction: Axis.vertical,
                //mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    ElevatedButton.icon(

                        icon: const Icon(Icons.nfc_rounded, size: 50.0,),
                        onPressed: _isButtonDisabled ? null : _handleButtonTap,
                        label: const Text('Lire la puce NFC')
                    ),

                    const Divider(height: 20.0,),



                    ElevatedButton.icon(
                      icon: const Icon(Icons.qr_code_2, size: 50.0,),
                      onPressed: () {
                        /*setState(() {
                          _scanBarcode = '';
                          texte = false;
                          //scanQR();
                          //navigateToBarcodeFragment(context);
                        });*/
                        navigateToScanPage(context);
                            },
                      label: const Text('scanner le QR-Code'),
                    ),


                    const SizedBox(
                      height: 70,
                    ),


                    TextField(
                        controller: _controller,
                        style: const TextStyle(fontSize: 20),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme
                                .of(context)
                                .colorScheme
                                .primary)
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear_rounded),
                            onPressed: () {
                              setState(() {
                                _controller.clear();
                                FocusScope.of(context).unfocus();
                                texte = false;
                                _scanBarcode = '';
                              });
                            },
                          ),
                          label: const Text('Entrer le repère'),
                          /*enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Theme
                                .of(context)
                                .colorScheme
                                .primary),
                            borderRadius: BorderRadius.circular(15),

                          ),*/
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Theme
                                .of(context)
                                .colorScheme
                                .primary),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          _scanBarcode = value;
                          setState(() {
                            if (_scanBarcode != '') {
                              texte = true;
                            }
                            else {
                              texte = false;
                            }
                          });
                        }),


                    const SizedBox(
                      height: 10,
                    ),


                    if((_scanBarcode != '') && (_scanBarcode != '-1'))
                      ElevatedButton(
                          onPressed: () {
                            if (_scanBarcode != '') {
                              try {
                                String textToSendBack = _scanBarcode;
                                navigateToMaterielScreen(
                                    context, textToSendBack);
                              } catch (exception, stack) {
                                showDialog<String>(
                                    context: context,
                                    builder: (
                                        BuildContext context) => const DialogInvalideScan());
                              } // dans classes.};
                            } else {
                              showDialog<String>(
                                context: context,
                                builder: (
                                    BuildContext context) => const DialogInvalideScan(), // dans classes.
                              );
                            }
                          },
                          child: const Text('Valider')),

                    const Divider(),


                  ]

              )


          );
        }),
      );
    }

  }

void navigateToMaterielScreen(BuildContext context, String repe) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MyMaterielDetailPage(rep: repe)));
}

initialValue(val) {
  return TextEditingController(text: val);
}

void navigateToScanPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const QRViewer()));
}