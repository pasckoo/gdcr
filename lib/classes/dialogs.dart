
import 'package:gdcr/screens/controle_list.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gdcr/fonctions/globals.dart';
import '../classes/listDeroulante.dart';
import '../controller/perio_controller.dart';
import '../fonctions/nfc.dart';
import '../repository/controleRepository.dart';
import '../controller/controle_controller.dart';
import '../repository/perioRepository.dart';
import '../fonctions/globals.dart';
import '../../screens/prog_nfc.dart';


class DialogEcrireNFC extends StatelessWidget {
  DialogEcrireNFC({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  String scanTag = '';
  bool texte = false;

  @override

  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),

      title: const Text('ECRIRE / MODIFIER',
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
                  //FocusScope.of(context).unfocus();
              },
            ),
            label: const Text('Nouveau repère', style: TextStyle(fontSize: 16.0),),
          ),
          textAlign: TextAlign.center,
          onChanged: (value){
            scanTag = value;
            /*if(scanTag != ''){texte = true;}
            else{texte = false;}*/

          }),

      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),


        TextButton(
          onPressed: () {
            if(_controller.text != '') {
              print(_controller.text);
              Navigator.pop(context, _controller.text);

             }
          },
          child: const Text('Ecrire'),
        ),

      ],
    );
  }
}


class DialogAfficheNFC extends StatelessWidget {
  const DialogAfficheNFC({Key? key, required this.texte}) : super(key: key);
  final String texte;

  @override
  build(BuildContext context){
    return AlertDialog(
      title: Text(
        texte,
        textAlign: TextAlign.center,
        ),
      content: const Text(
        'approcher l\'appareil de la puce NFC',
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      actions: <Widget>[
        Image.asset(
          'assets/images/tagNFC.jpg',
          height: 400,
          fit: BoxFit.cover,
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
      ],
    );
  }
}


class DialogTaggerNFC extends StatelessWidget {
  const DialogTaggerNFC({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('INFORMATION',
        textAlign: TextAlign.center,),

      content: const Text(
        'La puce NFC est écrite',
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
          child: const Text('OK'),
        ),

      ],
    );
  }
}


class DialogEffaceNFC extends StatelessWidget {
  const DialogEffaceNFC({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('INFORMATION',
        textAlign: TextAlign.center,),

      content: const Text(
        'La puce NFC est effacée',
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
          child: const Text('OK'),
        ),

      ],
    );
  }
}

class DialogNonNFC extends StatelessWidget {
  const DialogNonNFC({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('INFORMATION',
        textAlign: TextAlign.center,),

      content: const Text(
        'Vous devez activer la fonction NFC sur votre appareil' ,
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),

      ],
    );
  }
}

class DialogRepInconnu extends StatelessWidget {
  const DialogRepInconnu({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('INFORMATION',
        textAlign: TextAlign.center,),

      content: const Text(
        'Repère inconnu' ,
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop('dialog');
            },
          child: const Text('OK'),
        ),

      ],
    );
  }
}


class DialogChangeColor extends StatelessWidget {
  const DialogChangeColor({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('INFORMATION',
        textAlign: TextAlign.center,),

      content: const Text(
        'La nouvelle couleur sera appliquée au prochain lancement de l\'application' ,
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),

      ],
    );
  }
}


class DialogIncompatible extends StatelessWidget {
  const DialogIncompatible({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('INFORMATION',
        textAlign: TextAlign.center,),

      content: const Text(
        'Non autorisé\n Vous devez vous connecter\n via les identifiants' ,
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),

      ],
    );
  }
}


class DialogInvalideScan extends StatelessWidget {
  const DialogInvalideScan({Key? key}) : super(key: key);

  @override

  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('INFORMATION',
        textAlign: TextAlign.center,),

      content: const Text(
        'Vous devez entrer un repère' ,
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),

      ],
    );
  }
}


class DialogInvalideConnexion extends StatelessWidget {
  const DialogInvalideConnexion({Key? key}) : super(key: key);

  @override

  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('Connexion',
        textAlign: TextAlign.center,),

      content: const Text(
        'Idendifiant ou mot de passe invalide' ,
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),

      ],
    );
  }
}

class DialogAutorisation extends StatelessWidget {
  const DialogAutorisation({Key? key}) : super(key: key);

  @override

  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: Text(globalsLogin.toString(),
        textAlign: TextAlign.center,),

      content: const Text(
        'Vous n\'êtes pas habilité à contrôler un matériel' ,
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Retour'),
        ),

      ],
    );
  }
}

class DialogNbControles extends StatelessWidget {
  const DialogNbControles({Key? key}) : super(key: key);

  @override

  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: Text(globalsNbControles.toString(),
        textAlign: TextAlign.center,),

      content: const Text(
        'Contrôles' ,
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),

      ],
    );
  }
}

class DialogNonModif extends StatelessWidget {
  const DialogNonModif({Key? key}) : super(key: key);

  @override

  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: Text(globalsLogin.toString(),
        textAlign: TextAlign.center,),

      content: const Text(
        'Vous n\'êtes pas autorisé à modifier un contrôle' ,
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('RETOUR'),
        ),

      ],
    );
  }
}


class DialogControles extends StatelessWidget {
  const DialogControles({Key? key}) : super(key: key);

  @override

  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('INFORMATION',
        textAlign: TextAlign.center,),

      content: const Text(
        'Il n\'y a aucun contrôle à afficher',
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),

      ],
    );
  }
}


class DialogQuitter extends StatelessWidget {
  const DialogQuitter({Key? key}) : super(key: key);

  @override

   build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),

      title: const Text('DECONNEXION',
        textAlign: TextAlign.center,),
      content: const Text(
        'Vous allez être déconnecté de l\'application',
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),

        TextButton(
          onPressed: () => exit(0),
          child: const Text('Déconnecter'),
        ),
      ],
    );
  }
}


class DialogConnexion extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  var materielController=PerioController(PerioRepository());
  DialogConnexion({Key? key}) : super(key: key);
  @override
  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('Mot de passe oublié'),
      content: Wrap(
        children: <Widget>[
          const Text('Un administrateur va vous envoyer un mot de passe provisoire'),
          TextFormField(
            controller: _controller,

            onChanged: (value) => value,
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
              labelText: 'email',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class DialogAjoutControle extends StatelessWidget {
  DialogAjoutControle({Key? key, required this.rep, this.perio, this.nbControles}) : super(key: key);
  final String rep;
  final String? perio;
  final String? nbControles;


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final  myController = TextEditingController();
    TextEditingController dateinput = TextEditingController();
    final controleController = ControleController(ControleRepository());
    var myPerio = DeroulantePerio(rep: rep);
    var myControleur = DeroulanteControleur();
    String dateControle = getFormatedDate(DateTime.now().toString());
    String commentaire = '';

    return Scaffold(
      backgroundColor: Colors.transparent,
        body: AlertDialog(
             //actionsPadding: const EdgeInsets.fromLTRB(5, 50, 5, 50),
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10)),

               title: Wrap(children: <Widget>[

                 Row(children: const [
                   Icon(
                     Icons.fact_check,
                     //color: Colors.blueAccent,
                     size: 35,),
                       Text(
                         '  Ajouter un contrôle',
                         textAlign: TextAlign.center,
                         style: TextStyle(
                             fontWeight: FontWeight.normal,
                             fontSize: 20),
                       ),

                   ],
                 ),
               ]),
               content: SingleChildScrollView(
                  child: ListBody(

                      children: <Widget>[

                     Form(
                     key: _formKey,
                       child: Column(
                         children: <Widget>[
                             TextFormField(
                              // controller: TextEditingController(text: dateControle),
                               controller: dateinput,
                                 validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return 'Sélectionnez une date';
                                   }
                                   return null;
                                 },
                               readOnly: false,
                               onChanged: (value) => value,
                               decoration: InputDecoration(
                                 suffixIcon: const Icon(Icons.calendar_month_rounded),
                                 labelText: 'Date du contrôle',
                                   enabledBorder: OutlineInputBorder(
                                     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                     borderSide: BorderSide(
                                         width: 1, color: Theme.of(context).colorScheme.primary),
                                 ),
                               ),
                               onTap: () async {
                               DateTime? pickedDate = await showDatePicker(
                               context: context,
                               initialDate: DateTime.now(),
                               firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                               lastDate: DateTime(2100),
                                 cancelText: 'Annuler',
                                 helpText: 'SELECTIONNER UNE DATE',
                               );
                               if(pickedDate != null ) {
                                 //print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                 String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate);
                                 //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                 //you can implement different kind of Date Format here according to your requirement


                                 dateinput.text = formattedDate; //set output date to TextField value.

                               }

                               }
                           ),
                           const Divider(),

                             TextFormField(
                               readOnly: true,
                               controller: TextEditingController(text: rep),
                               validator: (value) {
                                 if (value == null || value.isEmpty) {
                                   return 'Veuillez entrer une valeur';
                                 }
                                 return null;
                               },
                               onChanged: (value) => value,
                               decoration: InputDecoration(
                                 //icon: Icon(Icons.private_connectivity),
                                 labelText: 'Repère',
                                 enabledBorder: OutlineInputBorder(
                                   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                   borderSide: BorderSide(
                                       width: 1, color: Theme.of(context).colorScheme.primary),
                                 ),
                               ),
                             ),
                           const Divider(),
                           myPerio,
                           const Divider(),
                           //myControleur,
                           TextFormField(
                             readOnly: true,
                             initialValue: globalsLogin,
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Veuillez entrer une valeur';
                               }
                               return null;
                             },
                             onChanged: (value) => value,
                             decoration: InputDecoration(
                               //icon: Icon(Icons.private_connectivity),
                               labelText: 'Contrôleur',
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                 borderSide: BorderSide(
                                     width: 1, color: Theme.of(context).colorScheme.primary),
                               ),
                             ),
                           ),


                           const Divider(),

                           TextFormField(
                            // controller: commentaire,
                             keyboardType: TextInputType.multiline,
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return ' Entrez un commentaire';
                               }
                               return null;
                             },
                             minLines: 1,
                             maxLines: 5,
                             onChanged: (value) => commentaire = value,
                             decoration: InputDecoration(
                               //icon: Icon(Icons.private_connectivity),
                               labelText: 'Commentaire',
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                 borderSide: BorderSide(
                                     width: 1, color: Theme.of(context).colorScheme.primary),
                               ),
                       ),
             ),
             ]
            ),
           )
           ],

         )),
               actions: <Widget>[

               TextButton(
                 onPressed: () {
                   Navigator.of(context).pop();
                 },

                 child: const Text('Annuler'),
               ),

               TextButton(
                 onPressed: () { // "validate" renvois true si le formulaire est valide,
                   // ou false sinon.
                     if ( _formKey.currentState!.validate ()) {
                       controleController.createPatchCompleted(
                         dateinput.text,
                         rep,
                         myPerio.retour,
                         globalsLogin.toString(),
                         commentaire
                       );

                       ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10.0)
                               ),
                               behavior: SnackBarBehavior.floating,
                               backgroundColor: Colors.green,
                               duration: const Duration(seconds: 2),
                               content: const SizedBox(
                                   height: 30.0,
                                   child: Center(
                                     child: Text('Envoi en cours...'),
                                   )
                               )
                           )
                       );
                       Future.delayed(const Duration(milliseconds: 2500), () {
                         Navigator.of(context).pop(true);
                       });
                     }

                     },

                 child: const Text('Valider'),
           ),

         ]
        ));
  }

}




