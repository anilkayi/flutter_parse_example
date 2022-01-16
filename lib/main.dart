import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_parse_example/parse_provider.dart';
import 'package:flutter_parse_example/text_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await ParseProvider().initParse();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


 late Subscription subscription;
 late LiveQuery liveQuery; 
 late Map<String,ParseObject> obj;
 static StreamController<ParseObject> parseDataController = StreamController<ParseObject>.broadcast();
 static Stream<ParseObject> get parseStream => parseDataController.stream;
 DateTime? first;
  DateTime? last;
  Timer? timer;
  late StreamSubscription measurementSubs;


@override
  void initState() {
measurementSubs=parseStream.listen((p) {
     print('Value from controller: $p');
     DateTime time = DateTime.now();
     obj.addAll({time.toString():p});

    
    });
obj={};
    
  
   startLiveQuery();
    super.initState();
  }

void startLiveQuery()async {
   liveQuery=LiveQuery();
  QueryBuilder<ParseObject> query =QueryBuilder<ParseObject>(ParseObject('Realtime'));
   subscription = await liveQuery.client.subscribe(query);
DateTime t=DateTime.now();
      first??=t;
      last=t;
 
   subscription.on(LiveQueryEvent.create, (ParseObject value) {
      DateTime t=DateTime.now();
        first??=t;
        last=t;
    print('*** CREATE ***: ${DateTime.now().toString()}\n $value ');
   parseDataController.add(value);
       setState(() {
       });

});

}
/*void send()async{
    var rng = Random();
      var firstObject = ParseObject('Realtime')
    ..set(
        'type', 'random:${rng.nextInt(100)}')..set('name', 'denemelik:${rng.nextInt(100)}')  ;

      
      await firstObject.save();
    print('Succes');
  }*/



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parse Example'),
      ),
      body: StreamBuilder<ParseObject>(
        stream: parseStream,
        builder: (context, snapshot) {

          if(!snapshot.hasData){
 return Center(child: CircularProgressIndicator(),);
          }else{
    return ListView.builder(itemCount: obj.length,itemBuilder: (context,index){
 ParseObject parseObject=obj.entries.toList()[index].value;

return Card(child: Text(' ${parseObject['name']}  ${parseObject['Surname']}  ${parseObject['age']} '),);
 });
        }}),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TextPage()));
      }
      
      ,child: Icon(Icons.add),),
      
    );
  }
}
