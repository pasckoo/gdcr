
class PerioListControle {
  String? idPerio;
  String? intitulePerio;
  String? idModele;
  String? repMateriel;

  PerioListControle({this.idPerio, this.intitulePerio, this.idModele, this.repMateriel});

  PerioListControle.fromJson(Map<String, dynamic> json) {
    idPerio = json["id_perio"].toString();
    intitulePerio = json["intitule_perio"];
    idModele = json["id_modele"].toString();
    repMateriel = json["rep_materiel"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rep_materiel'] = repMateriel.toString();
    return data;
  }
}

class RetardControle{
  String? nb;
  RetardControle(this.nb);

}