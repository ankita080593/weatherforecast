import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import 'onlinedata.dart';

class grid extends StatefulWidget {
  const grid({Key? key}) : super(key: key);

  @override
  State<grid> createState() => _gridState();
}

class _gridState extends State<grid> {
  TextEditingController city = TextEditingController();
  var mydata;
  String text = "";

  Future<void> getData( String cityname) async {

    var key = '21c34ac001e96decdb94d218f7fcabc9';
    // print('https://api.openweathermap.org/data/forecast?q=surat&appid=21c34ac001e96decdb94d218f7fcabc9');
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityname&appid=21c34ac001e96decdb94d218f7fcabc9'));

    if (response.statusCode == 200) {
      var mydata = await jsonDecode(response.body);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>clear(mydata:mydata)));
    }
    else {
      print('something went wrong');
    }
  }
  late LocationData _currentPosition;
  var lat;
  var long;

  Future<void> getDatalatlong() async {
    if (await Permission.location.isGranted) {
      _currentPosition = await Location().getLocation();
      print(_currentPosition);

      setState(() {
        lat=_currentPosition.latitude.toString();
        long=_currentPosition.longitude.toString();
      });
      String url="https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=21c34ac001e96decdb94d218f7fcabc9";
      var key = '21c34ac001e96decdb94d218f7fcabc9';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var mydata1 = await jsonDecode(response.body);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => clear(mydata: mydata1,)));
      }
      else {
        print('something went wrong');
      }
    } else {
      Permission.location.request();
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [SizedBox(width: 30,),
              Container(height: 50,width:MediaQuery.of(context).size.width-100,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(30, 30)),color: Colors.grey.shade200),
                child:
                TextFormField(onTap: (){

                },controller: city,
                    decoration: InputDecoration(hintText: 'Enter location',border: InputBorder.none,contentPadding: EdgeInsets.all(15),
                      prefixIcon: IconButton(onPressed:(){},icon:Icon(Icons.search)),
                    )

                ),),
              TextButton(onPressed: (){
                getData(city.text);
              }, child: Text('Done'))
            ],
          ),

          SizedBox(height: 40,),
          SizedBox(width:330,child: Text('Popular cities',style: TextStyle(color: Colors.grey),)),
          Gridview(),
        ],
      ),
    );
  }

  Widget Gridview() {
    return Expanded(
      flex: 1,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        childAspectRatio: 2.5,
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),

        children: <Widget>[
          TextButton(style:TextButton.styleFrom(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)) ,
            backgroundColor: Colors.grey.shade200,),onPressed:(){
            getDatalatlong();

          },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                children: [
                  Text('Location',style: TextStyle(color: Colors.blueAccent),),
                  Icon(Icons.location_on,color: Colors.blueAccent,)
                ],
              ),
            ),
            //  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(100, 100)),color: Colors.teal,),
          ),
          TextButton(onPressed: (){

            getData("surat");
          },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)) ,backgroundColor: Colors.teal,
            ),
            //padding:EdgeInsets.all(36),
            child: Center(child: Text('surat',style: TextStyle(color: Colors.black),)),
          ),
          TextButton(onPressed:(){
            getData("Bharuch");
          },
            //padding:EdgeInsets.all(26),
            child: Center(child: Text('Bharuch',style: TextStyle(color: Colors.black),)),
            style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.redAccent ),
          ),
          TextButton(onPressed: (){
            getData("Baroda");

          },
            //padding:EdgeInsets.all(10),
            child: Center(child: Text('Baroda',style: TextStyle(color: Colors.black),)),
            style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.blueAccent
            ),
          ),
          TextButton(onPressed: (){
            getData("Ahmedabad");

          },
            //padding:EdgeInsets.all(10),
            child: Center(child: Text('Ahmedabad',style: TextStyle(color: Colors.black),)),
            style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.orange),
          ),

          TextButton(onPressed: (){
            getData("valsad");

          },
            //padding:EdgeInsets.all(10),
            child: Center(child: Text('valsad',style: TextStyle(color: Colors.black),)),
            style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),backgroundColor: Colors.amber),
          ),
          TextButton(onPressed: (){
            getData("bombay");

          },
            //padding:EdgeInsets.all(10),
            child: Center(child: Text('bombay',style: TextStyle(color: Colors.black),)),
            style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.lightBlueAccent),
          )
        ],
      ),
    );
  }
}
