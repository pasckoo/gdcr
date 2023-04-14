class FamilleList {
  String? idFamille;
  String? categorieFamille;
  String? designationFamille;

  FamilleList({this.idFamille, this.categorieFamille, this.designationFamille});

  FamilleList.fromJson(Map<String, dynamic> json) {
    idFamille = json["id_famille"].toString();
    categorieFamille = json["categorie_famille"];
    designationFamille = json["designation_famille"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_famille'] = idFamille.toString();
    data['categorie_famille'] = categorieFamille.toString();
    data['designation_famille'] = designationFamille.toString();

    return data;
  }
}