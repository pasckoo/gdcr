

import '../repository/repositoryUser.dart';

class UserController {
  final RepositoryUser _repository;

  UserController(this._repository);

  Future<String> fetchUserControleurList() async {
    return _repository.getListControleur();
  }

  Future<String> fetchUserConnexion(String login, String mdp) async {
    return _repository.getConnexion(login, mdp);
  }

  Future<String> fetchDataUser(String login) async {
    return _repository.getDataUser(login);
  }

}
