import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SearchList extends StatefulWidget {
  SearchList({ Key key }) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();

}

class _SearchListState extends State<SearchList>
{
  Map currency;
  Map currencyy;
  var openn,ask,v,l,t,b,h,low;
  bool pressGeoON = false;
  bool cmbscritta = false;
  Map order;var bid,timestamp;
  // ignore: missing_return
  Future<Map> getcurrencyy(String _searchText) async{
    print("You have selected "+_searchText);
    currencyy =await getcurrency(_searchText);
    openn=currencyy["open"];
    ask=currencyy["ask"];
    v=currencyy["volume"];
    l=currencyy["last"];
    t=currencyy["timestamp"];
    b=currencyy["bid"];
    h=currencyy["high"];
    low=currencyy["low"];
  }
  Widget appBarTitle = new Text("Enter currency pair", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  String _searchText = "";
  final TextEditingController _searchController = TextEditingController();
  bool _IsSearching=false;
  String _search = "";

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
        _search=_searchText.toUpperCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  DataRow buildDataRow(List<String> data) {
    print("from buildDataRow");
    print(data);
    return DataRow(
      cells: data
          .map<DataCell>(
            (cell) => DataCell(
          Text(cell),
        ),
      )
          .toList(),
    );
  }
  buildDataColumns() {
    List columns = <DataColumn>[
      DataColumn(
        label: Text(
          'bid_price',
        ),
      ),
      DataColumn(
        label: Text(
          'bid_qty',
        ),
      ),
      DataColumn(
        label: Text(
          'ask_qty',
        ),
      ),
      DataColumn(
        label: Text(
          'ask_price',
        ),
      ),
    ];
    print("columns");
    print(columns.length);
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      floatingActionButton: _searchText.length!=null && v!=null? FloatingActionButton(
        onPressed: () {
          _handleSearchStart();
        },
        child: Icon(Icons.repeat),
        backgroundColor: Colors.deepPurple,
      ):null,
      //appBar:buildBar(context),
      body:Container(
        //height: 1000,
       // width:800,
        child: Column(children: <Widget>[Padding(
          padding:EdgeInsets.fromLTRB(10.0,40.0,10.0,10.0),
          child:  Theme(
            data: new ThemeData(
              primaryColor: Colors.grey,
              primaryColorDark: Colors.grey,
            ),
            child:TextField(
        controller: _searchController,
        decoration: InputDecoration(
          fillColor:Colors.white54,filled: true,
          hintText: "Enter currency pair",
          //prefixIcon: Icon(Icons.search,color: Colors.white,),

          suffixIcon: _searchText.isNotEmpty ? IconButton(icon: Icon(Icons.search),onPressed: () {
            _handleSearchStart();
            setState(() {
              // _searchController.clear();
              _IsSearching = true;
            });},) : null,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
          ),
        ),
      ),),),
        _searchText.length!=null && v!=null?Container(
        //height: 1400,
        width:700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Row( mainAxisAlignment: MainAxisAlignment.start,children:<Widget>[

              Padding(
                padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,10.0),
                child: _IsSearching? new Text("$_search",style: TextStyle(fontSize: 28.0,  fontWeight: FontWeight.bold),
                ):new Text("")
                ,),])
              ,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
                    padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,5.0),

                    child: _IsSearching? new Text("Open",style: TextStyle(fontSize: 14.0)
                    ):new Text("")
                    ,
                  ),Padding(
                    padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,7.0),

                    child: _IsSearching? new Text("\$ $openn",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                    ):new Text("")
                    ,
                  )])
                  ,
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
                      padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,5.0),
                      child: _IsSearching? new Text("High " ,style: TextStyle(fontSize: 14.0)
                      ):new Text("")
                      ,),
                    Padding(
                        padding:EdgeInsets.fromLTRB(10.0,10.0,10.0,7.0),
                        child: _IsSearching? new Text("\$ $h" ,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)
                        ):new Text("")
                    )],)
                    ,],),
            Row(
              mainAxisAlignment: MainAxisAlignment.start ,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
                    padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,5.0),

                    child: _IsSearching? new Text("Low",style: TextStyle(fontSize: 14.0)
                    ):new Text("")
                    ,
                  ),Padding(
                    padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,7.0),

                    child: _IsSearching? new Text("\$ $low",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                    ):new Text("")
                    ,
                  )])
                  ,
                Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
                    padding:EdgeInsets.fromLTRB(10.0,10.0,10.0,5.0),
                    child: _IsSearching? new Text("Last " ,style: TextStyle(fontSize: 14.0)
                    ):new Text("")
                    ,),
                    Padding(
                        padding:EdgeInsets.fromLTRB(10.0,10.0,10.0,7.0),
                        child: _IsSearching? new Text("\$ $l" ,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)
                        ):new Text("")
                    )],)
                  ,],),
            Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
              padding:EdgeInsets.all(6.0),

              child: _IsSearching? new Text("Volume",style: TextStyle(fontSize: 14.0)
              ):new Text("")
              ,
            ),Padding(
              padding:EdgeInsets.all(6.0),

              child: _IsSearching? new Text(" $v",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
              ):new Text("")
              ,
            )])
          ,_searchText.length!=null && v!=null?Container(

              margin: EdgeInsets.fromLTRB(200.0,0.0,0.0,0.0),
              child: RaisedButton(

                  color: pressGeoON ? Colors.white : Colors.white,
                  textColor: Colors.deepPurple,
                  child: cmbscritta ? Text("HIDE ORDER BOOK") : Text("VIEW ORDER BOOK"),
                  //    style: TextStyle(fontSize: 14)
                  onPressed: () {
                    getorderr(_searchText);
                    setState(() {
                      pressGeoON = !pressGeoON;
                      cmbscritta = !cmbscritta;
                    });
                  }
              ),
            ):Container(), cmbscritta && order!=0 ?/* SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:*/ DataTable(/*horizontalMargin: 12.0,*/columnSpacing:20.0,headingRowHeight: 28.0,dividerThickness: 0.0, rows: <DataRow>[
                  for (int i = 0; i < 5; i++) buildDataRow([order["bids"][i][0],order["bids"][i][1],order["asks"][i][1],order["asks"][i][0]]),//(bid[i] + bid[i]).cast<String>()),
                ], columns: buildDataColumns())//,),)
                :Center(),]
        )
        ,): Container(

          height: 300,
          width:350,

        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage("image/images.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(

            height: 50,
            width: MediaQuery.of(context).size.width,

              alignment: Alignment.center,
              child: Text(
                "Enter a currency pair to load data", style: TextStyle(fontSize: 18),
              ),

          ),
        ),
      )
      ,],),),);
  }




  Future<Map> getcurrency(String s) async {
    http.Response response = await http.get(
        'https://www.bitstamp.net/api/ticker/'+s);
    return (json.decode(response.body));
  }

  Future<Map> getorderr(String s) async{
    print("You have selected "+s);
    order =await getorder(s);
    timestamp= order["timestamp"];
    bid=order["bids"];

  }
  Future<Map> getorder(String s) async {
    http.Response response = await http.get(
        'https://www.bitstamp.net/api/order_book/'+s);
    return (json.decode(response.body));
  }
  void _handleSearchStart() {
    getcurrencyy(_searchText);
    getorderr(_searchText);
    setState(() {
      _IsSearching = true;
      //this.body=new Text("$open",textScaleFactor: 1.5,);

    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("Search currency pair", style: new TextStyle(color: Colors.white),);

      _IsSearching = false;
      //_searchQuery.clear();
    });
  }

}
