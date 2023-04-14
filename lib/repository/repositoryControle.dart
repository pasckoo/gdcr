
import '../model/controle.dart';


abstract class RepositoryControle{
  //Future<List<ControleList>> getControleList();
  controleAjout(
      String dateCon,
      String rep,
      String perio,
      String controleur,
      String comm
      );

  controleUpdate(
      String idControleUp,
      String dateCon,
      String rep,
      String perio,
      String controleur,
      String comm
      );

  Future<List<ControleList>> getControleRetard();
  Future<List<ControleList>> getControle30jours();
  Future<List<ControleList>> getControleList(String rep);
  Future<String> controleDetail(String idControle);

//Future<String> deleteTodo(Todo todo);
//Future<String> postTodo(Todo todo);

}
