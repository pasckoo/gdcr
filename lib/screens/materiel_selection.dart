import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import '../fonctions/globals.dart';
import 'CB.dart';
import '../classes/listDeroulante.dart';
import '../classes/menu.dart';
import 'accueil.dart';
import 'materiel_list.dart';
import 'package:material_color_generator/material_color_generator.dart';

class MyMaterielSelectionPage extends StatefulWidget {
  const MyMaterielSelectionPage({Key? key}) : super(key: key);

  get materiel => null;
  @override
  State<MyMaterielSelectionPage> createState() => _MyMaterielSelectionPageState();

}

class _MyMaterielSelectionPageState extends State<MyMaterielSelectionPage> {
  final myFamille = DeroulanteFamille();
  final mySecteur = DeroulanteSecteur();
  @override

  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélection du matériel'),
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

      body: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 20.0,


              children: [
                Container(
                  margin: const EdgeInsets.only(left:30.0,top:0.0,right:30.0,bottom:20.0),
                  padding: const EdgeInsets.only(left:20.0,top:10.0,right:20.0,bottom:10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.0, 7.0),
                      )
                    ],
                  ),




                  child: const Center(
                    child: Text('Pour affiner votre recherche, vous pouvez sélectionner'
                        ' une famille et un secteur',
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,

                      ),

                    ),)


                ),
                const Divider(
                  //color: Colors.white60,
                  height: 30,
                ),
                Container(
                  color: globalBackgroundColor(context, colorBackground),
                  margin: const EdgeInsets.only(left:30.0,top:0.0,right:30.0,bottom:0.0),
                  child: Material(
                    elevation: 10.0,
                    //shadowColor: Colors.blueGrey,
                    child: ListTile(
                      leading: const Icon(Icons.family_restroom),
                      title: myFamille,

                    ),
                  )
                ),

                const Divider(
                  //color: Colors.white60,
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left:30.0,top:0.0,right:30.0,bottom:0.0),
                  child: Material(
                          elevation: 10.0,
                          //shadowColor: Colors.blueGrey,
                          child: ListTile(
                            leading: const Icon(Icons.home_work_rounded),
                            title: mySecteur,
                        )

                  ),
                ),
                const Divider(
                  //color: Colors.white60,
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  onPressed: (){setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyMaterielSelectionPage()
                    ));
                  });
                  },
                  child: const Text('Reset'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  ),
                  onPressed: (){setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>
                          MyMaterielListPage(title: '', secteur: mySecteur.retour, famille: myFamille.retour))
                    );
                  });
                    },
                  child: const Text('Valider'),
                ),
              ]

          )

        )

    );


  }

  void _navigateToCBScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
  }

  void _navigateToMaterielListScreen(BuildContext context, String title, String secteur, String famille) {
    Navigator.of(context).push(MaterialPageRoute(builder:
        (context) =>  MyMaterielListPage(title: '',secteur: mySecteur.retour , famille: myFamille.retour)));
  }
}



