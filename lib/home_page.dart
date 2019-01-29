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
            child: new ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black
              ),
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
      leading: new CircleAvatar(backgroundColor: Colors.white,backgroundImage: NetworkImage("https://s2.coinmarketcap.com/static/img/coins/64x64/"+currency["id"].toString()+".png")),
      title: _getTitle(currency),
      //subtitle: _getSubtitleText(currency['symbol'], currency['quote']['USD']['price'].toStringAsFixed(2)),
      trailing: _getTrailing(currency),
      //isThreeLine: true,
    );
  }

  Widget _getTitle(Map currency){
    return Container(
      child: Row(
        children: [
          Expanded(
            /*1*/
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    currency['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                   currency['symbol'],
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Expanded(
            flex: 2,
            child: 
                Container(
                  alignment: Alignment.center,
                  child: Text(
                      currency['quote']['USD']['price'].toStringAsFixed(2)+" \$",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.grey[700]
                      ),
                  ),
                ),
              )
            
        ],
      ),
    );
  }

Widget _getTrailing(Map currency){
  
  double hour = currency['quote']['USD']['percent_change_1h'];
  double day = currency['quote']['USD']['percent_change_24h'];
  double week = currency['quote']['USD']['percent_change_7d'];

  Text hourText = new Text((hour > 0 ? "+" : "") + hour.toStringAsFixed(2), style: TextStyle(color: hour > 0 ? Colors.green : Colors.red, fontSize: 12.0));
  Text dayText = new Text((day > 0 ? "+" : "") + day.toStringAsFixed(2), style: TextStyle(color: day > 0 ? Colors.green : Colors.red, fontSize: 12.0));
  Text weekText = new Text((week > 0 ? "+" : "") + week.toStringAsFixed(2), style: TextStyle(color: week > 0 ? Colors.green : Colors.red, fontSize: 12.0));

  return Container(
    width: 60.0,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: hourText)
              ),
            Expanded(
              flex: 1,
              child: Text("1H", style: TextStyle(fontSize: 12.0)))
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: dayText)
              ),
            Expanded(
              flex: 1,
              child: Text("1D", style: TextStyle(fontSize: 12.0)))
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: weekText)
              ),
            Expanded(
              flex: 1,
              child: Text("1W", style: TextStyle(fontSize: 12.0)))
          ],
        )
      ],
    ),
  );

}

}