import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
void main() async
{
  final List currencies= await getCurrencies();
  print(currencies);
  runApp(new myApp(currencies));
}
class myApp extends StatelessWidget {
  final List _currencies;
  myApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark
      ),
      home: new HomePage(_currencies),
    );
  }
}

Future<List> getCurrencies() async{
  String cryptoUrl="https://api.coinmarketcap.com/v1/ticker/?limit=50";
  http.Response response=await http.get(cryptoUrl);
  //below statement won't be executed until above is done. That's why await keyword is used
  return jsonDecode(response.body);

}
