import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapptest/datasource.dart';
import 'package:flutterapptest/pages/countypage.dart';
import 'package:flutterapptest/panels/infopanel.dart';
import 'package:flutterapptest/panels/worldwidepanel.dart';
import 'package:flutterapptest/panels/mywidepanel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  Map myData;
  fetchMyWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/countries/my');
    setState(() {
      myData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchMyWideData();
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        actions: <Widget>[
//          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight), onPressed: (){
//            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
//          })
//        ],

        centerTitle: true,
        title: Text(
          'Coronavirus Tracker',
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            color: Colors.orange[100],
            child: Text(
              DataSource.quote,
              style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
                  textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Worldwide',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CountryPage()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Regional',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          worldData == null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              )
              : WorldwidePanel(
                  worldData: worldData,
                ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Malaysia',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                ),
//               Container(
//                      decoration: BoxDecoration(
//                          color: primaryBlack,
//                          borderRadius: BorderRadius.circular(5)),
//                      padding: EdgeInsets.all(10),
//                      child: Text(
//                        'Updated',
//                        style: TextStyle(
//                            fontSize: 14,
//                            color: Colors.white),
//                      )
//               ),
              ],
            ),
          ),

          myData == null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              )
              : MywidePanel(
            myData: myData,
          ),

          InfoPanel(),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            'WE ARE TOGETHER IN THE FIGHT',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )),
          SizedBox(
            height: 50,
          )
        ],
      )),
    );
  }
}
