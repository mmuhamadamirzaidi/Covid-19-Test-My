import 'package:flutter/material.dart';

class MywidePanel extends StatelessWidget {
  final Map myData;

  const MywidePanel({Key key, this.myData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'Confirmed',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: myData['cases'].toString(),
          ),
          StatusPanel(
            title: 'Active',
            panelColor: Colors.yellow[100],
            textColor: Colors.yellow[900],
            count: myData['active'].toString(),
          ),
          StatusPanel(
            title: 'Recovered',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: myData['recovered'].toString(),
          ),
          StatusPanel(
            title: 'Deaths',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: myData['deaths'].toString(),
          ),
          StatusPanel(
            title: 'New Cases',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: myData['todayCases'].toString(),
          ),
          StatusPanel(
            title: 'New Deaths',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: myData['todayDeaths'].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: panelColor, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, color: textColor),
          )
        ],
      ),
    );
  }
}
