import 'dart:convert';

import 'package:flutter/material.dart';
import '../classes/menu.dart';
import '../fonctions/globals.dart';
import 'CB.dart';
import '../repository/controleRepository.dart';
import '../controller/controle_controller.dart';
import '../model/controle.dart';
import 'package:intl/intl.dart';
import 'package:banner_listtile/banner_listtile.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'accueil.dart';
import 'controle_detail.dart';


class MyControleListPage extends StatefulWidget {
  const MyControleListPage({Key? key, required this.rep, this.nbControles}) : super(key: key);
  final String rep;
  final nbControles;
  //final String nb_controles;
  get materiel => null;

  @override
  State<MyControleListPage> createState() => _MyControleListPageState();
  }

class _MyControleListPageState extends State<MyControleListPage> {

  var controleController = ControleController(ControleRepository());

  bool voirBanner = false;

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 150,
        title: Text('${widget.nbControles} Contrôles ${widget.rep}'),
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
          onPressed: () => _navigateToCBScreen(context),

          icon: const Icon(
            Icons.search_rounded,
            color: Colors.white70,
            size: 35.0,

          ),
        )

        ],

      ),
      drawer: const MyDrawer(),  // appel à la classe menu

      body: Center(

        child: FutureBuilder<List<ControleList>>(

          future: controleController.fetchControleList(widget.rep),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text(
                  'Aucune connexion');//Text(snapshot.error.toString());
            }
           //
            print(snapshot.data);
            if(snapshot.data.toString() == '[]'){return Text('Pas de controles pour ${widget.rep}');}
            else{

            return ScrollWrapper(
                enabledAtOffset: 200,
                alwaysVisibleAtOffset: true,
                promptTheme: const PromptButtonTheme(
                  elevation: 10,
                  icon: Icon(Icons.arrow_upward_rounded, color: Colors.white),
                  iconPadding: EdgeInsets.all(20),
                ),
                promptAlignment: Alignment.bottomRight,
                promptAnimationCurve: Curves.decelerate,
                scrollToTopDuration: const Duration(milliseconds: 1500),


              builder: (context, properties) => ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final controle = snapshot.data![index];
                  if(controle.suivant_fait.toString() == '0'){voirBanner = true;}else{voirBanner= false;}

                return Card(
                  margin: globalMargin(),
                  //shadowColor: Colors.blue[800],
                  elevation: 14,
                  semanticContainer: true,
                  shape: RoundedRectangleBorder( //<-- SEE HERE
                    side: BorderSide(
                      color: globalBorderColor(context, borderColor),
                    ),
                  ),

                  child: BannerListTile(
                    bannersize: 70.0,
                      showBanner: voirBanner,
                      bannerText: 'dernier\ncontrôle',
                      bannerColor: Colors.blueAccent,
                      backgroundColor: globalBackgroundColor(context, colorBackground),

                      onTap: () {
                        setState(() {
                          var idControle = controle.id_controle.toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyControleDetailPage(idControle: idControle),
                              ));
                        });
                      },
                      //leading: const Icon(Icons.checklist_rtl, color: Colors.blueAccent),
                      title:Text('N° ${controle.id_controle} du ${getFormatedDate(controle.date_controle)}'),
                      subtitle: Text(
                          'Matériel: ${controle.repMateriel}\nPério: ${controle.intitulePerio}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  const [
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            //color: Colors.black54,
                          ),
                        ],
                      )
                  ),
                );
              },
            )

            );}
          },

      ),


    ),


    );
  }


  void _navigateToCBScreen(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const MyappCB()));
  }


}
// Formattage de la date
/*getFormatedDate(date) {
  var inputFormat = DateFormat('yyyy-MM-dd');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat('dd/MM/yyyy');
  return outputFormat.format(inputDate);
}*/



