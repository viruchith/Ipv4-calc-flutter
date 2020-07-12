import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'calc.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          centerTitle: true,
          leading:null,
          title:Row(
            children: <Widget>[
              Text('IPv4 Address Calc',
              style:TextStyle(
                fontSize: 27,
                fontFamily: "Inconsolata",
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),),
              SizedBox(
                width:25.0,
              ),
              FaIcon(FontAwesomeIcons.networkWired,color: Colors.black,size:30,),
            ],
          ),
          backgroundColor: Colors.white60,

        ),
      body:SingleChildScrollView(
          child:ConstrainedBox(
              constraints:BoxConstraints() ,
              child: Home())),
      ),
    ),
  );
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  //List <Widget> resultWidgets =[] ;
 String net = '0.0.0.0';
 String broad = '0.0.0.0';
 String first = '0.0.0.0';
 String last = '0.0.0.0';
 String hosts ='0';
 String prefix='0';

 final _text1 = TextEditingController();
 final _text2 = TextEditingController();

 bool _validate1 = true;
 bool _validate2 = true;

 String _ermsg1 = '';
 String _ermsg2 = '';


 RegExp ipPattern = new RegExp(r"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)");

 bool validateIp(String ip){
   return ipPattern.hasMatch(ip);
 }

 @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _text1,
                maxLength:15,
                style: TextStyle(
                    fontFamily: "Inconsolata",
                    color: Colors.green,
                    fontSize: 20
                ),
                decoration:InputDecoration(
                  errorText:_validate1?null:_ermsg1,
                  hintText:'0.0.0.0',
                  hintStyle:TextStyle(
                      fontFamily: "Inconsolata",
                      color: Colors.greenAccent
                  ),
                  labelStyle:TextStyle(
                    fontFamily: "Inconsolata",
                    color:Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.white,style:BorderStyle.solid)
                  ),
                  labelText:'Enter IP',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLength:15,
                controller:_text2,
                style:TextStyle(
                  fontFamily: "Inconsolata",
                  color: Colors.green,
                  fontSize: 20,
                ),
                decoration:InputDecoration(
                  errorText:_validate2?null:_ermsg2,
                  hintText:'0.0.0.0',
                  hintStyle:TextStyle(
                      fontFamily: "Inconsolata",
                      color:Colors.greenAccent
                  ),
                  labelStyle:TextStyle(
                    fontFamily: "Inconsolata",
                    color: Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(
                        color:Colors.white)
                  ),
                  labelText:'Enter Subnet Mask',
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: RaisedButton(
            onPressed:(){
              setState(() {

                if(!validateIp(_text1.text)){
                  _validate1 = false;
                  _ermsg1 ='Invalid IP' ;
                }else{
                  _validate1 = true;
                }

                if(!validateIp(_text2.text)){
                  _validate2=false;
                  _ermsg2 ='Invalid Subnet' ;
                }else{
                  _validate2 = true;
                }
                if(_validate1==true && _validate2==true){
                  try {
                    IpAddressCalc.calculate(_text1.text, _text2.text);
                    net = IpAddressCalc.arrToString(
                        IpAddressCalc.net_s, IpAddressCalc.net);
                    broad = IpAddressCalc.arrToString(
                        IpAddressCalc.broad_s, IpAddressCalc.broad);
                    first = IpAddressCalc.arrToString(
                        IpAddressCalc.first_s, IpAddressCalc.first);
                    last = IpAddressCalc.arrToString(
                        IpAddressCalc.last_s, IpAddressCalc.last);
                    hosts = (IpAddressCalc.hosts - 2).toString();
                    prefix = IpAddressCalc.prefix.toString();
                  }catch(e){
                    _validate2=false;
                    _ermsg2='Invalid Subnet';
                  }
                  }
                print("button pressed");
              });
            } ,
          color: Colors.green,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text('calculate',
          style: TextStyle(
            fontFamily: "Inconsolata",
            color: Colors.white,
            fontSize: 20,
          ),),),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height:5,
            color:Colors.white70,
            width:double.maxFinite,
          ),
        ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Container(
               width: double.maxFinite,
               decoration:BoxDecoration(
                 borderRadius:BorderRadius.circular(10),
                 border:Border.all(color: Colors.white70),
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text('Network IP : $net',
                     style: TextStyle(
                       fontFamily: "Inconsolata",
                       color: Colors.green,
                       fontSize:20,
                     ),
                     ),
                     Text('Broadcast IP : $broad',
                       style: TextStyle(
                         fontFamily: "Inconsolata",
                         color: Colors.green,
                         fontSize:20,
                       ),
                     ),Text('First IP : $first',
                       style: TextStyle(
                         fontFamily: "Inconsolata",
                         color: Colors.green,
                         fontSize:20,
                       ),
                     ),Text('Last IP : $last',
                       style: TextStyle(
                         fontFamily: "Inconsolata",
                         color: Colors.green,
                         fontSize:20,
                       ),
                     ),
                     Text('Hosts : $hosts',
                       style: TextStyle(
                         fontFamily: "Inconsolata",
                         color: Colors.green,
                         fontSize:20,
                       ),
                     ),
                     Text('Prefix : $prefix',
                       style: TextStyle(
                         fontFamily: "Inconsolata",
                         color: Colors.green,
                         fontSize:20,
                       ),
                     ),
                   ],
                 ),
               ),
             ),
              SizedBox(
                height:20,
              ),
              Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width:80,
                  ),
                  FaIcon(FontAwesomeIcons.github,size:30,color: Colors.green,),
                  SizedBox(width:20,),
                  FlatButton(
                    padding:EdgeInsets.all(0.0),
                    onPressed:()async{
                      const url = 'https://github.com/viruchith';
                      if(await canLaunch(url)){
                            await launch(url);
                      }else{
                        throw 'could not launch $url';
                      }
                    },
                    child: Text('@viruchith',
                    style:TextStyle(
                      fontSize:25,
                      color: Colors.green,
                      fontFamily:'Inconsolata'
                    ),),
                  )
                ],
              )
            ],
        ),
      )
      ],
    );
  }
}

