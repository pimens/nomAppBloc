import 'package:KimochiApps/src/models/TrxModels.dart';
import 'package:flutter/foundation.dart';
import 'package:KimochiApps/src/ui/util/const.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class GlobalProvider {
  Client client = Client();
  final url = Constants.server + 'Api/getTrxById/';
  //DETAILORDER
  Future<List<Trx>> getDetailOrder(String id) async {
    final response = await client.get(url+id);
    if (response.statusCode == 200) {
      print(response.body);
      return compute(trxFromJson, response.body);
    } else {
      throw Exception('Failed');
    }
  }
  Future delete(String notrx) async {
    var hasil = await client.get(
        Uri.encodeFull(Constants.server + "Api/deleteTrx/" + notrx),
        headers: {"Accept": "application/json"});
  }
}