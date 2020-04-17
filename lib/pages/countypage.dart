import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutterapptest/pages/search.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){

            showSearch(context: context, delegate: Search(countryData));

          },)
        ],
        centerTitle: true,
        title: Text('Country Statistics'),
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[100],
                  shadowColor: Colors.white,
                  child: Container(
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 140,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                countryData[index]['country'],
                              ),
                              Image.network(
                                countryData[index]['countryInfo']['flag'],
                                height: 50,
                                width: 60,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Confirmed: ' +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                    color: Colors.red),
                              ),
                              Text(
                                'Active: ' +
                                    countryData[index]['active'].toString(),
                                style: TextStyle(
                                    color: Colors.yellow[900]),
                              ),
                              Text(
                                'Recovered: ' +
                                    countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                    color: Colors.green),
                              ),
                              Text(
                                'Deaths: ' +
                                    countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                    color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                              ),
                              Text(
                                'New Cases: ' +
                                    countryData[index]['todayCases'].toString(),
                                style: TextStyle(
                                    color: Colors.blue),
                              ),
                              Text(
                                'New Deaths: ' +
                                    countryData[index]['todayDeaths'].toString(),
                                style: TextStyle(
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}
