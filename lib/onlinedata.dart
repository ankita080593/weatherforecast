import 'package:flutter/material.dart';
import 'city.dart';
import 'package:flutter_svg/flutter_svg.dart';

class clear extends StatefulWidget {
  final mydata;
  const clear({ required this.mydata, Key? key}) : super(key: key);

  @override
  State<clear> createState() => _clearState();
}

class _clearState extends State<clear> {

  var imagename='assets/image/clear.jpg';
  var imagename1='assets/image/summerImage.jpeg';
  var imagename2='assets/image/winter.jpg';
  var imagename3='assets/image/rain (1).jpg';
  var imagename4='assets/image/cloudy12.jpg';
  var iconimage;
  var temp1;
  double tmp=0;
  double finaltmp=0;
  var a;
  double c=0;

  @override
  void initState() {
    setState(() {
      iconimage=widget.mydata!=null?widget.mydata["list"][0]["weather"][0]["icon"]:'';
      temp1=widget.mydata!=null?widget.mydata["list"][0]["main"]["temp"].toString():'';
      print(temp1);
      double tmp=double.parse(temp1);
      print(tmp);
      finaltmp=(tmp-273.15);

    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(backgroundColor:Colors.indigo.shade100,
      body:
      SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: 15,),
            Align(alignment: Alignment.topCenter,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>city()));
                    },icon:Icon(Icons.add,size: 35,)),
                  ),

                  Container(alignment:Alignment.topCenter,child: Text(widget.mydata!=null?widget.mydata["city"]["name"].toString():'',style: TextStyle(fontSize: 20),)),

                  Container(alignment: Alignment.topRight,
                    child: PopupMenuButton(icon:Icon(Icons.more_vert),itemBuilder:(context)=>[PopupMenuItem(child:Text('share')),
                      PopupMenuItem(child:Text('settings')),]),
                  )
                ],
              ),
            ),
            SizedBox(width:360,child: Text(widget.mydata!=null?widget.mydata["list"][0]["weather"][0]["main"].toString():'',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            SizedBox(width: 360,child: Row(
              children: [
                Text( finaltmp .toStringAsPrecision(3),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Text('\u2103',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)
              ],
            )),
            Animation(widget.mydata),
            SizedBox(height: 40,),

            Container(height: MediaQuery.of(context).size.height/2.5,
              width: MediaQuery.of(context).size.width/1.10,
              decoration:BoxDecoration(borderRadius:BorderRadius.circular(20),color:Colors.white, ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [SizedBox(height: 20,),
                  Row(
                    children: [SizedBox(width:30 ,),

                      SizedBox(width:50,height:50,child: Image.network('http://openweathermap.org/img/w/${widget.mydata["list"][0]["weather"][0]["icon"]}.png',),),
                      SizedBox(width: 10,),
                      SizedBox(width:75,child: Column(
                        children: [Text(widget.mydata!=null?widget.mydata["list"][1]["dt_txt"].toString():''),
                          Text(widget.mydata!=null?widget.mydata["list"][1]["weather"][0]["description"].toString():''),
                        ],
                      )),
                      SizedBox(width: 75,),
                      Row(
                        children: [
                          Text(widget.mydata!=null?widget.mydata["list"][0]["main"]["temp_min"].toString():''),
                          Text('/'),
                          Text(widget.mydata!=null?widget.mydata["list"][0]["main"]["temp_max"].toString():''),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [SizedBox(width:30 ,),
                      SizedBox(height:50,width:50,child: Image.network('http://openweathermap.org/img/w/${widget.mydata["list"][0]["weather"][0]["icon"]}.png',)),
                      SizedBox(width: 10,),
                      SizedBox(width:75,child: Column(
                        children: [
                          Text(widget.mydata!=null?widget.mydata["list"][9]["dt_txt"].toString():''),
                          Text(widget.mydata!=null?widget.mydata["list"][9]["weather"][0]["description"].toString():''),
                        ],
                      )),
                      SizedBox(width: 75,),
                      Row(
                        children: [
                          Text(widget.mydata!=null?widget.mydata["list"][9]["main"]["temp_min"].toString():''),
                          Text('/'),
                          Text(widget.mydata!=null?widget.mydata["list"][9]["main"]["temp_max"].toString():''),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [SizedBox(width:30 ,),
                      SizedBox(height:50,width:50,child: Image.network('http://openweathermap.org/img/w/${widget.mydata["list"][18]["weather"][0]["icon"]}.png',)),
                      SizedBox(width: 10,),
                      SizedBox(width:75,child: Column(
                        children: [
                          Text(widget.mydata!=null?widget.mydata["list"][17]["dt_txt"].toString():''),
                          Text(widget.mydata!=null?widget.mydata["list"][17]["weather"][0]["description"].toString():''),
                        ],
                      )),
                      SizedBox(width: 75,),
                      Row(
                        children: [
                          Text(widget.mydata!=null?widget.mydata["list"][17]["main"]["temp_min"].toString():''),
                          Text('/'),
                          Text(widget.mydata!=null?widget.mydata["list"][17]["main"]["temp_max"].toString():''),
                        ],
                      )
                    ],
                  ),
                ],
              ) ,
            ),
          ],),
      ),
   resizeToAvoidBottomInset: false);
  }
  Widget Animation(data){

    if(data!=null){

      if(data["list"][0]["weather"][0]["main"].toString()=="Clear") {
        return Container(height: MediaQuery
            .of(context)
            .size
            .height / 3.1,
          width: MediaQuery
              .of(context)
              .size
              .width ,
          child:SvgPicture.asset('assets/image/Clear_Day.svg')
          /*decoration: BoxDecoration(image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/image/clear.jpg'))),*/
        );
      }else if(data["list"][0]["weather"][0]["main"].toString()=="Sunny"){
        return Container(height: MediaQuery
            .of(context)
            .size
            .height / 3.1,
          width: MediaQuery
              .of(context)
              .size
              .width ,
          child: SvgPicture.asset('assets/image/Summer.svg'),
          /*decoration: BoxDecoration(image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/image/summerImage.jpeg'))),*/
        );

      }else if(data["list"][0]["weather"][0]["main"].toString()=="Rain"){
        return Container(height: MediaQuery
            .of(context)
            .size
            .height / 3.1,
          width: MediaQuery
              .of(context)
              .size
              .width ,
          child: SvgPicture.asset('assets/image/rain.svg'),
          /*decoration: BoxDecoration(image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/image/13290 rain.jpg'))),*/
        );
      }else if(data["list"][0]["weather"][0]["main"].toString()=="Snow"){
        return Container(height: MediaQuery
            .of(context)
            .size
            .height / 3.1,
          width: MediaQuery
              .of(context)
              .size
              .width ,
          child: SvgPicture.asset('assets/image/Winter.svg'),
          /*decoration: BoxDecoration(image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/image/winter.jpg'))),*/
        );}
      else{
        return Container(height: MediaQuery
            .of(context)
            .size
            .height / 3.1,
          width: MediaQuery
              .of(context)
              .size
              .width ,
          child: SvgPicture.asset('assets/image/cloud.svg'),
          /*decoration: BoxDecoration(image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/image/cloud.svg'))),*/
        );
      }

    }
    else {
      return Container();
    }

  }
}
