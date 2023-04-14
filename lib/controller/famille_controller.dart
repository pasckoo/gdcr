import '../repository/repositoryFamille.dart';

class FamilleController {
  final RepositoryFamille _repository;

  FamilleController(this._repository);

  Future<String> fetchFamilleList() async {
    return _repository.getFamilleList();
  }
}