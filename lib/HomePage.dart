import 'dart:convert';

import 'package:covid/Worlds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/Totalcases.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://corona.lmao.ninja/v3/covid-19/all";
  Future<Total> getCases() async{
    var result = await http.get(
      Uri.encodeFull(url)
    ); 
      final finalresult = jsonDecode(result.body);
      print(finalresult);
      return Total.fromJson(finalresult);
  }
    @override
  void initState() {
    this.getCases();
    super.initState();
  }

  getCountriesCases() async{
         await Navigator.push(context, MaterialPageRoute(builder: (context)=>World())); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Covid-19 Tracker"),
        backgroundColor:Colors.purpleAccent
      ),
      backgroundColor: Colors.black,
      body: Container(
        child:Center(
          child:Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top:80.0)),
                  Text("Stay",style: TextStyle(
                    color:Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  ),),
                  Card(
                    color: Colors.indigo,
                    child: Text("Safe",style: TextStyle(
                    color:Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  ),),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top:60)),
             Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("           WorldWide Statistics",textAlign: TextAlign.center,style: TextStyle(
                        fontSize:18.0,
                        fontWeight: FontWeight.bold,
                        color:Colors.white,
                        
                      ),),
                       Padding(padding: EdgeInsets.only(top:40)),
                      
                    ],
                  ),
                  FutureBuilder<Total>(
                    future: getCases(),
                    builder: (BuildContext context,Snapshot){
                      
          if(Snapshot.hasData)
          {
            final covid = Snapshot.data;
            return Column( 
              children : <Widget>[
              Card(color: Color(0xFF292929),
            child : ListTile(

               
              title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children : <Widget>[
                
                
              Text("${covid.cases} ",style: TextStyle(color: Colors.blue, fontSize: 23, fontWeight: FontWeight.bold),),
              Text("${covid.deaths}",style: TextStyle(color: Colors.red, fontSize: 23, fontWeight: FontWeight.bold),),
              Text("${covid.recovered}",style: TextStyle(color: Colors.green, fontSize: 23, fontWeight: FontWeight.bold)),

              ]) )
            ),
            Padding(
              padding: const EdgeInsets.only(top:18.0),
              child: Card(color: Color(0xFF292929),
              child : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(

                   
                  title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children : <Widget>[
                    
                    
                  Text("Total Cases ",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text("Deaths",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text("Recoveries",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),

                  ]) ),
              )
              ),
            ),
            

            
            ]);
          }else if (Snapshot.hasError){
                        return Text(
                          Snapshot.error.toString()
                        );
                      }else{
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top:50)),
                 
                  Padding(padding: EdgeInsets.only(top:20),),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Card(
                         child: Container(
                           color: Color(0xFF292929),
                           child:Center(
                             child:Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Padding(padding:EdgeInsets.only(top:20) ,),
                                
                               ],
                             )
                           )
                         ),
                       )

                    ],),
                  ),
                   Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Container(
                         color: Color(0xFF292929),
                         child:Center(
                           child:Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                              //  Padding(padding:EdgeInsets.only(top:20) ,),
                                OutlinedButton(onPressed: (){
                                 getCountriesCases();
                               }, 
                               child: Text("Country Wise Statistics",style: TextStyle(fontSize: 15,
                              //  color: Color(0xFFfe9900),
                               fontWeight: FontWeight.bold,
                               ),
                               ),
                               
                               )
                              
                             ],
                           )
                         )
                       ), 
                     

                    ],),
                  ),
            ],
          )
        )
      ),
    );
  }
}