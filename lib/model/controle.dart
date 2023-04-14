class ControleAjout {
  String? date;
  String? idMateriel;
  String? idPerio;
  String? idUser;
  String? commControle;
  String? dateSuivant;

  ControleAjout({
    this.date,
    this.idMateriel,
    this.idPerio,
    this.idUser,
    this.commControle,
    this.dateSuivant,
  });

  ControleAjout.fromJson(Map<String, dynamic> json) {
    date = json["date_controle"].toString();
    idMateriel = json["id_materiel"];
    idPerio = json["id_perio"];
    idUser = json["id_user"];
    commControle = json["comment_controle"];
    dateSuivant = json["date_suiv_controle"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_controle'] = date.toString();
    data['id_materiel'] = idMateriel.toString();
    data['id_perio'] = idPerio.toString();
    data['id_user'] = idUser.toString();
    data['comment_Controle'] = commControle.toString();
    data['date_suiv_controle'] = dateSuivant.toString();

    return data;
  }
}

class ControleList {

  String? id_controle;
  String? date_controle;
  String? repMateriel;
  String? intitulePerio;
  String? controleur;
  String? commentaires;
  String? suivant_fait;
  String? date;

  ControleList({
    this.id_controle,
    this.date_controle,
    this.repMateriel,
    this.intitulePerio,
    this.controleur,
    this.commentaires,
    this.suivant_fait,
    this.date,
  });

  ControleList.fromJson(Map<String, dynamic> json) {
    id_controle = json["id_controle"].toString();
    date_controle = json["date_controle"].toString();
    repMateriel = json["rep_materiel"].toString();
    intitulePerio = json["intitule_perio"].toString();
    controleur = json["login_user"].toString();
    commentaires = json["comment_controle"].toString();
    suivant_fait = json["suivant_fait"].toString();
    date = json["prochain_controle"].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_controle'] = id_controle.toString();
    data['date_controle'] = date_controle.toString();
    data['rep_materiel'] = repMateriel;
    data['intitule_perio'] = intitulePerio;
    data['login_user'] = controleur;
    data['comment_controle'] = commentaires;
    data['suivant_fait'] = suivant_fait;
    data['prochain_controle'] = date.toString();

    return data;
  }
}

class ControleUpdate {
  String? idControle;
  String? date;
  String? idMateriel;
  String? idPerio;
  String? idUser;
  String? commControle;
  String? dateSuivant;


  ControleUpdate({
    this.idControle,
    this.date,
    this.idMateriel,
    this.idPerio,
    this.idUser,
    this.commControle,
    this.dateSuivant,
  });

  ControleUpdate.fromJson(Map<String, dynamic> json) {
    idControle = json["id_controle"].toString();
    date = json["date_controle"].toString();
    idMateriel = json["id_materiel"];
    idPerio = json["id_perio"];
    idUser = json["id_user"];
    commControle = json["comment_controle"];
    dateSuivant = json["date_suiv_controle"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_controle'] = idControle.toString();
    data['date_controle'] = date.toString();
    data['id_materiel'] = idMateriel.toString();
    data['id_perio'] = idPerio.toString();
    data['id_user'] = idUser.toString();
    data['comment_Controle'] = commControle.toString();
    data['date_suiv_controle'] = dateSuivant.toString();

    return data;
  }
}
