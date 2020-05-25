import 'package:KimochiApps/src/models/TrxModels.dart';
import 'dart:async';
import 'globalProvider.dart';

class GlobalRepo{
  final gProvider = GlobalProvider();
   Future<List<Trx>> getDetailOrder(String id) async{
    return gProvider.getDetailOrder(id);
  }
  Future delete(String notrx) async{
    return gProvider.delete(notrx);
  }
  // Future<List<Makanan>> getMakanan() => makananProvider.getMakanan();
  // Future saved(String nama)=>makananProvider.saved(nama);
}