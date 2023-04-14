class SecteurList {
  String? idSecteur;
  String? designationSecteur;
  String? commentaireSecteur;

  SecteurList({this.idSecteur, this.designationSecteur, this.commentaireSecteur});

  SecteurList.fromJson(Map<String, dynamic> json) {
    idSecteur = json["id_secteur"].toString();
    designationSecteur = json["designation_secteur"];
    commentaireSecteur = json["commentaire_secteur"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_secteur'] = idSecteur.toString();
    data['designation_secteur'] = designationSecteur.toString();
    data['commentaire_secteur'] = commentaireSecteur.toString();
    return data;
  }
}