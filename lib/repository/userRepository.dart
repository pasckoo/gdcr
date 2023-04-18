import 'dart:async';
import 'dart:convert';
import '../repository/repositoryUser.dart';
import 'package:http/http.dart' as http;

class UserRepository implements RepositoryUser {
  String dataURL = 'http://151.80.129.92/mob/user';

  @override

  Future<String> getListControleur() async {

    Map data = {'controleur': 'login'};
    var url = Uri.parse('$dataURL/user_list.php');
    http.Response response = await http.post(
      url,
      body: data,);
    return response.body;
  }

  @override
  Future<String> getConnexion(login, mdp) async {
    Map data = {'login_user': login, 'mdp_user': mdp};
    var url = Uri.parse('$dataURL/user_list.php');
    http.Response response = await http.post(
      url,
      body: data,);
    return response.body;
  }

  @override
  Future<String> getDataUser(login) async {
    Map data = {'loginDataUser': login};
    var url = Uri.parse('$dataURL/user_list.php');
    http.Response response = await http.post(
      url,
      body: data,);
    return response.body;
  }

}