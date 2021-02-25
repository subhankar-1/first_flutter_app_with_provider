import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pro extends ChangeNotifier{

  Map currency;
  Map currencyy;
  var openn,ask,v=null,l,t,b,h,low;
  Map order;var bid,timestamp;
  String _name;
  bool IsSearching ;
  bool cmbscritta = false;

  hide_view(bool c ){
    cmbscritta = !c;
    notifyListeners();
  }

  String get name => _name;
  setname(String name) {
    _name = name;
    IsSearching = false;
    v=null;
    order=null;
    notifyListeners();
  }

  Future<Map> getcurrency(String s) async {
    http.Response response = await http.get(
        'https://www.bitstamp.net/api/v2/ticker/'+s+'/');

    print(response.statusCode);
    if(response.statusCode==200){

        currencyy=(json.decode(response.body));
        openn=currencyy["open"];
        v=currencyy["volume"];
        l=currencyy["last"];
        t=currencyy["timestamp"];
        b=currencyy["bid"];
        h=currencyy["high"];
        low=currencyy["low"];

    }
    else{

        currencyy=null;
        v=null;
        l=null;
        t=null;
        b=null;
        h=null;
        low=null;

    }
    notifyListeners();
    return (json.decode(response.body));
  }

  Future<Map> getorder(String s) async {
    http.Response response = await http.get(
        'https://www.bitstamp.net/api/v2/order_book/'+s+'/');
    print(response.statusCode);

    if(response.statusCode==200){

        order=(json.decode(response.body));

    }
    else{

        order=null;

    }
    notifyListeners();
    return (json.decode(response.body));
  }
  void handleSearchStart(String _searchText) {

      getcurrency(_searchText);
      getorder(_searchText);
      IsSearching = true;
      notifyListeners();

  }

  void sethideview(){
    cmbscritta = false;
    notifyListeners();
  }
  void removeonfocus(){
    IsSearching=false;
    notifyListeners();

  }
}