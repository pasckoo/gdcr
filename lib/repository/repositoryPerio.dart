import '../model/perio.dart';

abstract class RepositoryPerio{
  Future<String> getPerioListControle(String repMateriel);
  Future<String> getRetardListControle();
  Future<String> get30JoursListControle();

}