import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdcr/screens/reglages.dart';
import '../classes/dialogs.dart';
import '../classes/graphique.dart';
import '../classes/menu.dart';
import '../controller/perio_controller.dart';
import '../repository/perioRepository.dart';
import 'CB.dart';
import 'controle_30jours.dart';
import 'controle_list.dart';
import 'controle_retard.dart';
import'../fonctions/globals.dart';
import 'materiel_selection.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}
class _HomeState extends State<Home> {
  var retardController= PerioController(PerioRepository());
  var joursController= PerioController(PerioRepository());




  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
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
      drawer: const MyDrawer(),
      body: Wrap(

          children: [
            /*Container(
              alignment: Alignment.center,
              child: const Text('Gestion Des Contrôles Réglementaires',
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  )),
            ),*/

            FutureBuilder(
                future: retardController.fetchRetardControleList(),

                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  final data = snapshot.data;
                  final resultat = json.decode(data.toString());

                  int tard = resultat[0]['nbRetard'];
                  int prochain = resultat[1]['nbProchain'];
                  int reste = resultat[2]['nbReste'];
                  int total = tard + prochain + reste;
                  String strTotal = total.toString();


                      //crossAxisAlignment: CrossAxisAlignment.center,
                      child: const Text('Gestion Des Contrôles Réglementaires');



                  return PieChartSample2(retard: tard, prochain: prochain, reste: reste);

                }),
            const Divider(
              height:20,
              thickness: 0,
              indent: 0,
              endIndent: 0,
              //color: Colors.blueAccent,
            ),
            Container(
                //color: Colors.white,
                //shadowColor: Colors.blueGrey,
                //elevation: 0,
                margin: const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 10.0),
                //shape: RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(5),),

                child: FutureBuilder(
                    future: retardController.fetchRetardControleList(),

                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }

                      final data = snapshot.data;
                      final resultat = json.decode(data.toString());

                      int tard = resultat[0]['nbRetard'];
                      int prochain = resultat[1]['nbProchain'];
                      int reste = resultat[2]['nbReste'];
                      int total = tard + prochain + reste;
                      String strTotal = total.toString();

                      return affichageControle(total, tard, prochain, context);


                    }
                )
            ),

            const Divider(),

            //************* Boutons accès rapide ****************************

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

                children:[
                  Container(
                      height: 100,
                      width: 100,
                    margin: const EdgeInsets.only(left:10.0,top:0.0,right:10.0,bottom:0.0),
                      //padding: const EdgeInsets.only(left:0.0,top:0.0,right:0.0,bottom:0.0),
                    decoration: BoxDecoration(
                      color: globalBackgroundColor(context, colorBackground),
                      borderRadius: BorderRadius.circular(10),
                      border:  Border.all(color: globalBorderColor(context, borderColor),),
                      boxShadow: globalContainerShadow(),
                    ),
                        child:OutlinedButton(
                                onPressed: () {
                                  _navigateToMaterielSelectionScreen(context);
                                },
                              child:Column( // Replace with a Row for horizontal icon + text

                                  children: <Widget>[
                                    const SizedBox(
                                      height: 20,
                                      width: 20,
                                    ),
                                      Icon(Icons.handyman_rounded, size: 40.0,
                                        color: Theme.of(context).primaryColor,
                                        //shadows: globalContainerShadow(),
                                      ),
                                      const Divider(height: 10,),
                                      const Text("Matériels", style: TextStyle(color: Color(0xff808080)),)
                                  ],
                                ),
                        ),
                    ),

                    const Spacer(),

                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(left:10.0,top:0.0,right:10.0,bottom:0.0),
                      decoration: BoxDecoration(
                        color: globalBackgroundColor(context, colorBackground),
                        borderRadius: BorderRadius.circular(10),
                        border:  Border.all(color: globalBorderColor(context, borderColor),),
                        boxShadow: globalContainerShadow(),
                      ),
                      child:OutlinedButton(
                        onPressed: () {
                          _navigateToControleListScreen(context);
                        },
                        child:Column( // Replace with a Row for horizontal icon + text

                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                              width: 20,
                            ),
                            Icon(Icons.checklist_rtl, size: 40.0,
                              color: Theme.of(context).primaryColor,
                              //shadows: globalContainerShadow(),
                            ),
                            const Divider(height: 10,),
                            const Text("Contrôles", style: TextStyle(color: Color(0xff808080)),)
                          ],
                        ),
                      ),
                    ),

                  const Spacer(),

                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(left:10.0,top:0.0,right:10.0,bottom:0.0),
                      decoration: BoxDecoration(
                        color: globalBackgroundColor(context, colorBackground),
                        borderRadius: BorderRadius.circular(10),
                        border:  Border.all(color: globalBorderColor(context, borderColor),),
                        boxShadow: globalContainerShadow(),
                      ),
                      child:OutlinedButton(
                        onPressed: () {
                          _navigateThemeScreen(context);
                        },
                        child:Column( // Replace with a Row for horizontal icon + text

                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                              width: 20,
                            ),
                            Icon(Icons.settings, size: 40.0,
                              color: Theme.of(context).primaryColor,
                              //shadows: globalContainerShadow(),
                            ),
                            const Divider(height: 10,),
                            const Text("Réglages", style: TextStyle(color: Color(0xff808080)),)
                          ],
                        ),
                      ),
                    ),

                ]
            ),
          ]
      ),

      bottomNavigationBar: BottomAppBar(
        //color: Colors.orange,
        elevation: 10,

        child: ListTile(
          leading: const Icon(
            Icons.person,
            color: Colors.white,
            size: 35.0,

          ),
          title:  Text(globalsLogin!,
            style: const TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 20,
              //color: ,
            ),
          ),
          //onTap: ()=>_navigateToCBScreen(context),


        ),
      ),

    );

  }

}


void _navigateToCBScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
}

void _navigateToRetardScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MyControleRetardPage()));
}

void _navigateTo30joursScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyControle30joursPage()));
}

void _navigateToMaterielSelectionScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyMaterielSelectionPage()));
}

void _navigateToControleListScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyControleListPage(rep: '',)));
}

void _navigateThemeScreen(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MyModePage(title: 'Réglages')));
}


// affichages sous le graphique pie
affichageControle(int total, int tard, int prochain, BuildContext context){

  return Wrap(
      children: [

        if(tard != 0)
        Container(
          margin: const EdgeInsets.only(left:10.0,top:0.0,right:10.0,bottom:0.0),
          decoration: BoxDecoration(
            color: globalBackgroundColor(context, colorBackground),
            borderRadius: BorderRadius.circular(10),
            border:  Border.all(color: globalBorderColor(context, borderColor),),
            boxShadow: globalContainerShadow(),
          ),

          child: ListTile(
            onTap: () {
              if(tard != 0) {
                _navigateToRetardScreen(context);
              }else{
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const DialogControles(), // dans classes.dart
                );
              }
            },
            leading: const Text('Contrôles en retard  ',
              style: TextStyle(fontWeight: FontWeight.normal,
                fontSize: 20,
                //color: Colors.red,
              ),
            ),
            title: ActionChip(
                      label:Text((tard).toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.red,
                                )
                      ),
                      onPressed: () {_navigateToRetardScreen(context);},
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),

          )
        ),

        if(tard != 0)
        const Divider(
          //color: Colors.red,
          height: 10,
          thickness: 0,
          indent: 0,
          endIndent: 0,
        ),

        if(prochain != 0)
        Container(
          //margin: const EdgeInsets.only(left:10.0,top:0.0,right:10.0,bottom:0.0),
          margin: globalMargin(),
          decoration: BoxDecoration(
            color: globalBackgroundColor(context, colorBackground),
            borderRadius: BorderRadius.circular(10),
            border:  Border.all(color: globalBorderColor(context, borderColor),),
            boxShadow: globalContainerShadow(),
          ),


          child: ListTile(
            onTap: () {
              if(prochain != 0) {
                _navigateTo30joursScreen(context);
              }else{
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context){
                    return const DialogControles();
                  },
                );
              }
            },
            leading: const Text('Contrôles à 30 jours',
              style: TextStyle(fontWeight: FontWeight.normal,
                fontSize: 20,
                //color: Colors.orange,
              ),
            ),
            title: ActionChip(
                      label:Text((prochain).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.orange,
                          )
                      ),
                      onPressed: () { _navigateTo30joursScreen(context);},
                    ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
        )
      ]

  );

}



