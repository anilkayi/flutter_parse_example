import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';



class ParseProvider {

  final Parse parse=Parse();

ParseProvider();
 static const String _baseUrl = 'https://parseapi.back4app.com/classes/';
 Future<void> initParse() async {
   final keyApplicationId = 'rNApgx4R7DlRuPBTZAqVhfyiiYSscPEmHtU97C8K';
  final keyClientKey = 'enoRetzRdCrLu7Zgoawa6YfP7Lt9CRMjtYtWMwAJ';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
     keyApplicationId,
     keyParseServerUrl,
      clientKey: keyClientKey, 
      autoSendSessionId: true,
      liveQueryUrl: 'https://parselivequery.b4a.io');
  }

}