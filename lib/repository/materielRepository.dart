import 'dart:convert';
import 'dart:async';
import '../repository/repositoryMateriel.dart';
import '../model/materiel.dart';
import 'package:http/http.dart' as http;


class MaterielRepository implements RepositoryMateriel {

  String dataURL = 'http://151.80.129.92/mob/materiel';

  @override
  Future<List<MaterielList>> getMaterielList(secteur, famille) async {
    List<MaterielList> materielList = [];
    Map data = {'pasckoo': '2330', 'designation_secteur':secteur, 'categorie_famille':famille};
    var url = Uri.parse('$dataURL/materiel_list.php');
    http.Response response = await http.post(
      url,
      body: data,);
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      materielList.add(MaterielList.fromJson(body[i]));
    }
    return materielList;
  }

 /* @override
  Future<String> materielDetail(MaterielDetail materielDetail) async {
    var url = Uri.parse('$dataURL/${materielDetail.rep}');
    String resData = '';
    await http.patch(
      url,
      body: {
        'login': (todo.login).toString(),
      },
      headers: {
        'Authorization': 'your_token'
      },
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result['login'];
    }
    );
    return resData;
  }*/

  /*@override
  Future<String> deleteTodo(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      print(value.statusCode);
      print(value.body);
      return result = 'true';
    });

    return result;
  }*/

  /*@override
  Future<String> materielDetail(String materiel) async {
    //print ('${(materielDetail.toJson())}');
    Map data = {'rep_materiel': materiel};
    print(data);
    var url = Uri.parse('$dataURL/materiel_detail.php');
      //print(url);
    var response = await http.post(
      url,
      body: jsonEncode(<String, String>{'rep_materiel': materiel,}),
        headers: {'Content-type': 'application/json',
    'Accept': 'application/json'}).then((value) => null);

    //print(response.statusCode);
    print((response.body).toString());
    return response.body;
  }*/


  @override
  Future<String> materielDetail(String materiel) async {
    Map data = {'rep_materiel': materiel};
    var url = Uri.parse('$dataURL/materiel_list.php');
    http.Response response = await http.post(
         url,
          body: data,);

    return response.body;
  }

  @override
  Future<List<MaterielList>> getMaterielRetard() async {
    List<MaterielList> materielRetard = [];
    Map data = {'retard_perio': '2330'};
    var url = Uri.parse('$dataURL/materiel_perio.php');
    http.Response response = await http.post(
      url,
      body: data,);
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      materielRetard.add(MaterielList.fromJson(body[i]));
    }
    return materielRetard;
  }

  @override
  Future<List<MaterielList>> getMateriel30jours() async {
    List<MaterielList> materiel30jours = [];
    Map data = {'30jours_perio': '2330'};
    var url = Uri.parse('$dataURL/materiel_perio.php');
    http.Response response = await http.post(
      url,
      body: data,);
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      materiel30jours.add(MaterielList.fromJson(body[i]));
    }
    return materiel30jours;
  }


}




