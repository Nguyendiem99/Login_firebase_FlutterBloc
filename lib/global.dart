import 'package:firebasegoogle/global_loading.dart';
import 'package:firebasegoogle/global_statistics.dart';
import 'package:flutter/material.dart';

import '../services/covid_service.dart';

import '../models/global_summary.dart';

CovidService covidService = CovidService();

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {

  Future<GlobalSummaryModel>? summary;

  @override
  void initState() {
    super.initState();
    summary = covidService.getGlobalSummary();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Text(
                  "Global Corona Virus Cases",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      summary = covidService.getGlobalSummary();
                    });
                  },
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),

              ],
            ),
          ),

          FutureBuilder<GlobalSummaryModel> (
            future: summary,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Center(child: Text("Error"),);
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return GlobalLoading();
                default:
                  if (!snapshot.hasData) {
                    return Center(child: Text("Empty"),);
                  } else {
                    return GlobalStatistics(
                    summary: snapshot.data,
                  );
                  }
              }
            },
          ),

        ],
      ),
    );
  }
}