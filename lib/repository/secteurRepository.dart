import 'dart:async';
import '../repository/repositorySecteur.dart';
import 'package:http/http.dart' as http;

class SecteurRepository implements RepositorySecteur {
  String dataURL = 'https://code-un-peu.fr/mob/secteur';
  @override

  Future<String> getSecteurList() async {

    Map data = {'secteur': 'secteur'};
    var url = Uri.parse('$dataURL/secteur_list.php');
    http.Response response = await http.post(
        url,
        body: data);
    return response.body;
  }
}