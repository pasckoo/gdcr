import 'dart:async';
import '../repository/repositoryPerio.dart';
import 'package:http/http.dart' as http;


class PerioRepository implements RepositoryPerio {
  String dataURL = 'https://code-un-peu.fr/mob/perio';


  @override
  Future<String> getPerioListControle(repMateriel) async {
    Map data = {'rep_materiel_controle': repMateriel};
    var url = Uri.parse('$dataURL/perio.php');
    http.Response response = await http.post(
      url,
      //headers: {'Content-type': 'application/json'},
      // 'Accept': 'application/json'};//.then((value) => null);
      body: data,);

    return response.body;
  }

  @override
  Future<String>  getRetardListControle() async {
    Map data = {'retardControle': 'retardControle'};

    var url = Uri.parse('$dataURL/pie.php');
    http.Response response = await http.post(
      url,
      //headers: {'Content-type': 'application/json'},
      // 'Accept': 'application/json'};//.then((value) => null);
      body: data,);

    return response.body;
  }

  @override
  Future<String>  get30JoursListControle() async {
    Map data = {'30JoursControle': '30JoursControle'};

    var url = Uri.parse('$dataURL/pie.php');
    http.Response response = await http.post(
      url,
      //headers: {'Content-type': 'application/json'},
      // 'Accept': 'application/json'};//.then((value) => null);
      body: data,);

    return response.body;
  }
}