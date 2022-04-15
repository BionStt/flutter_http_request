import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/summary.dart';
import '../widget/summary_item.dart';

class HomePage extends StatelessWidget {
  
  late Summary dataSummary;
  
  Future getSummary() async{
    var response = await http.get(
      Uri.parse("https://covid19.mathdro.id/api"),
    );
    //print(response.body);
    Map<String,dynamic> data = json.decode(response.body) as Map<String,dynamic>;
    dataSummary = Summary.fromJson(data);
    //print(dataSummary);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
      ),
      body: FutureBuilder(
        future: getSummary(),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
                child: Text("Loading data.."),
            );
          }
          return Column(
            children: [
              SummaryItem(title: 'Confirmed',value: "${dataSummary.confirmed.value}"),
              //SummaryItem(title: 'Confirmed',value: "1243"),
             // SummaryItem(title: 'Death',value: "1243"),
              SummaryItem(title: 'Death',value: "${dataSummary.deaths.value}"),
           //   SummaryItem(),
            ],
          );
        },
      ),
      
    );
  }
}