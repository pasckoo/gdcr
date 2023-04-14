import 'package:flutter/material.dart';
import '../controller/famille_controller.dart';
import '../repository/familleRepository.dart';
import '../repository/perioRepository.dart';
import '../controller/perio_controller.dart';
import '../repository/userRepository.dart';
import '../controller/user_controller.dart';
import'../repository/secteurRepository.dart';
import '../controller/secteur_controller.dart';
import 'dart:convert';
import '../fonctions/globals.dart';

class DeroulantePerio extends StatefulWidget {
  DeroulantePerio({Key? key, this.rep}) : super(key: key);
   final String? rep;
  @override
  String retour = '';

  @override
  State<DeroulantePerio> createState() => _DeroulantePerioState();
}

class _DeroulantePerioState extends State<DeroulantePerio> {
  var deroulanteController = PerioController(PerioRepository());

  @override
  Widget build(BuildContext context) {

    Future: return FutureBuilder<String>(

      future: deroulanteController.fetchPerioControleList(widget.rep.toString()),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text(
              'Pas de connexion'); //Text(snapshot.error.toString());
        }

        final List<String> liste = [];
        String? selectedListe;
        final data = snapshot.data!;
        var perioControle = jsonDecode(data);

        for(var i = 0; i < perioControle.length; i++ ) {
          liste.add(perioControle[i]['intitule_perio']);
        }

        return DropdownButtonFormField<String>(
          dropdownColor: Theme.of(context).colorScheme.background,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Sélectionnez une périodicité';
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                  width: 1, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          hint: const Text('Périodicité'),
          value: selectedListe,
          items: liste.map((item) =>
            DropdownMenuItem<String>(
              value: item,
              child: Text(item.toString()),
            )
          ).toList(),
          onChanged: (String? value) {
              selectedListe = value;
              widget.retour = selectedListe!;
          },
        );
      }
    );
  }
}

class DeroulanteControleur extends StatefulWidget {
  DeroulanteControleur({Key? key}) : super(key: key);

  String retour = '';

  @override
  State<DeroulanteControleur> createState() => _DeroulanteControleurState();
}

class _DeroulanteControleurState extends State<DeroulanteControleur> {
  var userController=UserController(UserRepository());
  @override
  Widget build(BuildContext context) {
    Future: return FutureBuilder<String>(

        future: userController.fetchUserControleurList(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text(
                'Pas de connexion'); //Text(snapshot.error.toString());
          }

          final List<String> liste = [];
          String? selectedListe;
          final data = snapshot.data!;
          var controleur = jsonDecode(data);

          for(var i = 0; i < controleur.length; i++ ) {
            liste.add(controleur[i]['login_user']);
          }

          return DropdownButtonFormField<String>(
            dropdownColor: Theme.of(context).colorScheme.background,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Sélectionnez un contrôleur';
              }
              return null;
            },
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                    width: 1, color: Colors.blueAccent),
              ),
          ),
            hint: const Text("Contrôleur"),
            value: selectedListe,
            items: liste.map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(item.toString()),
                )
            ).toList(),
            onChanged: (String? value) {
              selectedListe = value;
              widget.retour = selectedListe!;
            },
          );
        }
    );
  }
}

class DeroulanteFamille extends StatefulWidget {
  DeroulanteFamille({Key? key}) : super(key: key);
  String retour = '';

  @override
  State<DeroulanteFamille> createState() => _DeroulanteFamilleState();
}

class _DeroulanteFamilleState extends State<DeroulanteFamille> {
  var familleController=FamilleController(FamilleRepository());
  @override
  Widget build(BuildContext context) {
    Future: return FutureBuilder<String>(

        future: familleController.fetchFamilleList(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text(
                'Pas de connexion'); //Text(snapshot.error.toString());
          }

          final List<String> liste = [];
          String? selectedListe;
          final data = snapshot.data!;
          var controleur = jsonDecode(data);

          for(var i = 0; i < controleur.length; i++ ) {
            liste.add(controleur[i]['categorie_famille']);
          }

          return DropdownButtonFormField<String>(
            hint: const Text("Toutes les familles"),
            dropdownColor: Theme.of(context).colorScheme.background,

            value: selectedListe,

            items: liste.map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(item.toString()),
                )
            ).toList(),
            onChanged: (String? value) {
              selectedListe = value;
              widget.retour = selectedListe!;
            },
          );
        }
    );
  }
}


class DeroulanteSecteur extends StatefulWidget {
  DeroulanteSecteur({Key? key}) : super(key: key);
  String retour = '';

  @override
  State<DeroulanteSecteur> createState() => _DeroulanteSecteurState();
}

class _DeroulanteSecteurState extends State<DeroulanteSecteur> {
  var secteurController=SecteurController(SecteurRepository());
  @override
  Widget build(BuildContext context) {
    Future: return FutureBuilder<String>(

        future: secteurController.fetchSecteurList(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text(
                'Pas de connexion'); //Text(snapshot.error.toString());
          }

          final List<String> liste = [];
          String? selectedListe;
          final data = snapshot.data!;
          var controleur = jsonDecode(data);

          for(var i = 0; i < controleur.length; i++ ) {
            liste.add(controleur[i]['designation_secteur']);
          }

          return DropdownButtonFormField<String>(
            hint: const Text("Tous les secteurs"),
            dropdownColor: Theme.of(context).colorScheme.background,
            value: selectedListe,
            items: liste.map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(item.toString()),
                )
            ).toList(),
            onChanged: (String? value) {
              selectedListe = value;
              widget.retour = selectedListe!;
            },
          );
        }
    );
  }
}

