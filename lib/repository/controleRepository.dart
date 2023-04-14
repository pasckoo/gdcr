import 'dart:convert';
import 'dart:io';
import 'dart:async';
import '../repository/repositoryControle.dart';
import 'package:http/http.dart' as http;
import '../model/controle.dart';

class ControleRepository implements RepositoryControle {
  String dataURL = 'http://151.80.129.92/mob/controle';

  @override
   Future controleAjout(
      String dateCon,
      String rep,
      String perio,
      String controleur,
      String comm) async {

    Map data = {
      'dateCon': dateCon,
      'rep_mat': rep,
      'perio_con': perio,
      'controleur_con': controleur,
      'comm_con': comm
      };
    var url = Uri.parse('$dataURL/controle.php');
    final http.Response response = await http.post(
      url,
      body: data);

  }

  @override
  Future controleUpdate(
      String idControleUp,
      String dateConUp,
      String repUp,
      String perioUp,
      String controleurUp,
      String commUp) async {

    Map data = {
      'idControleUp': idControleUp,
      'dateConUp': dateConUp,
      'rep_matUp': repUp,
      'perio_conUp': perioUp,
      'controleur_conUp': controleurUp,
      'comm_conUp': commUp
    };
    print(dateConUp +' '+ repUp);
    var url = Uri.parse('$dataURL/controle.php');
    final http.Response response = await http.post(
        url,
        body: data);
    print(response.body);
  }




  @override
  Future<List<ControleList>> getControleRetard() async {
    List<ControleList> controleRetard = [];
    Map data = {'retard_perio': '2330'};
    var url = Uri.parse('$dataURL/controle_perio.php');
    http.Response response = await http.post(
      url,
      //headers: {'Content-type': 'application/json'},
      // 'Accept': 'application/json'};//.then((value) => null);
      body: data,);
    //var response = await http.get(url);
    //print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    //print((response.body).toString());
    for (var i = 0; i < body.length; i++) {
      controleRetard.add(ControleList.fromJson(body[i]));

    }
    print(body);
    return controleRetard;
  }

  @override
  Future<List<ControleList>> getControle30jours() async {
    List<ControleList> controle30jours = [];
    Map data = {'30jours_perio': '1962'};
    var url = Uri.parse('$dataURL/controle_perio.php');
    http.Response response = await http.post(
      url,
      //headers: {'Content-type': 'application/json'},
      // 'Accept': 'application/json'};//.then((value) => null);
      body: data,);
    //var response = await http.get(url);
    //print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    //print((response.body).toString());
    for (var i = 0; i < body.length; i++) {
      controle30jours.add(ControleList.fromJson(body[i]));

    }
    return controle30jours;
  }

  @override
  Future<List<ControleList>> getControleList(String rep) async {
    List<ControleList> controleList = [];
    Map data = {'affichageControle': 'affichage', 'repMat': rep};
    var url = Uri.parse('$dataURL/controle.php');
    http.Response response = await http.post(
      url,
      body: data,);
    var body = json.decode(response.body);

    for (var i = 0; i < body.length; i++) {
      controleList.add(ControleList.fromJson(body[i]));

    }

    return controleList;
  }

  @override
  Future<String> controleDetail(String idControle) async {

    Map data = {'controleId': idControle};
    var url = Uri.parse('$dataURL/controle.php');
    http.Response response = await http.post(
      url,
      body: data,);

    return response.body;
  }



}