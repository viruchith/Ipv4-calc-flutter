class IpAddressCalc{

static var ip_s = new List(4);
static var sub_s =new List(4);
static var ip_i = new List(4);
static var sub_i = new List(4);

static var net =new List(4);
static var first = new List(4);
static var broad = new List(4);
static var last = new List(4);

static var prefix = 0;
static var hosts = 1;
static var flag = 0;


static var net_s ='';
static var first_s ='';
static var broad_s ='';
static var last_s='';


static var netDict={255:8,254:7,252:6,248:5,240:4,224:3,192:2,128:1,0:0};

static var addrDict={255:1,254:2,252:4,248:8,240:16,224:32,192:64,128:128,0:256};




static void strToInt(List arr1,List arr2){
for(int i=0;i<4;i++){
arr2[i] = int.parse(arr1[i]);
}
}

static void printArr(List arr){
for(var i in arr){
print(i);
}
}


static void firstIp(){
for(var i=0;i<4;i++){

if(flag==0 && sub_i[i]!=255){
first[i]=(ip_i[i]&sub_i[i])+1;
flag=1;
}else{
first[i] = ip_i[i];
}

if(sub_i[i]!=255){
net[i]=ip_i[i]&sub_i[i];
prefix+=netDict[sub_i[i]];
}
else{
net[i]=ip_i[i];
prefix+=netDict[sub_i[i]];
}

}
print(net);
print(first);
print(prefix);

}

static void broadcast(){

for(int i=0;i<4;i++){

if(sub_i[i]!=255){
broad[i] = (net[i]+addrDict[sub_i[i]])-1;
last[i]= broad[i];
hosts=hosts * addrDict[sub_i[i]];
}else{
broad[i]=net[i];
last[i]= broad[i];
}
}
last[3]= broad[3]-1;
print(broad);
print(hosts-2);
}

static String arrToString(String output,List arr){
  for(int i = 0;i<3;i++){
    output+=(arr[i].toString()+'.');
  }
  output+=arr[3].toString();
  return output;
}
static void calculate(String inp1,String inp2){
  ip_s=inp1.split('.');
  sub_s=inp2.split('.');

  prefix=0;
  hosts=1;
  flag=0;

  net_s='';
  first_s='';
  broad_s='';
  last_s='';

  strToInt(IpAddressCalc.ip_s,IpAddressCalc.ip_i);
  strToInt(IpAddressCalc.sub_s,IpAddressCalc.sub_i);
  firstIp();
  broadcast();

}


}


