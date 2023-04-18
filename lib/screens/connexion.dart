import 'package:flutter/material.dart';
import '../classes/dialogs.dart';
import '../controller/user_controller.dart';
import '../fonctions/globals.dart';
import '../repository/userRepository.dart';
import 'accueil.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'dart:async';




class MyAppC extends StatelessWidget {
  const MyAppC({Key? key}) : super(key: key);

  static const String _title = 'Connexion';

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyConnexion(),
      );
    //);
  }
}

class MyConnexion extends StatefulWidget {
  const MyConnexion({Key? key}) : super(key: key);

  @override
  State<MyConnexion> createState() => _MyConnexionWidgetState();
}

class _MyConnexionWidgetState extends State<MyConnexion> {
  var userController = UserController(UserRepository());
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //var _obscureText = false; // Pour masquer ou voir le mot de passe
  bool _isPasswordVisible = false;

  final LocalAuthentication auth = LocalAuthentication();
  MyConnexion connexion = const MyConnexion();
  _SupportState _supportState = _SupportState.supported;
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
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Authentification requise',
            cancelButton: 'Annuler',
            biometricHint: '',
          ),

        ],
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
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => const DialogIncompatible(), // dans classes.
        );
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Autorisé' : 'Non autorisé';
    setState(() {
      if(message == 'Autorisé') {
        _authorized = message;
        //_obscureText = true;

        biometricConnexion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    globalsLogin = '';
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bienvenue'),
         centerTitle: true,


          ),


        //padding: const EdgeInsets.all(10),
        body: ListView(


          children: <Widget>[


            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                child: const Text(
                  '\nGestion des contrôles réglementaires',
                  textAlign: TextAlign.center,
                  style: TextStyle(

                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            const Divider(
              //color: Colors.blueAccent,
              height: 30,
              thickness: 1,
            ),

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Identification',
                  style: TextStyle(
                    fontSize: 20,
                    //color: Colors.blueAccent,
                  ),
                )),
            Form(
              key: _formKey,
              child: Wrap(

                children: [
                  Container(
                    margin: globalMargin(),

                    //padding: const EdgeInsets.all(10),
                    child: TextFormField(

                      controller: mailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: globalBackgroundColor(context, colorBackground),
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),


                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: !_isPasswordVisible,
                      // pour voir ou non le mot de passe
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un mot de passe';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: globalBackgroundColor(context, colorBackground),
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelText: 'Mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        )),


                        /* !_obscureText?const Icon(Icons.visibility)
                            :const Icon(Icons.visibility_off),*/

                     /* onTap: () {
                        setState(() {
                          _obscureText = !_obscureText; // sur tap, on voit ou masque le MdP
                        });
                      },*/
                    ),
                  ),
                ],

              ),),

            TextButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  // l'utilisateur doit presser un bouton pour sortir! (modale)
                  context: context,
                  builder: (context) => DialogConnexion(),

                );
              },
              child: const Text('Mot de passe oublié ?',),
            ),


            /*const Divider(
              color: Colors.white60,
              height: 10,
            ),*/

            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String connex = await userController.fetchUserConnexion(
                          mailController.text, passwordController.text);
                      await Future.delayed(const Duration(seconds: 1));
                      if (connex == "1" && mounted) {
                        globalsLogin = mailController.text;
                        verifControleur(mailController.text);
                        remplissageVarUser(mailController.text);
                        Navigator.of(context).pop();
                        _navigateToHomePage(context);
                      }
                      else {
                        showDialog(
                          barrierDismissible: false,
                          // l'utilisateur doit presser un bouton pour sortir! (modale)
                          context: context,
                          builder: (context) => const DialogInvalideConnexion(),
                        );
                      }
                      //homePage(context);
                    }
                  },
                  child: const Text('VALIDER'),
                )
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(
                height: 70,
                thickness: 1,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),


            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 5.0),
                child: const Text(
                  'Connexion biométrique',
                  style: TextStyle(
                    fontSize: 16,
                    //color: Colors.blueAccent,
                  ),
                )),

            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  //shape: const CircleBorder(),
                  padding: const EdgeInsets.all(0),
                  //primary: Colors.blue
                ),
                child: const Icon(Icons.fingerprint_rounded, color: Colors.white, size: 40),
                onPressed: () {
                  globalFingerPrint = false;
                  _authenticateWithBiometrics();
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(
                height: 90,
                thickness: 1,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),


            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(

                  padding: const EdgeInsets.all(0),
                  //primary: Colors.blue
                ),
                child: const Text('Entrer en lecture seule'),
                onPressed: () {
                  //globalFingerPrint = false;
                 // _authenticateWithBiometrics();

                  _navigateToHomePage(context);
                },
              ),
            ),


            /*const Divider(
              height: 30,
              thickness: 1,
              color: Colors.blueAccent,
            ),*/
          ],
        )
    );
  }

  biometricConnexion() async {
      setState(() async {
        String connec = await userController.fetchUserConnexion(
            "pascal@gillotin", "Bonjour01@");
        //await Future.delayed(const Duration(milliseconds: 300));
        if (connec == "1" && mounted) {
          globalsLogin = "pascal@gillotin";
          verifControleur(globalsLogin!);
          remplissageVarUser("pascal@gillotin");
          Navigator.of(context).pop();
          _navigateToHomePage(context);
        }
      }
      );

  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}




Future<void> _navigateToHomePage(context) async {

  await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),));
}







