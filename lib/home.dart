import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherforecast/onlinedata.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var mydata;
  var mydata1;
  var id, base, main, description, icon, temp;
  bool show = true;
  late LocationData _currentPosition;
  var lat;
  var long;

  Future<void> getDatalatlong() async {
    if (await Permission.location.isGranted) {
      _currentPosition = await Location().getLocation();
      print(_currentPosition);
//test
      setState(() {
        lat=_currentPosition.latitude.toString();
        long=_currentPosition.longitude.toString();
      });
      String url="https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=21c34ac001e96decdb94d218f7fcabc9";
      var key = '21c34ac001e96decdb94d218f7fcabc9';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var mydata = await jsonDecode(response.body);
        print(response.body);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => clear(mydata: mydata,)));
      }
      else {
        print('something went wrong');
      }
    } else {
      Permission.location.request();
    }
  }


// Future<void> getLocation() async {
//   if (await Permission.location.isGranted) {
//     _currentPosition = await Location().getLocation();
//     print("Location");
//     print(_currentPosition.latitude);
//     print(_currentPosition.longitude);
//   } else {
//     Permission.location.request();
//   }
// }

  TextEditingController city = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // getLocation();
    //getData();
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(backgroundColor: Colors.indigo.shade100,
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,

         // decoration: BoxDecoration(
            // image: DecorationImage(
                //fit: BoxFit.fill,
                //child:SvgPicture.asset('assets/image/well.svg'),
              //)
          //),


            child: Column(
              children: [SizedBox(height: 80,),
                SvgPicture.asset('assets/image/well.svg'),
                SizedBox(height: 50,),
                Text('Weather', style: TextStyle(color: Colors.black87,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),),
                Text('Forecasts', style: TextStyle(color: Colors.black87,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),),
                ElevatedButton(style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black)
                        )
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(111,103, 252, 2),)), onPressed: () {
                  // if(_formKey.currentState!.validate()){
                  // getData();
                  getDatalatlong();
                }, child: Text('Get Started',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
              ],
            ),
          )




      ),

    );
  }
}