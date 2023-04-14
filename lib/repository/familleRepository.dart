import 'dart:async';
import '../repository/repositoryFamille.dart';
import 'package:http/http.dart' as http;

class FamilleRepository implements RepositoryFamille {
  String dataURL = 'http://151.80.129.92/mob/famille';
  @override

  Future<String> getFamilleList() async {

    Map data = {'famille': 'famille'};
    var url = Uri.parse('$dataURL/famille_list.php');
    http.Response response = await http.post(
      url,
      body: data);

    return response.body;
  }
}