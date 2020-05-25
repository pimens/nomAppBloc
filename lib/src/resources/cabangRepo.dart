
import 'package:KimochiApps/src/models/CabangModels.dart';
import 'package:KimochiApps/src/resources/cabangProvider.dart';
import 'dart:async';

class CabangRepo{
  final cabangProvider = CabangProvider();
   Future<List<Cabang>> getCabang() async{
    return cabangProvider.getCabang();
  }
  // Future<List<Makanan>> getMakanan() => makananProvider.getMakanan();
  // Future saved(String nama)=>makananProvider.saved(nama);
}