import '../model/user.dart';

abstract class RepositoryUser{
  Future<String> getListControleur();
  Future<String> getConnexion(String login, String mdp);

}