import 'package:flutter/material.dart';
import 'package:flutterapptest/datasource.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FAQs'),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(
                DataSource.questionAnswers[index]['question'],
                style: TextStyle(color: Colors.grey[700]),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(DataSource.questionAnswers[index]['answer'],
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),
                )
              ],
            );
          }),
    );
  }
}
