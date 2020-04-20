import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5)),
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: <Widget>[
                Container(
                  width: 140,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        suggestionList[index]['country'],
                      ),
                      Image.network(
                        suggestionList[index]['countryInfo']['flag'],
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
                            suggestionList[index]['cases'].toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        'Active: ' + suggestionList[index]['active'].toString(),
                        style: TextStyle(color: Colors.yellow[900]),
                      ),
                      Text(
                        'Recovered: ' +
                            suggestionList[index]['recovered'].toString(),
                        style: TextStyle(color: Colors.green),
                      ),
                      Text(
                        'Deaths: ' + suggestionList[index]['deaths'].toString(),
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey[100]
                                    : Colors.grey[900]),
                      ),
                      Text(
                        'New Cases: ' +
                            suggestionList[index]['todayCases'].toString(),
                        style: TextStyle(color: Colors.blue),
                      ),
                      Text(
                        'New Deaths: ' +
                            suggestionList[index]['todayDeaths'].toString(),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          );
        });
  }
}
