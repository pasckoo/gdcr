class UserControleur {
  String? userFirstName ;
  String? userName ;
  String? userLogin ;
  String? userControleur;
  String? userMdp;


  UserControleur({this.userLogin});

  UserControleur.fromJson(Map<String, dynamic> json) {
    userLogin = json["user_login"];
    userMdp = json["user_Mdp"];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_login'] = userLogin.toString();
    data['user_Mdp'] = userMdp.toString();
    return data;
  }

}

