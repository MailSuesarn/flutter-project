import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkUnsplash {
  NetworkUnsplash(this.url);

  final Uri url;

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      // var decodeData = jsonDecode(data);
      var decodeData = json.decode(data);
      // print(decodeData['results'][0]['urls']['regular'].toString());

      return decodeData;
    } else {
      print('++++++++++++++++++++++++++++++++++++++++');
      print(response.statusCode);
    }
  }
}


