import 'package:flutter/material.dart';
import 'package:gdcr/fonctions/globals.dart';
import 'CB.dart';
import '../classes/menu.dart';
import 'accueil.dart';
import 'materiel_detail.dart';
import '../repository/controleRepository.dart';
import '../controller/controle_controller.dart';
import '../model/controle.dart';
import 'package:intl/intl.dart';
import 'package:banner_listtile/banner_listtile.dart';
import '../fonctions/globals.dart';


class MyControleRetardPage extends StatefulWidget {
  const MyControleRetardPage({Key? key}) : super(key: key);

  get materiel => null;
  @override
  State<MyControleRetardPage> createState() => _MyControleRetardPageState();

}




class _MyControleRetardPageState extends State<MyControleRetardPage> {
  int _selectedIndex = 0;

  var controleController = ControleController(ControleRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        //toolbarHeight: 150,
        title: const Text('Contrôles en retard'),
        actions: [IconButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder:
              (context) => const Home())),

          icon: const Icon(
            Icons.home,
            color: Colors.white70,
            size: 35.0,

          ),
        ),
          IconButton(
            onPressed: () => _navigateToCBScreen(context),

            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white70,
              size: 35.0,

            ),
          )

        ],

      ),
      drawer: const MyDrawer(),
      // appel à la classe menu
      body: Center(


        child: FutureBuilder<List<ControleList>>(

          future: controleController.fetchControleRetard(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text(
                  'Pas de connexion'); //Text(snapshot.error.toString());
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final controle = snapshot.data![index];


                return Card(
                  //margin: const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0, bottom: 0.0),
                  margin: globalMargin(),
                  //shadowColor: Colors.blue[800],
                  elevation: 14,
                  semanticContainer: true,

                  child: BannerListTile(
                    borderside: BorderSide(color: globalBorderColor(context, borderColor), ),
                    bannerText: 'Retard',
                        bannerColor: Colors.red,
                        bannerTextColor: Colors.white,
                        //backgroundColor: ThemeData.dark().bannerTheme.backgroundColor,
                        backgroundColor: globalBackgroundColor(context, colorBackground),
                        bannersize: 50.0,

                        onTap: () {
                          setState(() {
                            var repe = controle.repMateriel.toString();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyMaterielDetailPage(rep: repe),
                                ));
                          });
                        },

                          title:Text('Date maxi prévue: ${getFormatedDate(controle.date)}'),
                          subtitle: Text(
                              'Matériel: ${controle.repMateriel} Type: ${controle.intitulePerio}'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  //color: Colors.black54,
                              ),
                            ],
                          )
                  ),
                );
              },

            );
          },

        ),
      ),
      /*bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        elevation: 10,

        child: ListTile(
          onTap: () => _navigateToCBScreen(context),

        ),
      ),*/
    );
  }

  void _navigateToCBScreen(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const MyappCB()));
  }

}
// Formattage de la date 
 getFormatedDate(date) {
  var inputFormat = DateFormat('yyyy-MM-dd');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat('dd/MM/yyyy');
  return outputFormat.format(inputDate);
}



