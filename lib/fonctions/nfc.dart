/* NFC */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';


ValueNotifier<dynamic> result = ValueNotifier(null);

// Read tag
void tagRead() {
  NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    result.value = tag.data;
    NfcManager.instance.stopSession();
  });
}

// Read a tag record first
String? recRead(){
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
    return result.value;
  });
  return null;

}

void effacer(){
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
    } catch (e) {
      result.value = e;
      NfcManager.instance.stopSession(errorMessage: result.value.toString());
      return;
    }
  });

}

// Write into the tag
void ndefWrite(String ref) {
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
    } catch (e) {
      result.value = e;
      NfcManager.instance.stopSession(errorMessage: result.value.toString());
      return;
    }
  });

}

/*void _ndefWriteLock() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null) {
        result.value = 'Tag is not ndef';
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }

      try {
        await ndef.writeLock();
        result.value = 'Success to "Ndef Write Lock"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }*/
