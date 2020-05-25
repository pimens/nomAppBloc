import 'package:KimochiApps/src/models/CabangModels.dart';
import 'package:flutter/foundation.dart';
import 'package:KimochiApps/src/ui/util/const.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class CabangProvider {
  Client client = Client();
  final url = Constants.server + 'Api/getCabang';

  Future<List<Cabang>> getCabang() async {
    final response = await client.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      return compute(cabangFromJson, response.body);
    } else {
      throw Exception('Failed');
    }
  }
}
