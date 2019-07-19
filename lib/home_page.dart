import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List currencies;
  final List<MaterialColor> _colors=[Colors.cyan,Colors.red,Colors.lightBlue,Colors.deepPurple,Colors.amber];






  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:new Text("Crypto App",style: TextStyle(color:Colors.black87),),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        elevation: defaultTargetPlatform==TargetPlatform.iOS? 0.0 :6.0,
      ),
      body: _cryptoWidget(),
    );
  }
  Widget _cryptoWidget()
  {
    return new Container(
        child: Column(
          children: <Widget>[new Flexible(
              child: new ListView.builder(
                itemCount: widget.currencies.length,
                itemBuilder: (BuildContext context,int index){
                  final Map currency=widget.currencies[index];
                  final MaterialColor color=_colors[index % _colors.length];
                  return _getListItemUi(currency,color);
                },
              )
          ),],
        )
    );
  }
  Widget _getListItemUi(Map currency,MaterialColor color)
  {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0],style: TextStyle(color:Colors.black),),
      ),
      title: new Text(currency['name'],
      style: new TextStyle(fontWeight: FontWeight.bold),),
      subtitle: _getSubtitleText(currency['price_usd'],currency['percent_change_1h']),
      isThreeLine: true,
    );
  }
  Widget _getSubtitleText(String priceUSD,String percentageChange)
  {
    TextSpan priceTextWidget=new TextSpan(text: "\$$priceUSD\n",
    style:new TextStyle(color:Colors.white70));
    String percentageChangeText="Percentage change in 1 hour : $percentageChange%";
    String basicText="Percentage change in 1 hour : ";
    TextSpan basicTextWidget=new TextSpan(text: basicText,style: new TextStyle(color:Colors.white70));
    TextSpan percentageChangeTextWidget;
    if (double.parse(percentageChange)>0)
      {
        percentageChangeTextWidget= new TextSpan(text: "$percentageChange %",
        style: new TextStyle(color:Colors.green));
      }
    else
      {
        percentageChangeTextWidget=new TextSpan(text:"$percentageChange %",
        style: new TextStyle(color:Colors.red));
      }
    return new RichText(
      text: new TextSpan(
        children: [priceTextWidget,basicTextWidget,percentageChangeTextWidget]
      )
    );
  }
}

