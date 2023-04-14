class MaterielList {
  String? idMateriel;
  String? repMateriel;
  String? designationMateriel;
  String? typeModele;


  MaterielList({this.idMateriel, this.repMateriel, this.designationMateriel, this.typeModele});

  MaterielList.fromJson(Map<String, dynamic> json) {
    idMateriel = json["id_materiel"].toString();
    repMateriel = json["rep_materiel"];
    designationMateriel = json["designation_materiel"];
    typeModele = json["type_modele"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_materiel'] = idMateriel.toString();
    data['rep_materiel'] = repMateriel.toString();
    data['designation_materiel'] = designationMateriel.toString();

    return data;
  }
}

class MaterielDetail {
  String? id;
  String? rep;
  String? desi;
  String? ref;
  String? mes;
  String? comm;
  String? desiSect;
  String? secteur;
  String? famille;
  String? modele;
  String? typeModele;
  String? periode;
  String? prochaineDate;

  MaterielDetail({
    this.id,
    this.rep,
    this.desi,
    this.ref,
    this.mes,
    this.comm,
    this.desiSect,
    this.secteur,
    this.famille,
    this.modele,
    this.typeModele,
    this.periode,
    this.prochaineDate
  });

  MaterielDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    rep = json["rep"];
    desi = json["designation_materiel"];
    ref = json["ref"];
    mes = json["mes"];
    comm = json["comm"];
    desiSect = json["desi_secteur"];
    secteur = json["secteur"];
    famille = json["famille"];
    modele = json["modele"];
    typeModele = json["type_modele"];
    periode = json["periode"];
    prochaineDate = json["prochaineDate"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_materiel'] = id.toString();
    data['rep_materiel'] = rep.toString();
    data['designation_materiel'] = desi.toString();

    return data;
  }
}