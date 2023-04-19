import 'package:gdcr/screens/reglages.dart';
import 'package:gdcr/screens/controle_list.dart';
import '../fonctions/globals.dart';
import '../screens/accueil.dart';
import '../screens/materiel_selection.dart';
import 'dialogs.dart';
import 'package:flutter/material.dart';
import '../screens/materiel_detail.dart';
import '../screens/CB.dart';
import 'profil.dart';


class MyDrawer extends StatelessWidget {
  static const couleurDivider = Colors.blueAccent;

  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      child: ListView(

        padding: EdgeInsets.zero,
        children: <Widget>[
          if(globalsLogin != null)
          const DrawerHeader(
            child: ProfilePage(),
          ),

          if(globalsLogin != null) // Pour vérifier s'il y a eu une connexion par user et MdP
          ListTile(
            enabled: true,
            leading: Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
            title: const Text(
              'Accueil',
              style: TextStyle(
                fontSize: 16,
                //color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _navigateToAccueilScreen(context);
            },
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),

          ),

          ListTile(
            enabled: true,
            leading: Icon(Icons.search_rounded, color: Theme.of(context).colorScheme.primary),
            title: const Text(
              'Chercher un matériel',
              style: TextStyle(
                fontSize: 16,
                //color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _navigateChercherScreen(context);
            },
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),

          ),

          ListTile(
            enabled: true,
            leading: Icon(Icons.handyman_rounded, color: Theme.of(context).colorScheme.primary),
            title: const Text(
              'Matériels',
              style: TextStyle(
                fontSize: 16,
                //color: Theme.of(context).colorScheme.primary
              ),
            ),
            //subtitle: const Text('Sélection du matériel',),
            onTap: () {
              Navigator.pop(context);
              //_navigateToNextScreen(context);
              _navigateToMaterielSelectionScreen(context);
            },
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),

          ),

          ListTile(
            leading: Icon(Icons.checklist_rtl, color: Theme.of(context).colorScheme.primary),
            title: const Text(
              'Contrôles',
              style: TextStyle(
                fontSize: 16,
                  //color: Theme.of(context).colorScheme.primary
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              Navigator.pop(context);
              //_navigateToNextScreen(context);
              _navigateToControleListScreen(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
            title: const Text(
              'Réglages',
              style: TextStyle(
                  fontSize: 16,
                  //color: Theme.of(context).colorScheme.primary
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              Navigator.pop(context);
              _navigateThemeScreen(context);

            },
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app_rounded, color: Theme.of(context).colorScheme.primary),
            onTap: (){
              Navigator.pop(context);
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => const DialogQuitter(), // dans classes.dart
              );

            },
            title: const Text(
              'Déconnexion',
              style: TextStyle(
                  fontSize: 16,
                  //color: Theme.of(context).colorScheme.primary
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
          /*const SizedBox(
            height: 120,
          ),
          Container(
           padding: const EdgeInsets.only(bottom:160.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.background
                  ]),
                borderRadius: const BorderRadius.only(
                 topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )),
          ),*/
        ],
      ),

    );

  }
}

void _navigateToMaterielSelectionScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyMaterielSelectionPage()));
}

void _navigateToControleListScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyControleListPage(rep: '',)));
}

void _navigateToAccueilScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
}

void _navigateToCBScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
}

void _navigateToNextScreen2(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyMaterielDetailPage(rep:'' )));
}

void _navigateThemeScreen(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MyModePage(title: 'Réglages')));
}

void _navigateChercherScreen(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MyappCB()));
}





