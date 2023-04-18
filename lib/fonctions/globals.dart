import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../repository/userRepository.dart';
import '../controller/user_controller.dart';


String? globalsLogin; // User login
String? globalsNom = '';
String? globalsPrenom = '';
String? globalsFonction = '';
String? globalsType = '';
String? globalsImage = '';

bool? globalsActive = false; // le User est contrôleur
bool globalFingerPrint = false;
int globalsNbControles = 0;
bool colorBackground = false;
bool borderColor = false;
Color c1 = Colors.amber;
double globalWithSizedBox = 250;
String globalEffaceDialog = 'Pour EFFACER le tag';
String globalLireDialog = 'Pour LIRE le tag';
String globalEcrireDialog = 'Pour ECRIRE le tag';

verifControleur(String login) async {
  var userController=UserController(UserRepository());
  var retour = await userController.fetchUserControleurList();
  var controleur = jsonDecode(retour);
  bool verif = false;
  for(var i = 0; i < controleur.length; i++ ) {
    if(controleur[i]['login_user'] == login){
      verif = true;
    }
   globalsActive = verif;
  }
}

remplissageVarUser(String login) async {
  var userController = UserController(UserRepository());
  var dataUser = await userController.fetchDataUser(login);
  var userData = jsonDecode(dataUser);

  globalsNom = userData['nom_user'];
  globalsPrenom = userData['prenom_user'];
  globalsFonction = userData['fonction_user'];
  globalsType = userData['type_user'];
  globalsImage = userData['image_user'];
}

getFormatedDate(date) {
  var inputFormat = DateFormat('yyyy-MM-dd');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat('dd/MM/yyyy');
  return outputFormat.format(inputDate);
}

Color? dateColor(strDate){
  DateTime date = DateTime.parse(strDate); // transforme string en date
  if(date.isBefore(DateTime.now())){
    return Colors.red;
  }else
  if(date.isAtSameMomentAs(DateTime.now())){
    return Colors.red;
  }else
  if(date.isBefore(DateTime.now().add(const Duration(days: 30)))){
    return Colors.orangeAccent;
  }else
  {return Colors.green;}
}

Widget? dateColorText(strDate){
  DateTime date = DateTime.parse(strDate); // transforme string en date
  if(date.isBefore(DateTime.now())){
    return const Text('Contrôle en retard');
  }else
  if(date.isAtSameMomentAs(DateTime.now())){
    return const Text('Contrôle en retard');
  }else
  if(date.isBefore(DateTime.now().add(const Duration(days: 30)))){
    return const Text('Contrôle avant 30 jours');
  }else{
    return const Text('Contrôle programmé');
  }
  return null;

}

List<BoxShadow> globalContainerShadow(){
  return
    const [
    BoxShadow(
      color: Colors.black38,
      blurRadius: 4,
      offset: Offset(0, 6), // Shadow position
    ),
  ];
}

globalMargin(){
  return const EdgeInsets.only(left:10.0,top:8.0,right:10.0,bottom:0.0);
}

globalBackgroundColor(BuildContext context, bool colorBg){
  if(colorBg == true){return Theme.of(context).colorScheme.background;}
  else{return Theme.of(context).scaffoldBackgroundColor;}
}

globalBorderColor(BuildContext context, bool colorBorder){
  if(colorBorder == true){return Theme.of(context).colorScheme.primary;}
  else{return Theme.of(context).scaffoldBackgroundColor;}
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}




