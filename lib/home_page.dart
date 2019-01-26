import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List currencies;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Crypto Tracker"),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget(){
    return new Container(
      
        child: new Column(
          children:[new Flexible(
            child: new ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index){
                final Map currency = widget.currencies[index];

                return _getListItemUi(currency);
              },
            ),
          ),
          ], 
        ),
    );
  }

  ListTile _getListItemUi(Map currency){
    return new ListTile(
      leading: new CircleAvatar(backgroundColor: Colors.white,backgroundImage: NetworkImage("https://s2.coinmarketcap.com/static/img/coins/64x64/"+currency["id"].toString()+".png")
      ),
      title: new Text(currency['name'],
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
      subtitle: _getSubtitleText(currency['quote']['USD']['price'].toStringAsFixed(2), currency['quote']['USD']['percent_change_1h'].toStringAsFixed(2)),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange){
    TextSpan priceTextWidget = new TextSpan(
      text: "\$$priceUSD", style: new TextStyle(color: Colors.black, fontSize: 18.0));
      String percentageChangeText = "1h $percentageChange%";
      TextSpan percentageChangeTextWidget;

      if(double.parse(percentageChange)>0){
        percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
        style: new TextStyle(color: Colors.green, fontSize: 18.0));
      } else {
        percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
        style: new TextStyle(color: Colors.red, fontSize: 18.0));
      }

      return new RichText(
        text: new TextSpan(
          children: [priceTextWidget, percentageChangeTextWidget]
        ),
        softWrap: false,
      );
  }
}