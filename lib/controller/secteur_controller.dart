import '../repository/repositorySecteur.dart';

class SecteurController {
  final RepositorySecteur _repository;

  SecteurController(this._repository);

  Future<String> fetchSecteurList() async {
    return _repository.getSecteurList();
  }
}