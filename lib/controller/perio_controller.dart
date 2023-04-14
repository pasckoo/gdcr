
import '../model/perio.dart';
import '../repository/repositoryPerio.dart';

class PerioController {
  final RepositoryPerio _repository;

  PerioController(this._repository);

  Future<String> fetchPerioControleList(String repMateriel) async {
    return _repository.getPerioListControle(repMateriel);
  }

  Future<String> fetchRetardControleList() async {
    return _repository.getRetardListControle();
  }

  Future<String> fetch30JoursControleList() async {
    return _repository.getRetardListControle();
  }



/*Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }

  Future<String> deleteTodo(Todo todo) async {
    return _repository.toString();
  }*/


  /*Future<String> materielFetch(String materiel) async {
    //print(materiel);
    return _repository.materielDetail(materiel);
  }*/
}