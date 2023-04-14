
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../screens/controle_30jours.dart';
import '../screens/controle_retard.dart';
import 'indicator.dart';
import '../fonctions/globals.dart';


class PieChartSample2 extends StatefulWidget{
  final int retard; final int prochain; final int reste;
  const PieChartSample2({Key? key,
    required this.retard,
    required this.prochain,
    required this.reste,
  }) : super(key: key);



  @override
  State<StatefulWidget> createState() => PieChart2State();
  setState(){

  }
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override

  Widget build(BuildContext context) {


    return AspectRatio(
      aspectRatio: 1.3,

      child: Container(
          margin: const EdgeInsets.only(left:10.0,top:10.0,right:10.0,bottom:0.0),
          decoration: BoxDecoration(
            color: globalBackgroundColor(context, colorBackground),
            borderRadius: BorderRadius.circular(10),
            border:  Border.all(color: globalBorderColor(context, borderColor),),
            boxShadow: globalContainerShadow(),
          ),


        child: Column(

            children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Contrôles programmés',
                  style: TextStyle(height: 2, fontSize: 20),
                ),
              ],
            ),

            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }else{}
                          touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                          if(touchedIndex == 0){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MyControleRetardPage()));}});
                          if(touchedIndex == 1){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MyControle30joursPage()));}
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 60,
                      sections: showingSections()),
                ),
              ),

            ),

            Row( // Row remplace un Column d'origine
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: const <Widget>[
                Indicator(
                  textColor: Color(0xff808080),
                  color: Colors.redAccent,//Color(0xff0293ee),
                  text: 'En retard',
                  isSquare: false,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  textColor: Color(0xff808080),
                  color: Color(0xfff8b250),
                  text: 'à 30 jours',
                  isSquare: false,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  textColor: Color(0xff808080),
                  color: Colors.green,//Color(0xff845bef),
                  text: 'planifiés',
                  isSquare: false,
                ),
                SizedBox(
                  height: 4,
                ),

              ],
            ),
            Row(children: const [SizedBox(height: 10,)],),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {

      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 12.0;
      final radius = isTouched ? 50.0 : 20.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: sectionValue((widget.retard).toDouble()),
            title: (widget.retard).toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: sectionValue((widget.prochain).toDouble()),
            title: (widget.prochain).toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: sectionValue((widget.reste).toDouble()),
            title: (widget.reste).toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        /*case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );*/
        default:
          throw Error();
      }
    });
  }
}

double sectionValue(double valeur) {
  if (valeur == 0) {
    valeur = 0.001;
    }else{
    valeur = valeur;
    }
  return valeur;
}



