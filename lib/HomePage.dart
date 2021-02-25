import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:first_flutter_app/pro.dart';

class SearchList extends StatefulWidget {
  SearchList({ Key key }) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();

}

class _SearchListState extends State<SearchList> {
  final key = new GlobalKey<ScaffoldState>();
  TextEditingController _searchController ;
  String _searchText = "";
  String _search = "";
  FocusNode focusNode = FocusNode();


  @override
  void initState() {
    final Pro myProvider = Provider.of<Pro>(context, listen: false);
    super.initState();
    _searchController = TextEditingController(text: myProvider.name);
    _searchText = _searchController.text;
    _search=_searchText.toUpperCase();
    focusNode.addListener(() {
      if (focusNode.hasFocus) myProvider.removeonfocus();
    });
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  DataRow buildDataRow(List<String> data) {
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
    return columns;
  }


  @override
  Widget build(BuildContext context) {
    final Pro myProvider = Provider.of<Pro>(context);

    return Container( child:Consumer<Pro>(builder: (context, myProvider, child){ return new Scaffold(
      key: key,
      floatingActionButton: myProvider.name!=null && myProvider.v!=null && myProvider.IsSearching? FloatingActionButton(
        onPressed: () {
          myProvider.handleSearchStart(myProvider.name);
        },
        child: Icon(Icons.repeat),
        backgroundColor: Colors.deepPurple,
      ):null,
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
              focusNode: focusNode,
              controller: _searchController,
              onChanged: myProvider.setname,

              decoration: InputDecoration(
                fillColor:Colors.white54,filled: true,
                hintText: "Enter currency pair",
                //prefixIcon: Icon(Icons.search,color: Colors.white,),

                suffixIcon: myProvider.name!=null ? IconButton(icon: Icon(Icons.search),onPressed: () {
                  myProvider.handleSearchStart(myProvider.name);
                  myProvider.sethideview();
                    // _searchController.clear();
                    FocusScope.of(context).requestFocus(new FocusNode());

                  },) : null,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.0),
                  ),
                ),
              ),
            ),),),
          myProvider.name!=null && myProvider.v!=null && myProvider.IsSearching?Container(
            //height: 1400,
            width:700,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row( mainAxisAlignment: MainAxisAlignment.start,children:<Widget>[

                    Padding(
                      padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,10.0),
                      child: myProvider.IsSearching? new Text(myProvider.name.toUpperCase(),style: TextStyle(fontSize: 28.0,  fontWeight: FontWeight.bold),
                      ):new Text("")
                      ,),])
                  ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
                        padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,5.0),

                        child: myProvider.IsSearching? new Text("Open",style: TextStyle(fontSize: 14.0)
                        ):new Text("")
                        ,
                      ),Padding(
                        padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,7.0),

                        child: myProvider.IsSearching? new Text("\$ "+ myProvider.openn,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                        ):new Text("")
                        ,
                      )])
                      ,
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
                        padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,5.0),
                        child: myProvider.IsSearching? new Text("High " ,style: TextStyle(fontSize: 14.0)
                        ):new Text("")
                        ,),
                        Padding(
                            padding:EdgeInsets.fromLTRB(10.0,10.0,10.0,7.0),
                            child: myProvider.IsSearching? new Text("\$"+ myProvider.h ,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)
                            ):new Text("")
                        )],)
                      ,],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start ,
                    children: <Widget>[
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
                        padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,5.0),

                        child: myProvider.IsSearching? new Text("Low",style: TextStyle(fontSize: 14.0)
                        ):new Text("")
                        ,
                      ),Padding(
                        padding:EdgeInsets.fromLTRB(10.0,10.0,90.0,7.0),

                        child: myProvider.IsSearching? new Text("\$"+ myProvider.low,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                        ):new Text("")
                        ,
                      )])
                      ,
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
                        padding:EdgeInsets.fromLTRB(10.0,10.0,10.0,5.0),
                        child: myProvider.IsSearching? new Text("Last " ,style: TextStyle(fontSize: 14.0)
                        ):new Text("")
                        ,),
                        Padding(
                            padding:EdgeInsets.fromLTRB(10.0,10.0,10.0,7.0),
                            child: myProvider.IsSearching? new Text("\$" + myProvider.l ,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)
                            ):new Text("")
                        )],)
                      ,],),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[Padding(
                    padding:EdgeInsets.all(6.0),

                    child: myProvider.IsSearching? new Text("Volume",style: TextStyle(fontSize: 14.0)
                    ):new Text("")
                    ,
                  ),Padding(
                    padding:EdgeInsets.all(6.0),

                    child: myProvider.IsSearching? new Text( myProvider.v,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                    ):new Text("")
                    ,
                  )])
                  ,myProvider.name!=null && myProvider.v!=null?Container(

                    margin: EdgeInsets.fromLTRB(200.0,0.0,0.0,0.0),
                    child: RaisedButton(

                        color: Colors.white ,
                        textColor: Colors.deepPurple,
                        child: myProvider.cmbscritta ? Text("HIDE ORDER BOOK") : Text("VIEW ORDER BOOK"),
                        //    style: TextStyle(fontSize: 14)
                        onPressed: () {
                          myProvider.hide_view(myProvider.cmbscritta);
                        }
                    ),
                  ):Container(), myProvider.cmbscritta && myProvider.order!=null && myProvider.v!=null ?DataTable(/*horizontalMargin: 12.0,*/columnSpacing:10.0,headingRowHeight: 28.0,dividerThickness: 0.0, rows: <DataRow>[
                    for (int i = 0; i < 5; i++) buildDataRow([myProvider.order["bids"][i][0],myProvider.order["bids"][i][1],myProvider.order["asks"][i][1],myProvider.order["asks"][i][0]]),
                  ], columns: buildDataColumns())
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
          ,],),),

    );}));

  }

}