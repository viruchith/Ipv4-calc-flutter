import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';
import 'calc.dart';


void main() {
  runApp(AppTabBar());
}


class AppTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: DefaultTabController(
        length:3,
        child: Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            centerTitle: true,
            leading:null,
            bottom:TabBar(
                tabs:[
                  Tab(
                    icon:FaIcon(FontAwesomeIcons.networkWired,size:25,color: Colors.black,),
                  ),
                  Tab(
                    icon:FaIcon(FontAwesomeIcons.globe,size:25,color: Colors.black,),
                  ),
                  Tab(
                    icon:FaIcon(FontAwesomeIcons.wifi,size:25,color: Colors.black,)
                  )
                ] ),
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
                FaIcon(FontAwesomeIcons.networkWired,color:Colors.black,size:27),
              ],
            ),
            backgroundColor: Colors.white60,

          ),
          body:TabBarView(
            children: <Widget>[
              SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints:BoxConstraints(),
                      child: Home())),
              SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints:BoxConstraints(),
                      child: AddressToIp())),
              SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints:BoxConstraints(),
                      child: WifiInfo())),
            ],
          ),
        ),
      ),
    ) ;
  }
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

class AddressToIp extends StatefulWidget {
  @override
  _AddressToIpState createState() => _AddressToIpState();
}

class _AddressToIpState extends State<AddressToIp> {

  String _domain_ip = '0.0.0';

  final _text1 = TextEditingController();

  bool _validate1 = true;

  String _ermsg = '';

  RegExp _pattern = new RegExp(r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');

  //void getIp() async{

//}


  @override
  Widget build(BuildContext context) {
    return Center(
      child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child:Text('URL --> IP',
              style:TextStyle(
                fontFamily: "Inconsolata",
                fontSize: 25,
                color: Colors.white
              ),),
            ),
            SizedBox(
              height:20,
            ),
            TextField(
              maxLength:30,
              controller: _text1,
              style: TextStyle(
                  fontFamily: "Inconsolata",
                  color: Colors.green,
                  fontSize:20
              ),
              decoration:InputDecoration(
                hintText:'www.example.com',
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
                labelText:'Enter web address',
                errorText:_validate1?null: _ermsg,
              ),
            ),
            SizedBox(
              height:20,
            ),
            Text('IP : $_domain_ip',
              style:TextStyle(
                  fontSize:23,
                  color: Colors.green,
                  fontFamily:'Inconsolata'
              ),),
            SizedBox(
              height:20,
            ),
            RaisedButton(
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
                onPressed:()async{
                  _validate1 = true;
                  _domain_ip = '0.0.0.0';
                  if(_text1.text.isEmpty){
                    _ermsg = 'cannot be empty' ;
                    _validate1 = false;
                  }
                  else if(_pattern.hasMatch(_text1.text)){

                    try{
                      final result = await InternetAddress.lookup(_text1.text);
                      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                        print('connected');
                        print(result[0].address);
                        _domain_ip = result[0].address;
                      }else{
                        _validate1 = false;
                        _ermsg = 'Invalid url !' ;
                      }
                    }on SocketException catch(_){
                      _validate1 = false;
                      _ermsg = 'try again !' ;
                      print('Eroor........');
                    }


                  }else{
                    _ermsg = 'address format : www.example.domain';
                    _validate1 = false;
                  }
                  setState(() {

                    print('Entered state');

                  });

                },
              color:Colors.green,
              child:FaIcon(
                FontAwesomeIcons.search,
                size:25,
                color:Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text('Check internet connectivity before using',
                  style:TextStyle(
                  fontSize:15,
                  color: Colors.yellowAccent,
                  fontFamily:'Inconsolata'
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class WifiInfo extends StatefulWidget {
  @override
  _WifiInfoState createState() => _WifiInfoState();
}

class _WifiInfoState extends State<WifiInfo> {

  String _ipAddress='0.0.0.0',_routerIp='0.0.0.0',_macAddress='NA',_dns1='0.0.0.0',_dns2='0.0.0.0',_ssid='NA',_frequency='0',_connectionType='NA',_bssid='NA',_linkspeed='0';
  WifiInfoWrapper _wifiObject;


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    WifiInfoWrapper wifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await  WifiInfoPlugin.wifiDetails;

    }
    on PlatformException{

    }
    if (!mounted) return;

    setState(() {

      _wifiObject = wifiObject;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('IP : '+_ipAddress,
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
              SizedBox(
                height:10,
              ),
              Container(
                width:double.maxFinite,
                height:2,
                color:Colors.white70,
              ),
              Text('Gateway : '+_routerIp,
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
              SizedBox(
                height:10,
              ),
              Container(
                width:double.maxFinite,
                height:2,
                color:Colors.white70,
              ),
              Text('MacAddress : '+_macAddress,
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
              SizedBox(
                height:10,
              ),
              Container(
                width:double.maxFinite,
                height:2,
                color:Colors.white70,
              ),
              Text('DNS 1 : '+_dns1,
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
              SizedBox(
                height:10,
              ),
              Container(
                width:double.maxFinite,
                height:2,
                color:Colors.white70,
              ),
              Text('DNS 2 : '+_dns2,
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
              SizedBox(
                height:10,
              ),
              Container(
                width:double.maxFinite,
                height:2,
                color:Colors.white70,
              ),
              Text('BSSID : '+_bssid,
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
              SizedBox(
                height:10,
              ),
              Container(
                width:double.maxFinite,
                height:2,
                color:Colors.white70,
              ),
              Text('SSID : '+_ssid,
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
              SizedBox(
                height:10,
              ),
              Container(
                width:double.maxFinite,
                height:2,
                color:Colors.white70,
              ),
              Text('Connection type : '+_connectionType,
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
              SizedBox(
                height:10,
              ),
              Container(
                width:double.maxFinite,
                height:2,
                color:Colors.white70,
              ),
              Text('Frequency : '+_frequency+' MHz',
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
              SizedBox(
                height:10,
              ),
              Container(
                width:double.maxFinite,
                height:2,
                color:Colors.white70,
              ),
              Text('Speed : '+_linkspeed+' Kbps',
                style:TextStyle(
                    fontSize:23,
                    color: Colors.green,
                    fontFamily:'Inconsolata'
                ),),
            ],
          ),
          SizedBox(
            height:10,
          ),
          Container(
            width:double.maxFinite,
            height:2,
            color:Colors.white70,
          ),
        SizedBox(
          height:25,
        ),
        Center(
          child: RaisedButton(
            color:Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child:Text("Get",
              style: TextStyle(
                  fontSize:23,
                  color: Colors.white,
                  fontFamily:'Inconsolata'
              ),),
            onPressed:() async{

              // Platform messages may fail, so we use a try/catch PlatformException.

              setState(() {

                _ipAddress = _wifiObject.ipAddress.toString();
                _routerIp = _wifiObject.routerIp.toString();
                _macAddress = _wifiObject.macAddress.toString();
                _dns1 = _wifiObject.dns1.toString();
                _dns2 = _wifiObject.dns2.toString();
                _ssid = _wifiObject.ssid.toString();
                _frequency = _wifiObject.frequency.toString();
                _connectionType = _wifiObject.connectionType.toString();
                _bssid = _wifiObject.bssId.toString();
                _linkspeed = _wifiObject.linkSpeed.toString();

              });
            }
            ,
          ),
        )
        ],
      ),
    );
  }
}
