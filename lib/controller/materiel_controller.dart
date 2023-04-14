import '../model/materiel.dart';
import '../model/famille.dart';
import '../repository/repositoryMateriel.dart';

class MaterielController {
  final RepositoryMateriel _repository;

  MaterielController(this._repository);

  Future<List<MaterielList>> fetchMaterielList(String secteur, String famille) async {
    return _repository.getMaterielList(secteur, famille);
  }


/*Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }

  Future<String> deleteTodo(Todo todo) async {
    return _repository.toString();
  }*/


  Future<String> materielFetch(String materiel) async {

    return _repository.materielDetail(materiel);
  }

  Future<List<MaterielList>> fetchMaterielRetard() async {
    return _repository.getMaterielRetard();
  }

  Future<List<MaterielList>> fetchMateriel30jours() async {
    return _repository.getMateriel30jours();
  }
}