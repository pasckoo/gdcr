import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../screens/materiel_detail.dart';
import 'bdd/mysql.dart';
import 'model/materiel_model.dart';


class MyappCB extends StatefulWidget {
  const MyappCB({Key? key}) : super(key: key);
  // this allows us to access the TextField text

  @override
  createState() => _MyAppState();

}

class _MyAppState extends State <MyappCB>{
  String _scanBarcode = '';
  String toto = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  /*Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Erreur';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }*/

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
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

  @override

  Widget build(BuildContext context) {
    //String textToSendBack;
    return MaterialApp(
        home: Scaffold(
            appBar:
            AppBar(
              actions: [IconButton(

                  onPressed: () {
                    String textToSendBack = _scanBarcode;
                    //Navigator.pop(context, textToSendBack);
                    _navigateToMaterielScreen(context, textToSendBack);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.yellowAccent,
                    size: 35.0,

                  ),
              )],
                title: const Text('Sélection d\'un matériel')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,

                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: const Text('scanner le code-barre')),

                        const SizedBox(
                          height: 30,
                        ) ,
                        SizedBox(
                            width: 200.0,

                            child: TextField(
                            controller: initialValue('$_scanBarcode\n'),
                            style: const TextStyle(fontSize: 20),

                            decoration: InputDecoration(
                              labelText: 'Entrer un repère matériel',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                            ),
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                            ],
                            onChanged: (value) => _scanBarcode = value,

                        )),

                        const SizedBox(
                          height: 30,
                        ) ,

                        ]

                 )

              );
                 }),
          /*bottomNavigationBar: BottomNavigationBar(

          backgroundColor: Colors.orangeAccent,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Accueil",
            ),
            BottomNavigationBarItem(
              label: 'Matériel',
              icon: Icon(Icons.qr_code),

            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
          )*/
        ));


  }

  initialValue(val){
    return TextEditingController(text: val);
  }

  void _navigateToMaterielScreen(BuildContext context,String repe) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyMaterielDetailPage(rep:repe)));
  }
}

