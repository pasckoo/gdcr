
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../fonctions/globals.dart';
import '../screens/connexion.dart';

class MyBiometrics extends StatefulWidget {
  const MyBiometrics({Key? key}) : super(key: key);

  @override
  State<MyBiometrics> createState() => _MyAppState();
}

class _MyAppState extends State<MyBiometrics> {
  final LocalAuthentication auth = LocalAuthentication();
  MyConnexion connexion = const MyConnexion();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Non autorisé';
  bool _isAuthenticating = false;
  bool isSupported = false;
  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      //print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  /*Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authentification';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Laisser l\'OS déterminer la méthode d\'authentification',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Erreur - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
      () => _authorized = authenticated ? 'Autorisé' : 'Non autorisé');
  }*/

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
        setState(() {
        _isAuthenticating = true;
        _authorized = 'Authentification';
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scannez votre empreinte digitale pour vous authentifier',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authentification';
       // ici
        globalFingerPrint = true;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Erreur - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Autorisé' : 'Non autorisé';
    setState(() {
      _authorized = message;

    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {

    return Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*if (_supportState == _SupportState.unknown)
                const CircularProgressIndicator()
              else if (_supportState == _SupportState.supported)
                const Text('Cet appareil est compatible')
              else
                const Text('Cet appareil n\'est pas compatible'),
              //const Divider(height: 100),
              Text('Peut vérifier la biométrie: $_canCheckBiometrics\n'),
              ElevatedButton(
                onPressed: _checkBiometrics,
                child: const Text('vérifier la biométrie'),
              ),*/
              //const Divider(height: 100),
              //Text('Données biométriques disponibles: $_availableBiometrics\n'),
              /*ElevatedButton(
                onPressed: _getAvailableBiometrics,
                child: const Text('Obtenir les données biométriques disponibles'),
              ),*/
              //const Divider(height: 100),
              //Text('$_authorized\n'),

               /*ElevatedButton(
                  onPressed: _cancelAuthentication,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text('Annuler l\'authentification '),
                      Icon(Icons.cancel),
                    ],
                  ),
                ),*/

                Column(
                  children: <Widget>[
                    /*ElevatedButton(
                      onPressed: _authenticate,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Text('Authentifié'),
                          Icon(Icons.perm_device_information),
                        ],
                      ),
                    ),*/

                    IconButton(
                      iconSize: 50,
                      icon: const Icon(Icons.fingerprint_rounded, color: Colors.blueAccent,),
                      onPressed: () {
                        _authenticateWithBiometrics();

                      },
                    ),
                  ],
                )
]



    );
  }
}



enum _SupportState {
  unknown,
  supported,
  unsupported,
}
