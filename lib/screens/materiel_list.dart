import 'package:flutter/material.dart';
import 'package:gdcr/fonctions/globals.dart';
import 'CB.dart';
import '../classes/listDeroulante.dart';
import '../classes/menu.dart';
import 'accueil.dart';
import 'materiel_detail.dart';
import '../repository/materielRepository.dart';
import '../controller/materiel_controller.dart';
import '../model/materiel.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';



class MyMaterielListPage extends StatefulWidget {

  const MyMaterielListPage({Key? key, required this.title, required this.secteur, required this.famille}) : super(key: key);
  final String title; final secteur; final famille;
  get materiel => null;
  @override
  State<MyMaterielListPage> createState() => _MyMaterielListPageState();

}




class _MyMaterielListPageState extends State<MyMaterielListPage> {
  var materielController=MaterielController(MaterielRepository());
  @override
  Widget build(BuildContext context) {
    var listControleur = DeroulanteControleur();
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        //toolbarHeight: 150,
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


        child: FutureBuilder<List<MaterielList>>(

          future: materielController.fetchMaterielList(widget.secteur, widget.famille),
          builder: (BuildContext context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text(
                  'Pas de connexion'); //Text(snapshot.error.toString());
            }

            return ScrollWrapper(
                enabledAtOffset: 200,
                alwaysVisibleAtOffset: true,
                promptTheme: const PromptButtonTheme(
                  //color: Colors.blueAccent,
                  elevation: 10,
                  icon: Icon(Icons.arrow_upward_rounded, color: Colors.white),
                  iconPadding: EdgeInsets.all(20),
                ),
                promptAlignment: Alignment.bottomRight,
                promptAnimationCurve: Curves.decelerate,
                scrollToTopDuration: const Duration(milliseconds: 1500),

              builder: (context, properties) =>
              ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                  final materiel = snapshot.data![index];

                return Card(
                  margin: globalMargin(),
                  elevation: 14,
                  semanticContainer: true,
                  color: globalBackgroundColor(context, colorBackground),
                  shape: RoundedRectangleBorder( //<-- SEE HERE
                    side: BorderSide(
                      color: globalBorderColor(context, borderColor),
                    ),
                  ),

                  child: ListTile(
                      onTap: () {
                        setState(() {
                          var repe = materiel.repMateriel.toString();
                          Navigator.push(
                              context,
                          MaterialPageRoute(
                            builder: (context) => MyMaterielDetailPage(rep: repe),
                          ));

                    });
                  },

                      leading: Icon(Icons.handyman_rounded, color: Theme.of(context).colorScheme.primary),//Text(user.userLogin,

                      title: Text((materiel.repMateriel).toString(),
                                style: const TextStyle(
                                  //color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                 ),
                              ),
                      subtitle: Text((materiel.designationMateriel).toString()),
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                  );
              },
            )
            );
          },
        ),
      ),
    );


  }
  void _navigateToCBScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
  }

}






