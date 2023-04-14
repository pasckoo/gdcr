/*  TAG  */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'accueil.dart';


ValueNotifier<dynamic> result = ValueNotifier(null);

class MyappTag extends StatefulWidget {
  const MyappTag({Key? key}) : super(key: key);
  // this allows us to access the TextField text

  @override
  createState() => _MyAppTagState();

}

class _MyAppTagState extends State <MyappTag> {
  final TextEditingController controller = TextEditingController();
  String scanTag = '';
  @override
  void initState() {
    super.initState();
    result.value = '';
  }

  // Read a tag record first
  void recRead(){
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final ndefTag = Ndef.from(tag);
      var ndefMessage = ndefTag?.cachedMessage!;
      final wellKnownRecord = ndefMessage?.records.first;
      //skip(1) pour enlever le "en"
      final languageCodeAndContentBytes = wellKnownRecord?.payload.skip(1).toList();// for remove 2 first caracters
      final languageCodeAndContentText = utf8.decode(languageCodeAndContentBytes!);
      final payload = languageCodeAndContentText.substring(2); // for remove 2 first caracters
      result.value = payload;
      NfcManager.instance.stopSession();
      setState(() {
        scanTag = result.value;
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
                      (context) =>const  Home())),

              icon: const Icon(
                Icons.home,
                color: Colors.white70,
                size: 35.0,

              ),
            ),

            /*IconButton(

                onPressed: () {
                  if(_scanTag != '') {
                    try {
                      String textToSendBack = _scanTag;
                      _navigateToMaterielScreen(context, textToSendBack);
                    } catch(exception, stack){showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => const DialogInvalideScan());} // dans classes.};
                  }else{
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => const DialogInvalideScan(), // dans classes.
                    );
                  }
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.yellowAccent,
                  size: 35.0,
                ))*/
          ],
          title: const Text('Recherche')
      ),

      body: Builder(builder: (BuildContext context) {
        return Container(
            alignment: Alignment.center,

            child: FutureBuilder<bool>(
                    future: NfcManager.instance.isAvailable(),
                    builder: (context, ss) => ss.data == true
                ? const Center(child: Text('NFC n\'est pas disponible, vous devez activer NFC '))
                :Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: (){
                            recRead();
                            setState(() {
                              scanTag = result.value;
                            });
                            },
                          child: const Text('Identifier un matériel')),

                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          width: 200.0,

                          child: TextField(
                              controller: initialValue('$scanTag\n'),

                              style: const TextStyle(fontSize: 20),

                              decoration: InputDecoration(
                                //labelText: 'Entrer un identifiant d\'outil',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.red),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  scanTag = value;
                                });
                              }

                          )),

                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: (){
                            recRead();
                            setState(() {
                              result.value = '';
                              scanTag = '';
                            });
                          },
                          child: const Text('Effacer le texte')),

                      const SizedBox(
                        height: 15,
                      ),

                      if(scanTag.isNotEmpty)
                      ElevatedButton(
                          onPressed: (){
                            String textToSendBack = scanTag;
                            //_navigateToMaterielScreen(context, textToSendBack);
                          },
                          child: const Text('Chercher')),
                    ]

            )

          )
        );
      }),
    );
  }

  initialValue(val) {
    return TextEditingController(text: val);
  }

  /*void _navigateToMaterielScreen(BuildContext context,String repe) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyMaterielDetailPage(rep:repe)));
  }*/
}

void enableNFC(){
 // mNfcAdapter = NfcAdapter.getDefaultAdapter(this.getApplicationContext());
}

/*void _navigateToMaterielScreen(BuildContext context,String repe) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListToolsPage(rep:repe)));
}*/