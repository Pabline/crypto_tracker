import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:crypto_tracker/home_page.dart';
import 'package:flutter/material.dart';

void main() async { 
  List currencies = await getCurrencies();
  print(currencies);
  runApp(new MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.white,
        accentColor: Colors.white,
        brightness: Brightness.light
      ),
      home: new HomePage(_currencies),
    );
  }
}


Future<List> getCurrencies() async {
  String cryptoUrl = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=50";
  http.Response response = await http.get(cryptoUrl, headers:{"X-CMC_PRO_API_KEY": "API KEY"});
  
  return json.decode(response.body)["data"];
}