import 'package:KimochiApps/src/models/makananModels.dart';
import 'package:KimochiApps/src/ui/util/const.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class MakananProvider {
  Client client = Client();
  final url = Constants.server + 'getMakananOffset';
  final url1 = Constants.server + 'addMakanan';

  Future<List<Makanan>> getMakanan(int s, int off) async {
    final response =
        await client.get(url + "/" + s.toString() + "/" + off.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return compute(makananFromJson, response.body);
    } else {
      throw Exception('Failed');
    }
  }

  Future saved(title) async {
    print(title);
    final res = await client.post(url1, body: {"nama": title});
    if (res.statusCode == 200) {
      print(res.body);
      return res.body;
    } else {
      throw Exception('Failed');
    }
  }
}
