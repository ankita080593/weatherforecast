import 'package:flutter/material.dart';
import 'package:weatherforecast/grid.dart';

class city extends StatefulWidget {
  const city({Key? key}) : super(key: key);

  @override
  State<city> createState() => _cityState();
}

class _cityState extends State<city> {
  TextEditingController city=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor:Colors.transparent,
        backgroundColor:Colors.transparent,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [SizedBox(width: 20,),
              Text(
                'Manage cities',
                style: TextStyle(fontSize: 35,fontWeight: FontWeight.normal,color:Colors.black54 ),
              ),
            ],
          ),
          SizedBox(height: 10,),

          Container(height: 50,width:MediaQuery.of(context).size.width-30,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(30, 30)),color: Colors.grey.shade200),
            child:
            TextFormField(onTap:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>grid()));
            },controller: city,
                decoration: InputDecoration(hintText: 'Enter location',border: InputBorder.none,contentPadding: EdgeInsets.all(15),
                  prefixIcon: IconButton(onPressed:(){},icon:Icon(Icons.search)),
                )

            ),),
          //TextButton(onPressed: (){}, child: Text('Cancle'))
        ],
      ),
    );
  }
}
