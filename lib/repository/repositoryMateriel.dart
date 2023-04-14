import '../model/materiel.dart';

abstract class RepositoryMateriel{
  Future<List<MaterielList>> getMaterielList(String secteur, String famille);
  Future<String> materielDetail(String materiel);
  Future<List<MaterielList>> getMaterielRetard();
  Future<List<MaterielList>> getMateriel30jours();
//Future<String> deleteTodo(Todo todo);
//Future<String> postTodo(Todo todo);

}

