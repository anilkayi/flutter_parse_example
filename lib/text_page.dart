
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class TextPage extends StatefulWidget {
  const TextPage({ Key? key }) : super(key: key);

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {

TextEditingController name=TextEditingController();
TextEditingController surname=TextEditingController();
TextEditingController age=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      
    ),
      body: SafeArea(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
       
      textFormField(name,'Name'),
      textFormField(surname,'Surname'),
      textFormField(age,'Age'),

      ElevatedButton(onPressed: send, child: Text('Save')),


      ],),),
    );
  }

  TextFormField textFormField(TextEditingController controller,String text) => TextFormField(
controller: controller,decoration: InputDecoration(hintText: text,
 enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
),

);
void send()async{
    
      var firstObject = ParseObject('Realtime')
    ..set(
        'name', 'Name:${name.text}')..set('Surname', 'Surname:${surname.text}')..set(
        'age', 'Age:${int.tryParse(age.text)}');

      
      await firstObject.save();
    print('Succes');
  }
}

