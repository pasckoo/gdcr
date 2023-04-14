import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdcr/screens/controle_list.dart';
import 'package:intl/intl.dart';
import '../classes/dialogs.dart';
import 'CB.dart';
import '../repository/materielRepository.dart';
import '../controller/materiel_controller.dart';
import '../classes/menu.dart';
import'package:gdcr/fonctions/globals.dart';
import 'accueil.dart';



class MyMaterielDetailPage extends StatefulWidget {
  final String rep;
   const MyMaterielDetailPage({Key? key, required this.rep}) : super(key: key);


  @override

  State<MyMaterielDetailPage> createState() => _MyMaterielDetailPageState();

}

class _MyMaterielDetailPageState extends State<MyMaterielDetailPage> {

  final materielController = MaterielController(MaterielRepository());
  final snackKey = GlobalKey();
  String repere = '';
  String periode = '';
  String nb_controles = '';

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Détails matériel'),
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

        ],
      ),
      drawer: const MyDrawer(), // appel à la classe menu
      body: FutureBuilder(
                  future: materielController.materielFetch(widget.rep),
                  builder: (BuildContext context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('pas de connexion');  //snapshot.error.toString()
                }

                final data = snapshot.data;
                var materiel = jsonDecode(data.toString());

                if(materiel['rien'] == "rien"){
                  //_navigateToCBScreen(context);
                  return const Center(
                      child: DialogRepInconnu(),


                    /*Text('Repère *${widget.rep}* inconnu',
                       style: const TextStyle(fontSize: 20),
                      )*/
                  );
                }

                periode = materiel['periode'].toString();
                nb_controles = materiel['nb_controle'].toString();

                  return ListView(
                      key: UniqueKey(),
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 10.0, right: 20.0, bottom: 70.0),
                      children: <Widget>[

                      /*ActionChip( // pour faire un badge
                        padding: const EdgeInsets.all(0),
                        //tooltip: 'C\'est un toolTip',
                        backgroundColor: dateColor(materiel['controleAvantLe']),
                        label: Text(materiel['rep'],
                            style: const TextStyle(color: Colors.black54,
                            fontSize: 25),
                        ), onPressed: () {  },
                      ),*/

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

                            alignment: WrapAlignment.center,
                            children:  [
                              ActionChip( // pour faire un badge
                                padding: const EdgeInsets.all(0),
                                //tooltip: 'C\'est un toolTip',
                                backgroundColor: dateColor(materiel['controleAvantLe']),
                                label: Text(materiel['rep'],
                                  style: const TextStyle(color: Colors.black54,
                                      fontSize: 25),
                                ), onPressed: () {  },
                              ),

                              const Divider(
                                height: 0.0,
                              ),

                              dateColorText(materiel['controleAvantLe']) as Widget,

                              const Divider(
                                height: 10.0,
                              ),

                            ],
                          ),

                    ),


                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16),

                          textAlign: TextAlign.center,
                          initialValue: materiel['desi'],
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            labelText: 'Désignation',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blue),
                              //borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),

                        /*TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                          textAlign: TextAlign.center,
                          initialValue: Badge(
                            badgeContent: Text(materiel['rep']),
                          ).toString(),
                          enabled: false,
                          readOnly: true,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Repère',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 5, color: Colors.blue),

                            ),
                          ),
                        ),*/
                        //const Divider(),

                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                          initialValue: materiel['famille'].toString(),
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            labelText: 'Famille',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 5, color: Colors.blue),
                            ),
                          ),
                        ),
                        //const Divider(),

                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16),

                          textAlign: TextAlign.center,
                          initialValue: materiel['modele'],
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            labelText: 'Modèle',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blue),
                              //borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        /*const Divider(
                thickness: 5,
                color: Colors.blueAccent,
                indent: 20,
                endIndent: 20,
              ),*/
                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20),

                          textAlign: TextAlign.center,
                          initialValue: getFormatedDate(
                              materiel['controleAvantLe']),
                          readOnly: true,
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            labelText: 'Prochain contrôle avant le:',
                            /*enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),*/
                          ),
                        ),
                        //const Divider(),
                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20),

                          textAlign: TextAlign.center,
                          initialValue: materiel['periode'],
                          readOnly: true,
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            labelText: 'Ce sera une périodicité',
                            /*enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.select_all),
                        onPressed: () =>
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  const DialogPeriodicite(), // dans classes.dart
                            ),
                      )*/
                          ),
                        ),

                        //const Divider(),
                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16),

                          textAlign: TextAlign.center,
                          initialValue: getFormatedDate(materiel['mes']),
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            labelText: 'Mis en service le:',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blue),
                              //borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        //const Divider(),
                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16),

                          textAlign: TextAlign.center,
                          initialValue: materiel['secteur'],
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            labelText: 'Secteur',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blue),
                              //borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        //const Divider(),

                        //const Divider(),
                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16),

                          textAlign: TextAlign.center,
                          initialValue: materiel['ref'],
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            labelText: 'Référence',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blue),
                              //borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        //const Divider(),
                        TextFormField(
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16),

                          textAlign: TextAlign.center,
                          initialValue: materiel['comm'],
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            //fillColor: Colors.white,
                            labelText: 'Commentaire matériel',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blue),
                              //borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        //const Divider(),
                      ]
                  );

        }

      ),



      bottomNavigationBar: BottomAppBar(
        //color: Colors.blueAccent,
        elevation: 10.0,
        child: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if(globalsLogin != null) // Pour vérifier s'il y a eu une connexion par user et MdP
            OutlinedButton(
              /*style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
              ) ,*/
              onPressed: () async {
                  if(globalsActive == true){
                    showDialog(
                      barrierDismissible: false,
                      // l'utilisateur doit presser un bouton pour sortir! (modale)
                      context: context,
                       builder:(BuildContext context)=>DialogAjoutControle(rep: widget.rep, perio: periode),
                    );
                  }else{
                    showDialog(
                        barrierDismissible: false, // l'utilisateur doit presser// un bouton pour sortir! (modale)
                        context: context,
                        builder: (context) => const DialogAutorisation());
                  }


              },
                child: const Text('Contrôler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            OutlinedButton(
              /*style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
              ) ,*/
              onPressed: () {
                //Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyControleListPage(rep: widget.rep, nbControles: nb_controles,)));

              },
              child: const Text('Voir les contrôles',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
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





