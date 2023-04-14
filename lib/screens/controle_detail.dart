import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../classes/dialogs.dart';
import 'CB.dart';
import '../repository/controleRepository.dart';
import '../controller/controle_controller.dart';
import '../classes/menu.dart';
import'package:gdcr/fonctions/globals.dart';

import 'accueil.dart';



class MyControleDetailPage extends StatefulWidget {
  final String  idControle;
  const MyControleDetailPage({Key? key, required this.idControle}) : super(key: key);

  @override

  State<MyControleDetailPage> createState() => _MyControleDetailPageState();

}

class _MyControleDetailPageState extends State<MyControleDetailPage> {

  final controleController = ControleController(ControleRepository());

  String repere = '';


  @override

  Widget build(BuildContext context) {
    String? repMateriel;
    String? perioControle;
    String? dateControle;
    String? commentControle;
    return Scaffold(
      //backgroundColor: Colors.blueGrey,


      appBar: AppBar(
        title: Text('Contrôle N° ${widget.idControle}'),
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
      body:
      FutureBuilder(
          future: controleController.controleFetch(widget.idControle),
          builder: (BuildContext context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('rien à afficher');  //snapshot.error.toString()
            }

            final data = snapshot.data;
            var controle = jsonDecode(data.toString());

            dateControle = getFormatedDate(controle[0]['date_controle']).toString();
            repMateriel = controle[0]['rep_materiel'].toString();
            perioControle = controle[0]['intitule_perio'].toString();
            commentControle = controle[0]['comment_controle'].toString();

            return ListView(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 10.0, right: 20.0, bottom: 70.0),
                children: <Widget>[

                  TextFormField(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                    initialValue: getFormatedDate(controle[0]['date_controle']).toString(),
                    enabled: false,
                    //readOnly: true,
                    decoration: const InputDecoration(
                      filled: true,
                      //fillColor: Colors.white,
                      labelText: 'Contrôle effectué le',
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
                        fontSize: 20),
                    textAlign: TextAlign.center,
                    initialValue: controle[0]['rep_materiel'].toString(),
                    enabled: false,
                    decoration: const InputDecoration(
                      filled: true,
                      //fillColor: Colors.white,
                      labelText: 'Repère matériel',
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
                        fontSize: 20),

                    textAlign: TextAlign.center,
                    initialValue: controle[0]['intitule_perio'].toString(),
                    enabled: false,
                    decoration: const InputDecoration(
                      filled: true,
                      //fillColor: Colors.white,
                      labelText: 'Périodicité',
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
                        fontWeight: FontWeight.normal,
                        fontSize: 20),

                    textAlign: TextAlign.center,
                    initialValue: controle[0]['login_user'].toString(),
                    //readOnly: true,
                    enabled: false,
                    decoration: const InputDecoration(
                      filled: true,
                      //fillColor: Colors.white,
                      labelText: 'Contrôleur',
                      /*enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),*/
                    ),
                  ),
                  //const Divider(),
                  TextFormField(
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20),

                    textAlign: TextAlign.center,
                    initialValue: controleSuivantFait((controle[0]['suivant_fait']).toString()),//(controle[0]['suivant_fait']).toString(),
                    //readOnly: true,
                    enabled: false,
                    decoration: const InputDecoration(
                      filled: true,
                      //fillColor: Colors.white,
                      labelText: 'controle suivant fait',
                    ),
                  ),

                  //const Divider(),
                  TextFormField(
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16),

                    textAlign: TextAlign.start,
                    initialValue: controle[0]['comment_controle'].toString(),
                    enabled: false,
                    decoration: const InputDecoration(
                      filled: true,
                      //fillColor: Colors.white,
                      labelText: 'Commentaires suite à ce contrôle',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.blue),
                        //borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ]
            );
          }

      ),


      /*floatingActionButton: FloatingActionButton.extended(

        onPressed: ()
        {
          if(globalsActive == true){
            showDialog(
              barrierDismissible: false,
              // l'utilisateur doit presser un bouton pour sortir! (modale)
              context: context,
              builder: (context) => DialogModifControle(
                  dateControle: dateControle.toString(),
                  controleId: widget.idControle,
                  rep: repMateriel.toString(),
                  perio: perioControle.toString(),
                  commentaires: commentControle.toString(),),

            );
          }else{
            showDialog(
                barrierDismissible: false,
                // l'utilisateur doit presser un bouton pour sortir! (modale)
                context: context,
                builder: (context) => const DialogNonModif());
          }
        },
        label: const Text('Modifier ce contrôle'),
        icon: const Icon(Icons.search_rounded),
        backgroundColor: Colors.blue,
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );

  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyappCB(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      repere = result;
    });
  }
  getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  controleSuivantFait(String fait){
    if (fait == '0'){return 'Non';}else{return 'Oui';}
  }

  void _navigateToCBScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
  }
}



