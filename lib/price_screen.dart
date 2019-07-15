import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String bitCoinPrice = '?';
  String ethreumPrice = '?';
  String lightCoinPrice = '?';

  void getData(String currency) async {
    CoinData data = CoinData();
    double bitCoinlast = await data.getPrice(currency, 'BTC');
    double ethreumlast = await data.getPrice(currency, 'ETH');
    double lightCoinlast = await data.getPrice(currency, 'LTC');
    setState(() {
      this.bitCoinPrice = bitCoinlast.toStringAsFixed(2);
      this.ethreumPrice = ethreumlast.toStringAsFixed(2);
      this.lightCoinPrice = lightCoinlast.toStringAsFixed(2);
    });
  }

  CupertinoPicker iOSPicker() {
    List<Text> menu = [];
    currenciesList.forEach((currency) {
      menu.add(Text(currency));
    });
    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        String selected = currenciesList[selectedIndex];
        setState(() {
          this.selectedCurrency = selected;
          this.bitCoinPrice = '?';
          this.ethreumPrice = '?';
          this.lightCoinPrice = '?';
        });
        getData(selected);
      },
      children: menu,
    );
  }

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> menu = [];
    currenciesList.forEach((currency) {
      menu.add(DropdownMenuItem(child: Text(currency), value: currency));
    });
    return DropdownButton(
      value: selectedCurrency,
      items: menu,
      onChanged: (value) {
        setState(() {
          this.selectedCurrency = value;
          this.bitCoinPrice = '?';
          this.ethreumPrice = '?';
          this.lightCoinPrice = '?';
        });
        getData(value);
      },
    );
  }

  @override
  void initState() {
    getData(this.selectedCurrency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitCoinPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethreumPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $lightCoinPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidPicker()),
        ],
      ),
    );
  }
}
