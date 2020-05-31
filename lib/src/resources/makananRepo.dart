
import 'package:KimochiApps/src/models/makananModels.dart';
import 'package:KimochiApps/src/resources/makananProvider.dart';
import 'dart:async';

class MakananRepo{
  final makananProvider = MakananProvider();
   Future<List<Makanan>> getMakanan(int s,int off) async{
    return makananProvider.getMakanan(s,off);
  }
  Future saved(String nama) async {
    makananProvider.saved(nama);
  }
  // Future<List<Makanan>> getMakanan() => makananProvider.getMakanan();
  // Future saved(String nama)=>makananProvider.saved(nama);
}